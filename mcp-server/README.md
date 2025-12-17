# Wi_Wallet Design System MCP Server

This MCP (Model Context Protocol) server bridges the **Wi_Wallet Flutter Design System** documentation with AI agents (like Claude Desktop, Cursor, etc.). It allows AI to directly query the latest design tokens and widget specifications from your codebase.

## 🚀 How it Works

1.  **Source of Truth**: Markdown files (`WIDGETS_GUIDE.md`, `CODEBASE_CONTEXT.md`).
2.  **Generator**: Scripts in `../scripts/` parse markdown into a structured JSON file (`../docs/schema.json`).
3.  **Server**: This MCP server exposes that JSON data via valid MCP tools.

## 🛠️ Setup & Installation

### 1. Prerequisites
- Node.js (v18 or higher recommended)
- `npm`

### 2. Install Dependencies
Run these commands from the project root:

```bash
# install root dependencies (for schema generation)
npm install

# install mcp-server dependencies
cd mcp-server
npm install
cd ..
```

### 3. Generate the Schema
The server relies on `docs/schema.json`. You must generate it first:

```bash
# Run from project root
npm run generate-schema
```

> **Note:** If you update the documentation (Markdown files), remember to run `npm run generate-schema` again to update the data the AI sees.

## ⚙️ Configuration (AI Clients)

To use this server with your AI tool, add it to your `mcp_config.json` (or equivalent configuration).

### Generic Configuration
```json
{
  "mcpServers": {
    "wi-wallet-design-system": {
      "command": "node",
      "args": ["/ABSOLUTE/PATH/TO/PROJECT/mcp-server/index.js"]
    }
  }
}
```

**⚠️ Important:** You must use the **Absolute Path** to the `index.js` file.

### Example for macOS Path
If your project is at `/Users/username/git/Wi_Wallet_Flutter_Widget_2.0`:
```json
{
  "mcpServers": {
    "wi-wallet-design-system": {
      "command": "node",
      "args": ["/Users/username/git/Wi_Wallet_Flutter_Widget_2.0/mcp-server/index.js"]
    }
  }
}
```

## 🧰 Available Tools

Once connected, the AI will have access to these tools:

### `get_design_system_info`
*   **Description:** Get high-level information about the project structure and design tokens.
*   **Arguments:**
    *   `section`: "project" | "designTokens" | "widgets"

### `list_widgets`
*   **Description:** Get a list of all available widgets.
*   **Arguments:**
    *   `category` (optional): Filter by category (e.g., "input", "display").

### `get_widget_details`
*   **Description:** Get full documentation for a specific widget, including properties and usage examples.
*   **Arguments:**
    *   `widgetName`: The exact name of the widget (e.g., "FullAmountInput").

## 🐛 Troubleshooting

**Error: `Schema data not loaded. Please generate docs/schema.json first.`**
*   **Solution:** You forgot to generate the schema. Run `npm run generate-schema` in the project root.

**Error: `Module not found`**
*   **Solution:** Make sure you ran `npm install` inside the `mcp-server` directory.

**AI can't find the server**
*   **Solution:** double-check the absolute path in your `mcp_config.json`. JSON does not support `~` for home directory; use `/Users/yourname`.
