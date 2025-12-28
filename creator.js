import fs from "fs-extra";
import OpenAI from "openai";
import "dotenv/config";

const openai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });

const PROJECT_STYLE = process.env.PROJECT_STYLE || "defi";

const FILE_TYPES = ["contract", "test", "script", "docs"];

function rand(arr) {
  return arr[Math.floor(Math.random() * arr.length)];
}

async function generateFileContent(fileType) {
  let prompt;

  switch(fileType) {
    case "contract":
      prompt = `Write a short, realistic ${PROJECT_STYLE} Solidity smart contract snippet. Include 1-2 functions, use best practices, and add minimal comments.`;
      break;
    case "test":
      prompt = `Write a small test for a ${PROJECT_STYLE} Solidity contract using forge-std or Hardhat.`;
      break;
    case "script":
      prompt = `Write a small deployment or simulation script for a ${PROJECT_STYLE} Solidity contract.`;
      break;
    case "docs":
      prompt = `Write a short technical documentation note for a ${PROJECT_STYLE} blockchain project.`;
      break;
    default:
      prompt = `Write a short technical snippet.`;
  }

  const response = await openai.chat.completions.create({
    model: "gpt-4.1-mini",
    messages: [{ role: "user", content: prompt }],
    max_tokens: 300,
    temperature: 0.5
  });

  return response.choices[0].message.content.trim();
}

export async function generateCryptoFile() {
  const type = rand(FILE_TYPES);

  let filePath;
  if (type === "contract") filePath = `contracts/${PROJECT_STYLE}/Contract${Date.now()}.sol`;
  if (type === "test") filePath = `test/${PROJECT_STYLE}/Test${Date.now()}.t.sol`;
  if (type === "script") filePath = `scripts/${PROJECT_STYLE}/Script${Date.now()}.s.sol`;
  if (type === "docs") filePath = `docs/${PROJECT_STYLE}/Doc${Date.now()}.md`;

  const content = await generateFileContent(type);
  await fs.outputFile(filePath, content);

  return { filePath, type, content };
}
