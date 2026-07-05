import assert from "node:assert/strict";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const snapshotsDir = path.resolve(__dirname, "..", "snapshots");
const shouldUpdate = process.env.UPDATE_SNAPSHOTS === "1";

// Timestamps like `updatedAt` reflect filesystem mtime, which differs on
// every checkout/copy and can never be pinned to a literal value across
// environments. Match on shape (ISO 8601), not key name, so sibling fields
// like `metadataSources.updatedAt` ("mtime" | "git") stay untouched.
const ISO_TIMESTAMP_PATTERN = /^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(\.\d+)?(Z|[+-]\d{2}:\d{2})$/;

function redactVolatileFields(value) {
  if (Array.isArray(value)) {
    return value.map(redactVolatileFields);
  }
  if (value && typeof value === "object") {
    const result = {};
    for (const [key, entry] of Object.entries(value)) {
      result[key] =
        typeof entry === "string" && ISO_TIMESTAMP_PATTERN.test(entry) ? "<timestamp>" : redactVolatileFields(entry);
    }
    return result;
  }
  return value;
}

export function assertMatchesSnapshot(snapshotName, value) {
  const filePath = path.join(snapshotsDir, `${snapshotName}.json`);
  const serialized = `${JSON.stringify(redactVolatileFields(value), null, 2)}\n`;

  if (shouldUpdate) {
    fs.mkdirSync(path.dirname(filePath), { recursive: true });
    fs.writeFileSync(filePath, serialized, "utf8");
    return;
  }

  const expected = fs.readFileSync(filePath, "utf8");
  assert.equal(serialized, expected, `Snapshot mismatch: ${snapshotName}`);
}
