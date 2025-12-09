#!/usr/bin/env node

/**
 * mcp-server/index.js
 * MCP Server Implementation for Wi_Wallet Design System
 */

import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import {
    CallToolRequestSchema,
    ListToolsRequestSchema,
} from "@modelcontextprotocol/sdk/types.js";
import { z } from "zod";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

// Get directory of current file
const __dirname = path.dirname(fileURLToPath(import.meta.url));

// Path to schema.json (../docs/schema.json)
const SCHEMA_PATH = path.resolve(__dirname, "../docs/schema.json");

// Helper to load schema dynamically
function loadSchema() {
    try {
        if (fs.existsSync(SCHEMA_PATH)) {
            const fileContent = fs.readFileSync(SCHEMA_PATH, "utf-8");
            return JSON.parse(fileContent);
        }
        console.error(`Schema file not found at ${SCHEMA_PATH}`);
        return null;
    } catch (error) {
        console.error("Error loading schema:", error);
        return null;
    }
}

// Log initial load check (optional, just for startup feedback)
const initialSchema = loadSchema();
if (initialSchema) {
    console.error(`Sever started. Schema loaded from ${SCHEMA_PATH}`);
} else {
    console.error(`Server started but Schema file not found at ${SCHEMA_PATH}`);
}

// Create MCP Server
const server = new Server(
    {
        name: "wi-wallet-design-system",
        version: "1.0.0",
    },
    {
        capabilities: {
            tools: {},
        },
    }
);

// Define Tools
server.setRequestHandler(ListToolsRequestSchema, async () => {
    return {
        tools: [
            {
                name: "get_design_system_info",
                description: "Get high-level Wi_Wallet Design System information (project info, design tokens overview). Use this to understand the project structure and available tokens.",
                inputSchema: {
                    type: "object",
                    properties: {
                        section: {
                            type: "string",
                            enum: ["project", "designTokens", "widgets", "implementation"],
                            description: "Which section to retrieve: 'project' for info, 'designTokens' for style, 'widgets' for overview, 'implementation' for import paths.",
                        },
                    },
                    required: ["section"],
                },
            },
            {
                name: "list_widgets",
                description: "List all available widgets in the design system. Can filter by category.",
                inputSchema: {
                    type: "object",
                    properties: {
                        category: {
                            type: "string",
                            description: "Filter by category (e.g., 'input', 'display', 'general'). Leave empty for all.",
                        },
                    },
                },
            },
            {
                name: "get_widget_details",
                description: "Get detailed information about a specific widget, including properties and usage examples. Use this when you need to know how to implement a specific widget.",
                inputSchema: {
                    type: "object",
                    properties: {
                        widgetName: {
                            type: "string",
                            description: "Exact name of the widget (e.g., 'FullAmountInput', 'Buttons').",
                        },
                    },
                    required: ["widgetName"],
                },
            },
        ],
    };
});

// Handle Tool Execution
server.setRequestHandler(CallToolRequestSchema, async (request) => {
    // Reload schema on every request
    const schemaData = loadSchema();

    if (!schemaData) {
        return {
            content: [
                {
                    type: "text",
                    text: "Error: Schema data not loaded. Please generate docs/schema.json first.",
                },
            ],
            isError: true,
        };
    }

    const { name, arguments: args } = request.params;

    try {
        // Tool: get_design_system_info
        if (name === "get_design_system_info") {
            const { section } = args;
            let result;

            if (section === "project") result = schemaData.project;
            else if (section === "designTokens") result = schemaData.designTokens;
            else if (section === "implementation") result = schemaData.implementation;
            else if (section === "widgets") result = { count: schemaData.widgets.total, categories: Object.keys(schemaData.widgets.byCategory) };
            else result = { availableSections: ["project", "designTokens", "widgets", "implementation"] };

            return {
                content: [{ type: "text", text: JSON.stringify(result, null, 2) }],
            };
        }

        // Tool: list_widgets
        if (name === "list_widgets") {
            // Accessing list_widgets with optional category
            const category = args?.category;

            let widgets = [];
            if (category) {
                widgets = schemaData.widgets.byCategory[category] || [];
            } else {
                widgets = schemaData.widgets.all;
            }

            // Return simplified list
            const simplified = widgets.map(w => ({
                name: w.name,
                description: w.description,
                category: w.category
            }));

            return {
                content: [{ type: "text", text: JSON.stringify(simplified, null, 2) }],
            };
        }

        // Tool: get_widget_details
        if (name === "get_widget_details") {
            const { widgetName } = args;
            const widget = schemaData.widgets.all.find((w) => w.name === widgetName);

            if (!widget) {
                return {
                    content: [{ type: "text", text: `Widget '${widgetName}' not found.` }],
                    isError: true,
                };
            }

            return {
                content: [{ type: "text", text: JSON.stringify(widget, null, 2) }],
            };
        }

        return {
            content: [{ type: "text", text: `Unknown tool: ${name}` }],
            isError: true,
        };
    } catch (error) {
        return {
            content: [
                {
                    type: "text",
                    text: `Error executing tool ${name}: ${error.message}`,
                },
            ],
            isError: true,
        };
    }
});

// Start Server
const transport = new StdioServerTransport();
await server.connect(transport);
