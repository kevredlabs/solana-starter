# 🛠 Solana Starter Template

## 🚀 About

This is a GitHub template for creating Solana smart contracts using [Anchor](https://book.anchor-lang.com/).
It provides a complete development environment with:
- Localnet setup
- Faucet management
- Dashboard explorer
- Professional Makefile for development and deployment
- GitHub templates for issues and pull requests

---

## 📂 Project Structure

```programs/
  myproject/          # Rust smart contract
tests/
  myproject.ts        # Anchor TypeScript tests
migrations/
  deploy.ts           # Custom deploy scripts (optional)
Makefile              # Project automation
Anchor.toml           # Anchor configuration
genesis.json          # Localnet custom accounts
Account1-keypair.json # Pre-generated account keypair
Account2-keypair.json
package.json          # TypeScript dependencies
tsconfig.json
README.md             # This file
```

---

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
yarn install
cargo install cargo-watch
yarn add -D dotenv-cli
```

### 4. Setup Localnet Accounts (Optional but Recommended)

```bash
solana-keygen new --outfile Account1-keypair.json
solana-keygen new --outfile Account2-keypair.json
```

### 5. Initialize Anchor Project

Initialize Anchor with a valid program name:

```bash
anchor init <your_program_name>
```

This will create a new directory with your program name. If you want to keep everything in the current directory, you can move the files:

```bash
mv <your_program_name>/* .
rmdir <your_program_name>
```

This command will:
- Create the Anchor project structure in the current directory
- Set up the necessary configuration files (Anchor.toml, etc.)
- Initialize a new Rust program
- Create a basic test file

The template files (Makefile, genesis.json, etc.) will remain in place, and Anchor will add its own files alongside them.

⚠️ **Note**: The project will be named after your current directory. If you want to change the project name:
1. Rename your directory first: `mv solana-starter my-new-project-name`
2. Then run `anchor init .` in the new directory

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


