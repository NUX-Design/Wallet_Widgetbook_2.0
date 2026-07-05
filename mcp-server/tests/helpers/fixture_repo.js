import fs from "fs";
import os from "os";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const sourceFixtureRoot = path.resolve(__dirname, "..", "fixtures", "widget_repo");

// Copied outside the real project's git tree so metadata extraction always
// hits the "no git history" mtime fallback, regardless of whether the
// fixture sources themselves are tracked in this repo's git history.
const isolatedRoot = fs.mkdtempSync(path.join(os.tmpdir(), "mcp-widget-fixture-"));
fs.cpSync(sourceFixtureRoot, isolatedRoot, { recursive: true });

export const fixtureProjectRoot = isolatedRoot;
