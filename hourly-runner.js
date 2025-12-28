import { execSync } from "child_process";
import { generateCryptoFile } from "./creator.js";
import OpenAI from "openai";
import "dotenv/config";

const openai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });
const COMMITS = parseInt(process.env.COMMITS_PER_DAY) || 24;
const PROJECT_STYLE = process.env.PROJECT_STYLE || "defi";
const GIT_BRANCH = process.env.GIT_BRANCH || "main";

/**
 * Generate a realistic crypto-style commit message using OpenAI
 */
async function generateCommitMessage(summary) {
  const prompt = `Generate a concise, conventional git commit message for a ${PROJECT_STYLE} blockchain project for this change: ${summary}`;
  const response = await openai.chat.completions.create({
    model: "gpt-4.1-mini",
    messages: [{ role: "user", content: prompt }],
    max_tokens: 20,
    temperature: 0.4
  });
  return response.choices[0].message.content.trim();
}

/**
 * Sleep utility for pacing
 */
function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function main() {
  console.log(`Starting hourly-paced commit bot (${COMMITS} commits)`);

  // Interval = 1 hour / number of commits
  const intervalMs = Math.floor(3600 * 1000 / COMMITS);

  for (let i = 1; i <= COMMITS; i++) {
    const { filePath, type } = await generateCryptoFile();
    const summary = `${type} generated: ${filePath}`;

    const commitMsg = await generateCommitMessage(summary);

    execSync(`git add "${filePath}"`);
    execSync(`git commit -m "${commitMsg}"`);

    console.log(`✔ Commit ${i}/${COMMITS}: ${commitMsg} (${filePath})`);

    if (i < COMMITS) {
      console.log(`⏱ Waiting ${Math.floor(intervalMs / 1000)}s until next commit...`);
      await sleep(intervalMs);
    }
  }

  execSync(`git push origin ${GIT_BRANCH}`);
  console.log("✅ All commits pushed");
}

main().catch(console.error);
