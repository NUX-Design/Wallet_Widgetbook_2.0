/**
 * scripts/generate-schema.js
 * Auto-generate JSON schema from markdown documentation
 *
 * Usage: node scripts/generate-schema.js
 */

import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { glob } from "glob";
import { parseMarkdownWidgets, parseProjectInfo, parseDesignTokens, generateTOC } from "./parser.js";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const config = {
    inputFiles: {
        context: "./CODEBASE_CONTEXT.md",
        widgetsGuide: "./WIDGETS_GUIDE.md",
        widgetDocsPattern: "lib/widgets/**/*.{md,MD}" // Pattern to find all widget docs (GUIDE, spec, CONTEXT)
    },
    outputDir: "./docs",
    outputFile: "schema.json"
};

async function generateSchema() {
    console.log("🚀 Starting schema generation...\n");

    try {
        // 1. Read Main Context Files
        console.log("📖 Reading main context files...");
        const contextPath = path.resolve(__dirname, "..", config.inputFiles.context);
        const widgetsGuidePath = path.resolve(__dirname, "..", config.inputFiles.widgetsGuide);

        if (!fs.existsSync(contextPath) || !fs.existsSync(widgetsGuidePath)) {
            throw new Error(`Critical input files not found. Check ${config.inputFiles.context} and ${config.inputFiles.widgetsGuide}`);
        }

        const contextContent = fs.readFileSync(contextPath, "utf-8");
        const widgetsGuideContent = fs.readFileSync(widgetsGuidePath, "utf-8");

        // 2. Scan for Individual Widget Docs
        console.log(`🔍 Scanning for widget docs using pattern: ${config.inputFiles.widgetDocsPattern}`);
        const widgetFiles = await glob(config.inputFiles.widgetDocsPattern, { cwd: path.resolve(__dirname, ".."), absolute: true });
        console.log(`   Found ${widgetFiles.length} additional widget modules.`);

        // 3. Parse Content
        console.log("\n🧠 Parsing content...");

        // Parse main guide
        let allWidgets = parseMarkdownWidgets(widgetsGuideContent);
        const mainWidgetNames = new Set(allWidgets.map(w => w.name));

        // Parse individual files and merge (avoid duplicates if they exist in both)
        for (const file of widgetFiles) {
            const content = fs.readFileSync(file, 'utf-8');
            const fileWidgets = parseMarkdownWidgets(content);

            fileWidgets.forEach(widget => {
                if (!mainWidgetNames.has(widget.name)) {
                    allWidgets.push(widget);
                    mainWidgetNames.add(widget.name);
                    // console.log(`   + Added widget from file: ${widget.name}`);
                } else {
                    // Optional: Update description/examples if the specific file is more detailed
                    // For now, we assume WIDGETS_GUIDE might be a summary and individual files are details,
                    // OR WIDGETS_GUIDE is the master. Let's prioritize WIDGETS_GUIDE for stability,
                    // but usually the specific file is better.
                    // Let's stick to: "If it's already in WIDGETS_GUIDE, keep that one" for simplicity unless requested otherwise.
                }
            });
        }

        const projectInfo = parseProjectInfo(contextContent);
        const designTokens = parseDesignTokens(contextContent);
        const tableOfContents = generateTOC(allWidgets);

        console.log(`✅ Total unique widgets parsed: ${allWidgets.length}`);

        // 4. Build Schema Object
        const schema = {
            meta: {
                generatedAt: new Date().toISOString(),
                version: "1.0.0",
                description: "Wi_Wallet Flutter Design System Schema"
            },
            project: {
                ...projectInfo,
                repositoryUrl: "https://github.com/nengniwatyah/Wi_Wallet_Flutter_Widget_2.0",
                author: "nengniwatyah"
            },
            designTokens: {
                ...designTokens,
                _description: "Design tokens for consistent styling across the system"
            },

            // Implementation Guide
            implementation: {
                localization: {
                    import: "package:mcp_test_app/generated/intl/app_localizations.dart",
                    usage: "AppLocalizations.of(context)!",
                    sourceDir: "lib/l10n",
                    generatedDir: "lib/generated/intl",
                    supportedLocales: ["en", "th", "zh", "ru", "my"]
                },
                theme: {
                    import: "package:mcp_test_app/config/themes/theme_color.dart",
                    usage: "ThemeColors.of(context) or Theme.of(context).colorScheme",
                    configDir: "lib/config/themes",
                    coreFiles: [
                        "lib/config/themes/theme_color.dart",
                        "lib/config/themes/base_theme.dart"
                    ]
                }
            },

            widgets: {
                total: allWidgets.length,
                byCategory: groupWidgetsByCategory(allWidgets),
                all: allWidgets
            },
            tableOfContents
        };

        // 5. Write to File
        const outputDirPath = path.resolve(__dirname, "..", config.outputDir);
        if (!fs.existsSync(outputDirPath)) {
            fs.mkdirSync(outputDirPath, { recursive: true });
        }

        const outputPath = path.resolve(outputDirPath, config.outputFile);
        fs.writeFileSync(outputPath, JSON.stringify(schema, null, 2));

        console.log(`\n✅ Schema written to: ${outputPath}`);

        // Log Summary
        console.log("\n📊 Schema Generation Summary");
        console.log("══════════════════════════════════════════════════");
        console.log(`Generated at: ${schema.meta.generatedAt}`);
        console.log(`Total Widgets: ${schema.widgets.total}`);
        console.log("\n📦 Widgets by Category:");
        Object.entries(schema.widgets.byCategory).forEach(([cat, list]) => {
            console.log(`   • ${cat}: ${list.length} widgets`);
        });
        console.log("\n🎨 Design Token Categories:");
        Object.keys(schema.designTokens).forEach(cat => {
            if (!cat.startsWith("_")) {
                const count = Object.keys(schema.designTokens[cat]).length;
                console.log(`   • ${cat}: ${count} tokens`);
            }
        });

        console.log("\n✨ Schema is ready for use!");
        console.log(`   Use in MCP: import schema from 'docs/schema.json'`);
        console.log("═".repeat(50) + "\n");
    } catch (error) {
        console.error("\n❌ Error generating schema:", error.message);
        process.exit(1);
    }
}

// Run generation
generateSchema();

/**
 * Group widgets by category
 */
function groupWidgetsByCategory(widgets) {
    return widgets.reduce((acc, widget) => {
        const category = widget.category || "general";
        if (!acc[category]) acc[category] = [];
        acc[category].push(widget);
        return acc;
    }, {});
}
