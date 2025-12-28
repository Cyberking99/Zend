import fs from "fs";

function rand(arr) { return arr[Math.floor(Math.random() * arr.length)]; }

const PROJECT_TYPE = process.env.PROJECT_TYPE || "defi"; // defi, l2, mev

export function generateChange() {
  let file, content, summary;

  if (PROJECT_TYPE === "defi") {
    const type = rand(["contract", "test", "script", "docs"]);
    if (type === "contract") {
      file = `contracts/vault/Vault${Date.now()}.sol`;
      content = `// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Vault${Date.now()} {
    uint256 public totalStaked;
    function deposit(uint256 amt) external { totalStaked += amt; }
}`;
      summary = "feat: add staking vault";
    } else if (type === "test") {
      file = `test/unit/vault-${Date.now()}.t.sol`;
      content = `pragma solidity ^0.8.19;
import "forge-std/Test.sol";
contract VaultTest is Test { function testDeposit() public {} }`;
      summary = "test: add deposit unit test";
    } else if (type === "script") {
      file = `scripts/deploy/deploy-vault-${Date.now()}.s.sol`;
      content = `pragma solidity ^0.8.19; contract Deploy { function run() external {} }`;
      summary = "chore: deploy vault script";
    } else {
      file = `docs/economics/note-${Date.now()}.md`;
      content = `# Vault Economics\n- Lockup: 7 days\n- APR: 12%`;
      summary = "docs: add vault economics note";
    }
  }

  if (PROJECT_TYPE === "l2") {
    const type = rand(["contract", "test", "script", "docs"]);
    if (type === "contract") {
      file = `contracts/rollup/Rollup${Date.now()}.sol`;
      content = `// L2 rollup module\npragma solidity ^0.8.19;\ncontract Rollup${Date.now()} {}`;
      summary = "feat: add rollup module";
    } else if (type === "script") {
      file = `scripts/monitor/monitor-${Date.now()}.ts`;
      content = `// monitor L2 state changes`;
      summary = "chore: add L2 monitor script";
    } else if (type === "test") {
      file = `test/unit/rollup-${Date.now()}.t.sol`;
      content = `// basic rollup tests`;
      summary = "test: rollup unit test";
    } else {
      file = `docs/architecture/rollup-${Date.now()}.md`;
      content = `# Rollup Architecture\n- Sequencer\n- Validator set`;
      summary = "docs: outline rollup architecture";
    }
  }

  if (PROJECT_TYPE === "mev") {
    const type = rand(["contract", "test", "script", "docs"]);
    if (type === "contract") {
      file = `contracts/arbitrage/Bot${Date.now()}.sol`;
      content = `pragma solidity ^0.8.19;\ncontract Bot${Date.now()} {}`;
      summary = "feat: add arbitrage bot module";
    } else if (type === "script") {
      file = `scripts/simulate/simulate-${Date.now()}.ts`;
      content = `// simulate MEV bundles`;
      summary = "chore: simulate bundles script";
    } else if (type === "test") {
      file = `test/unit/bot-${Date.now()}.t.sol`;
      content = `// test bundle execution`;
      summary = "test: add bot unit test";
    } else {
      file = `docs/strategies/note-${Date.now()}.md`;
      content = `# MEV Strategy\n- Sniping\n- Sandwich attacks`;
      summary = "docs: add MEV strategy note";
    }
  }

  fs.mkdirSync(file.split("/").slice(0, -1).join("/"), { recursive: true });
  fs.writeFileSync(file, content);

  return summary;
}
