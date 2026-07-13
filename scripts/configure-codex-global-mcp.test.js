import assert from "node:assert/strict";
import { execFileSync } from "node:child_process";
import { chmodSync, mkdtempSync, readFileSync, statSync, writeFileSync } from "node:fs";
import { tmpdir } from "node:os";
import { join, resolve } from "node:path";
import test from "node:test";

test("configures Codex global MCP with the verified authorization header", () => {
  const root = mkdtempSync(join(tmpdir(), "codex-global-mcp-"));
  const binDir = join(root, "bin");
  const codexHome = join(root, ".codex");
  const fakeCodex = join(binDir, "codex");

  execFileSync("mkdir", ["-p", binDir, codexHome]);
  writeFileSync(
    fakeCodex,
    `#!/usr/bin/env bash
set -euo pipefail
config="\${CODEX_HOME}/config.toml"
if [[ "\${1:-}" == "mcp" && "\${2:-}" == "remove" ]]; then
  : >"\${config}"
elif [[ "\${1:-}" == "mcp" && "\${2:-}" == "add" ]]; then
  cat >>"\${config}" <<'EOF'
[mcp_servers.flutter-widget-wallet-mcp]
url = "https://flutter-widget-wallet-mcp.onrender.com/mcp"
EOF
elif [[ "\${1:-}" == "mcp" && "\${2:-}" == "get" ]]; then
  echo "http_headers: Authorization=*****"
else
  exit 2
fi
`,
  );
  chmodSync(fakeCodex, 0o700);

  const script = resolve("scripts/configure-codex-global-mcp.sh");
  const output = execFileSync("bash", [script], {
    cwd: resolve("."),
    env: {
      ...process.env,
      CODEX_HOME: codexHome,
      HOME: root,
      PATH: `${binDir}:${process.env.PATH}`,
    },
    input: "test_token_123\n",
    encoding: "utf8",
  });

  const configFile = join(codexHome, "config.toml");
  const config = readFileSync(configFile, "utf8");

  assert.match(config, /\[mcp_servers\.flutter-widget-wallet-mcp\]/);
  assert.match(
    config,
    /\[mcp_servers\.flutter-widget-wallet-mcp\.http_headers\]/,
  );
  assert.match(config, /Authorization = "Bearer test_token_123"/);
  assert.match(output, /Authorization=\*\*\*\*\*/);
  assert.equal(statSync(configFile).mode & 0o777, 0o600);
});
