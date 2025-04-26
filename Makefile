# === Configuration ===
PROGRAM_NAME := monpremierprogram
PROGRAM_DIR := programs/$(PROGRAM_NAME)/src
LIB_RS := $(PROGRAM_DIR)/lib.rs
KEYPAIR_PATH := target/deploy/$(PROGRAM_NAME)-keypair.json
CLUSTER ?= localnet
LEDGER_DIR := .localnet-ledger

# Dynamic RPC endpoint based on the cluster
ifeq ($(CLUSTER),localnet)
  PROVIDER_URL := http://127.0.0.1:8899
else ifeq ($(CLUSTER),devnet)
  PROVIDER_URL := https://api.devnet.solana.com
else ifeq ($(CLUSTER),testnet)
  PROVIDER_URL := https://api.testnet.solana.com
else ifeq ($(CLUSTER),mainnet)
  PROVIDER_URL := https://api.mainnet-beta.solana.com
else
  $(error Invalid CLUSTER "$(CLUSTER)". Must be localnet/devnet/testnet/mainnet)
endif

export ANCHOR_PROVIDER_URL=$(PROVIDER_URL)
export ANCHOR_WALLET=/Users/dw33z1lp/.solana/phantom_account.json

# === Commands ===

.PHONY: build deploy force-deploy fix-id test all redeploy explorer \
        localnet-up localnet-down reset-localnet airdrop airdrop-accounts accounts-status \
        localnet-genesis watch logs dashboard-up dashboard-down

## Build the Anchor program
build:
	@echo "🔨 Building the program $(PROGRAM_NAME)..."
	anchor build

## Deploy with fallback if Anchor fails
deploy: build
	@echo "🚀 Deploying to $(CLUSTER) ($(PROVIDER_URL))..."
	@if anchor deploy; then \
		echo "✅ Anchor deployment succeeded."; \
	else \
		echo "⚠️ Anchor deploy failed. Trying solana program deploy..."; \
		solana program deploy --upgrade-authority $$ANCHOR_WALLET target/deploy/$(PROGRAM_NAME).so; \
	fi

## Force direct deploy via solana CLI
force-deploy: build
	@echo "💥 Force deployment via solana program deploy..."
	solana program deploy --upgrade-authority $$ANCHOR_WALLET target/deploy/$(PROGRAM_NAME).so

## Update declare_id! in lib.rs automatically
fix-id:
	@echo "🔧 Updating declare_id! in $(LIB_RS)..."
	@PROGRAM_ID=$$(solana address -k $(KEYPAIR_PATH)) && \
	sed -i '' "s/declare_id!(\".*\");/declare_id!(\"$$PROGRAM_ID\");/" $(LIB_RS) && \
	echo "✅ Program ID updated: $$PROGRAM_ID" && \
	echo "🔨 Rebuilding..." && \
	anchor build

## Run tests
test:
	@echo "🧪 Running tests on $(CLUSTER) ($(PROVIDER_URL))..."
	npx dotenv -e .env -- yarn test

## Full cycle: deploy + fix-id + test
all: deploy fix-id test

## Full forced redeployment
redeploy: force-deploy fix-id test

## Open Solana Explorer with the deployed program
explorer:
	@PROGRAM_ID=$$(solana address -k $(KEYPAIR_PATH)) && \
	open "https://explorer.solana.com/address/$$PROGRAM_ID?cluster=$(CLUSTER)"

# === Localnet Management ===

## Start a simple solana-test-validator
localnet-up:
	@echo "🚀 Starting solana-test-validator..."
	@solana-test-validator --ledger $(LEDGER_DIR) --reset

## Kill any running solana-test-validator
localnet-down:
	@echo "🛑 Stopping solana-test-validator..."
	@pkill -f solana-test-validator || true

## Reset localnet ledger
reset-localnet:
	@echo "♻️ Resetting localnet ledger..."
	@rm -rf $(LEDGER_DIR)

## Airdrop 100 SOL to main wallet
airdrop:
	@echo "💰 Airdropping 100 SOL to $(ANCHOR_WALLET)..."
	@solana airdrop 100

## Airdrop 100 SOL to custom accounts
airdrop-accounts:
	@echo "💸 Airdropping 100 SOL to Account1 and Account2..."
	@solana airdrop 100 $$(solana-keygen pubkey Account1-keypair.json) || true
	@solana airdrop 100 $$(solana-keygen pubkey Account2-keypair.json) || true

## Show balance of custom accounts
accounts-status:
	@echo "📊 Checking balances for custom accounts..."
	@solana balance $$(solana-keygen pubkey Account1-keypair.json) || true
	@solana balance $$(solana-keygen pubkey Account2-keypair.json) || true

## Start localnet with accounts + airdrop automatically
localnet-genesis:
	@echo "🚀 Starting solana-test-validator with custom accounts..."
	@solana-test-validator --ledger $(LEDGER_DIR) --reset \
		--account $$(solana-keygen pubkey Account1-keypair.json):Account1-keypair.json \
		--account $$(solana-keygen pubkey Account2-keypair.json):Account2-keypair.json &
	sleep 5
	make airdrop-accounts
	make accounts-status

# === Dev tools ===

## Auto watch build + deploy on Rust file changes
watch:
	@echo "👀 Watching for changes..."
	@cargo install cargo-watch || true
	@cargo watch -s 'make all'

## Tail validator logs
logs:
	@echo "📜 Showing validator logs..."
	@tail -f $(LEDGER_DIR)/validator.log

# === Dashboard Explorer ===

## Launch a local Solana dashboard explorer
dashboard-up:
	@echo "🌐 Launching dashboard explorer at port 3000..."
	docker run -d -p 3000:3000 \
	-e REACT_APP_CLUSTER=custom \
	-e REACT_APP_CUSTOM_URL=http://localhost:8899 \
	blockexplorer/solana-block-explorer

## Stop the dashboard explorer
dashboard-down:
	@echo "🛑 Stopping dashboard explorer..."
	@docker stop $$(docker ps -q --filter ancestor=blockexplorer/solana-block-explorer) || true