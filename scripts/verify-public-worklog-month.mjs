#!/usr/bin/env node
import fs from "node:fs";
import path from "node:path";

const args = process.argv.slice(2);

function valueAfter(flag) {
  const index = args.indexOf(flag);
  return index === -1 ? null : args[index + 1] || null;
}

const htmlPath = valueAfter("--html");
const month = valueAfter("--month");
const allowUnchecked = new Set((valueAfter("--allow-unchecked") || "").split(",").map((v) => v.trim()).filter(Boolean));
const forbidPlan = args.includes("--forbid-plan");
const allowPlan = new Set((valueAfter("--allow-plan") || "").split(",").map((v) => v.trim()).filter(Boolean));

if (!htmlPath || !month || !/^\d{4}-\d{2}$/.test(month)) {
  console.error("Usage: node scripts/verify-public-worklog-month.mjs --html <site/worklog.html> --month YYYY-MM [--allow-unchecked entry-YYYY-MM-DD,...] [--forbid-plan] [--allow-plan plan-YYYY-MM-DD,...]");
  process.exit(2);
}

const html = fs.readFileSync(path.resolve(htmlPath), "utf8");
const scriptRe = /<script\s+type="text\/plain"\s+id="([^"]+)">([\s\S]*?)<\/script>/g;
const rows = [];
const failures = [];

for (const match of html.matchAll(scriptRe)) {
  const [, id, body] = match;
  const entryMatch = id.match(/^entry-(\d{4}-\d{2})-\d{2}$/);
  const planMatch = id.match(/^plan-(\d{4}-\d{2})-\d{2}$/);
  const isTargetMonth = entryMatch?.[1] === month || planMatch?.[1] === month;
  if (!isTargetMonth) continue;

  const unchecked = (body.match(/\[ \]/g) || []).length;
  rows.push({ id, unchecked });

  if (planMatch && forbidPlan && !allowPlan.has(id)) {
    failures.push(`${id}: plan block is forbidden for ${month}; move follow-up items into entry Next instead`);
  }

  if (unchecked > 0 && !allowUnchecked.has(id)) {
    failures.push(`${id}: ${unchecked} unchecked item(s) not allowed`);
  }
}

if (rows.length === 0) {
  failures.push(`No worklog script blocks found for ${month}`);
}

for (const row of rows) {
  console.log(`${row.id}\tunchecked=${row.unchecked}`);
}

if (failures.length > 0) {
  console.error("\nPublic worklog month verification failed:");
  for (const failure of failures) console.error(`- ${failure}`);
  process.exit(1);
}

console.log(`Public worklog month verification passed for ${month}.`);
