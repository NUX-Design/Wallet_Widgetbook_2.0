#!/usr/bin/env bash

set -euo pipefail

readonly server_name="flutter-widget-wallet-mcp"
readonly server_url="https://flutter-widget-wallet-mcp.onrender.com/mcp"
readonly config_dir="${CODEX_HOME:-${HOME}/.codex}"
readonly config_file="${config_dir}/config.toml"

if ! command -v codex >/dev/null 2>&1; then
  echo "Error: Codex CLI was not found in PATH." >&2
  exit 1
fi

if [[ -t 0 ]]; then
  read -r -s -p "Bearer token from Niwat: " token
  echo >&2
else
  read -r token
fi

if [[ -z "${token}" ]]; then
  echo "Error: Bearer token must not be empty." >&2
  exit 1
fi

# Render tokens currently use shell/TOML-safe characters. Reject unexpected
# input instead of attempting to interpolate arbitrary text into config.toml.
if [[ ! "${token}" =~ ^[A-Za-z0-9._~-]+$ ]]; then
  echo "Error: Bearer token contains unsupported characters." >&2
  exit 1
fi

umask 077
mkdir -p "${config_dir}"

# Codex CLI owns the base server entry. The current CLI has no --header flag,
# so append the verified global HTTP header table after recreating the server.
codex mcp remove "${server_name}" >/dev/null 2>&1 || true
codex mcp add "${server_name}" --url "${server_url}"

cat >>"${config_file}" <<EOF

[mcp_servers.${server_name}.http_headers]
Authorization = "Bearer ${token}"
EOF

chmod 600 "${config_file}"
unset token

echo
echo "Codex global MCP configured successfully:"
codex mcp get "${server_name}"
echo
echo "Quit and reopen Codex before using the server."
