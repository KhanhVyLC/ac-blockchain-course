import crypto from "crypto";

export type Block = {
  index: number;
  timestamp: string;
  transactions: any[];
  previous_hash: string;
  current_hash: string;
};

export function isValidBlock(block: Block): boolean {
  const data = block.index + block.timestamp + JSON.stringify(block.transactions) + block.previous_hash;
  const calculatedHash = crypto.createHash('sha256').update(data).digest('hex');
  return calculatedHash === block.current_hash;
}

// --- ĐOẠN CODE TEST ---
function calculateHash(index: number, timestamp: string, transactions: any[], previous_hash: string): string {
  const value = index + timestamp + JSON.stringify(transactions) + previous_hash;
  return crypto.createHash('sha256').update(value).digest('hex');
}

const block1: Block = {
  index: 0,
  timestamp: "2024-01-01T00:00:00Z",
  transactions: [],
  previous_hash: "0",
  current_hash: ""
};

// Gán hash đúng
block1.current_hash = calculateHash(block1.index, block1.timestamp, block1.transactions, block1.previous_hash);
console.log("✅ Block 1 (đúng):", isValidBlock(block1));

// Đổi thành hash sai
block1.current_hash = "invalid_hash";
console.log("❌ Block 1 (sai):", isValidBlock(block1));