# 🛠 Solana Starter Template

## 🚀 About

This is a GitHub template for creating Solana smart contracts using [Anchor](https://book.anchor-lang.com/).
It provides a complete development environment with:
- Localnet setup
- Faucet management
- Dashboard explorer
- Professional Makefile for development and deployment
- GitHub templates for issues and pull requests

## ⚡ Quickstart

### 1. Create a New Project

Click the "Use this template" button above to create a new repository based on this template.

### 2. Install Requirements
- Rust
- Solana CLI
- Anchor CLI
- Node.js (with Yarn or NPM)

### 3. Clone and Setup

```bash
git clone <your-new-repo-url>
cd <your-new-repo-name>
anchor init <your_program_name>
cp ../Anchor.toml ../Cargo.toml ../package.json ../tsconfig.json .
cp -r ../programs ../tests ../migrations .
yarn install
cargo install cargo-watch
yarn add -D dotenv-cli
```

### 4. Setup Localnet Accounts (Optional but Recommended)

```bash
solana-keygen new --outfile Account1-keypair.json
solana-keygen new --outfile Account2-keypair.json
```

---

## 📦 Development Commands

| Action | Command |
|:---|:---|
| Build the program | `make build` |
| Deploy (auto fallback) | `make deploy` |
| Update `declare_id!()` | `make fix-id` |
| Run tests (TypeScript) | `make test` |
| Full cycle (build + deploy + test) | `make all` |
| Force redeployment | `make redeploy` |
| Open in Solana Explorer | `make explorer` |

---

## 🌐 Local Development

### Launch a Localnet Validator

```bash
make localnet-genesis
```
✅ This will:
- Start a local validator
- Load `Account1` and `Account2`
- Airdrop 100 SOL to each account
- Display their balances

### Open a Local Dashboard Explorer (optional)

```bash
make dashboard-up
```

Then visit http://localhost:3000 to explore your localnet visually!

---

## 👀 Development Watch Mode

Automatically rebuild, deploy, and test when you modify your Rust files:

```bash
make watch
```

---

## 📊 Monitor Validator Logs

```bash
make logs
```

---

## 🚀 Deploying to Testnet / Devnet / Mainnet

To switch cluster:

```bash
make all CLUSTER=testnet
make all CLUSTER=devnet
make all CLUSTER=mainnet
```

or set it in your Anchor.toml.

---

## 🤝 Contributing

We welcome contributions! Please read our [Contributing Guidelines](CONTRIBUTING.md) before submitting pull requests.

### Issue Templates
- 🐛 [Bug Report](.github/ISSUE_TEMPLATE/bug_report.md)
- ✨ [Feature Request](.github/ISSUE_TEMPLATE/feature_request.md)

### Pull Request Template
- 📝 [PR Template](.github/PULL_REQUEST_TEMPLATE.md)

---

## 🧠 Best Practices

- Always work locally first with `make localnet-genesis`
- Always run `make fix-id` after first deploy to sync your program ID
- Use `make airdrop` to refill your accounts if needed
- Regularly check `make logs` to debug transactions
- Deploy only on Testnet once local tests pass!

---

## ⚙️ Advanced Features (already setup)

- Local Faucet (airdrop accounts automatically)
- Explorer Dashboard
- Auto deploy fallback if Anchor fails
- Makefile driven workflow
- Genesis accounts loading
- Local cluster reset anytime

---

## 📜 License

MIT License.  
Feel free to use this template for your Solana/Anchor projects.

---

# 🚀 Happy Building on Solana!
