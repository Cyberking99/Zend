import fs from "fs";

function rand(arr) {
  return arr[Math.floor(Math.random() * arr.length)];
}

export function generateCryptoChange() {
  const type = rand([
    "contract",
    "test",
    "script",
    "docs",
    "config"
  ]);

  let file, content, summary;

  if (type === "contract") {
    file = `contracts/core/Module${Date.now()}.sol`;
    content = `// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/// @notice Experimental module
contract Module${Date.now()} {
    uint256 internal constant BASE_FEE = 1000;

    function compute(uint256 value) external pure returns (uint256) {
        return value * BASE_FEE / 1e4;
    }
}
`;
    summary = "Add experimental core module";
  }

  if (type === "test") {
    file = `test/unit/module-${Date.now()}.t.sol`;
    content = `pragma solidity ^0.8.19;

import "forge-std/Test.sol";

contract ModuleTest is Test {
    function testBasicComputation() public {
        assertEq(2 * 1000 / 1e4, 0);
    }
}
`;
    summary = "Add unit test for module logic";
  }

  if (type === "script") {
    file = `scripts/deploy/deploy-${Date.now()}.s.sol`;
    content = `pragma solidity ^0.8.19;

import "forge-std/Script.sol";

contract Deploy is Script {
    function run() external {
        vm.startBroadcast();
        // deploy steps
        vm.stopBroadcast();
    }
}
`;
    summary = "Add deployment helper script";
  }

  if (type === "docs") {
    file = `docs/architecture/note-${Date.now()}.md`;
    content = `# Architecture Note

This document outlines assumptions around module isolation
and state boundaries.

- Minimal shared storage
- Explicit external calls
- Conservative defaults
`;
    summary = "Document architecture assumptions";
  }

  if (type === "config") {
    file = `config/addresses.json`;
    fs.mkdirSync("config", { recursive: true });
    const data = { updatedAt: new Date().toISOString() };
    fs.writeFileSync(file, JSON.stringify(data, null, 2));
    summary = "Update network address config";
  }

  fs.mkdirSync(file.split("/").slice(0, -1).join("/"), { recursive: true });
  fs.writeFileSync(file, content);

  return summary;
}
