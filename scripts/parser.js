/**
 * scripts/parser.js
 * Parse markdown documentation into structured data
 */

// Export functions
export { parseMarkdownWidgets, parseProjectInfo, extractDesignTokens as parseDesignTokens, generateTableOfContents as generateTOC };

/**
 * Parse widgets from WIDGETS_GUIDE.md
 * 
 * Widget headers are Level 2 (## WidgetName).
 * We need to skip known non-widget sections like "Table of Contents", "Localization".
 */
function parseMarkdownWidgets(markdown) {
    const widgets = [];

    // Sections to ignore
    const ignoredSections = [
        "Table of Contents",
        "📋 Table of Contents",
        "Localization",
        "🌍 Localization",
        "Project Statistics",
        "Naming Conventions",
        "Future Roadmap"
    ];

    // Regex for Level 2 headers
    const sectionPattern = /(?:^|\n)##\s+([^\n]+)\n([\s\S]*?)(?=(?:^|\n)##\s+|\Z)/g;

    let match;
    while ((match = sectionPattern.exec(markdown)) !== null) {
        const title = match[1].trim();
        const content = match[2];

        // Skip ignored sections
        if (ignoredSections.some(ignored => title.includes(ignored))) {
            continue;
        }

        // Heuristic: Widgets usually have "Import" or "Usage" or "Properties" subsection
        // But let's assume everything else is a widget for now.

        // Extract description (text before the first subsection)
        const descMatch = content.match(/^([\s\S]+?)(?=(?:^|\n)###\s+)/);
        const description = descMatch ? descMatch[1].trim() : "";

        // Extract props from "Properties" table
        const props = parsePropsFromTable(content);

        // Extract example/usage
        const example = parseExample(content);

        // Default category
        const category = "general";

        widgets.push({
            name: title,
            description,
            category,
            props,
            // usage: example, // Let's keep the name 'example' for consistency
            example,
            fullContent: content.substring(0, 1000)
        });
    }

    return widgets;
}

/**
 * Parse props from markdown table in content
 */
function parsePropsFromTable(content) {
    const props = {};

    // Find properties table
    // | Property | Type | ...
    const tableMatch = content.match(/\| Property \| Type \|[\s\S]+?(?=\n\n|\Z)/);
    if (tableMatch) {
        const tableLines = tableMatch[0].split("\n").slice(2); // Skip header and separator
        tableLines.forEach(line => {
            const cols = line.split("|").map(s => s.trim()).filter(s => s);
            if (cols.length >= 2) {
                const name = cols[0];
                const type = cols[1];
                const description = cols[3] || cols[2] || ""; // Handle different table formats
                props[name] = { name, type, description };
            }
        });
    }

    return props;
}

/**
 * Extract example usage code
 */
function parseExample(content) {
    // Look for ```dart block after Usage
    const usageMatch = content.match(/### Usage\s*[\n\r]+\s*```dart\s*([\s\S]+?)```/);
    if (usageMatch) {
        return usageMatch[1].trim();
    }
    return "";
}

/**
 * Parse project information from CODEBASE_CONTEXT.md
 */
function parseProjectInfo(markdown) {
    // Extract main title
    const titleMatch = markdown.match(/^#\s+(.+?)$/m);
    const title = titleMatch ? titleMatch[1].trim() : "Wi_Wallet";

    const overviewMatch = markdown.match(/## 📋 ภาพรวมโปรเจค\s*([\s\S]+?)(?=##\s+|\Z)/);
    const overview = overviewMatch ? overviewMatch[1].trim() : "";

    const featuresMatch = markdown.match(/## 🎯 Key Features\s*([\s\S]+?)(?=##\s+|\Z)/);
    const features = featuresMatch
        ? featuresMatch[1].split("\n").filter(l => l.trim().startsWith("-")).map(l => l.replace(/^[-\s]*/, "").trim())
        : [];

    // Extract design token summary if possible
    const tokensMatch = markdown.match(/## 🎨 Theme System\s*([\s\S]+?)(?=##\s+|\Z)/);
    const designTokens = tokensMatch ? tokensMatch[1].trim() : "";

    return {
        title,
        overview,
        features,
        designTokens,
        language: "Dart",
        platform: "Flutter"
    };
}

/**
 * Extract design tokens
 * Looks for colors defined in "Color Scheme" or similar sections
 */
function extractDesignTokens(markdown) {
    const tokens = {
        colors: {},
        spacing: {},
        typography: {},
        borderRadius: {},
        shadows: {},
        other: {}
    };

    // Extract colors from "Color Scheme"
    // Format: - Primary: `#FFC23D` (Yellow/Gold)
    const colorSchemeMatch = markdown.match(/### Color Scheme([\s\S]+?)(?=###|##|$)/);
    if (colorSchemeMatch) {
        const lines = colorSchemeMatch[1].split("\n");
        lines.forEach(line => {
            const match = line.match(/- ([^:]+):\s*`([^`]+)`/);
            if (match) {
                tokens.colors[match[1].trim()] = match[2];
            }
        });
    }

    return tokens;
}

/**
 * Generate markdown table of contents
 */
function generateTableOfContents(widgets) {
    let toc = "## Widgets Index\n\n";

    // Sort alphabetically
    widgets.sort((a, b) => a.name.localeCompare(b.name));

    widgets.forEach(widget => {
        toc += `- **${widget.name}**: ${widget.description.substring(0, 80)}${widget.description.length > 80 ? '...' : ''}\n`;
    });

    return toc;
}
