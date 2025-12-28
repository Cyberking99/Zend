import { execSync } from "child_process";
import { generateCryptoChange } from "./creator.js";

const COMMITS = 260;

for (let i = 1; i <= COMMITS; i++) {
  const summary = generateCryptoChange();

  execSync("git add .");
  execSync(`git commit -m "${summary}"`);

  console.log(`✔ ${i}/${COMMITS}: ${summary}`);
}

execSync("git push origin main");
