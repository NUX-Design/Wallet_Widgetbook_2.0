import fs from "node:fs";
import path from "node:path";
import { ToolError } from "../tool_runtime.js";

export const V3_RUNTIME_FOUNDATION_FILES = Object.freeze([
  "lib/config/themes/v3/generated/v3_primitive_colors.g.dart",
  "lib/config/themes/v3/generated/v3_primitive_dimensions.g.dart",
  "lib/config/themes/v3/generated/v3_primitive_shadows.g.dart",
  "lib/config/themes/v3/generated/v3_semantic_colors.g.dart",
  "lib/config/themes/v3/generated/v3_semantic_dimensions.g.dart",
  "lib/config/themes/v3/generated/v3_typography.g.dart",
  "lib/config/themes/v3/v3_color_palette.dart",
  "lib/config/themes/v3/v3_dimensions.dart",
  "lib/config/themes/v3/v3_primitives.dart",
  "lib/config/themes/v3/v3_theme_scope.dart",
  "lib/config/themes/v3/v3_typography.dart",
]);

export class V3FoundationCatalog {
  constructor(projectRoot) {
    this.projectRoot = projectRoot;
  }

  manifest() {
    return V3_RUNTIME_FOUNDATION_FILES.map((file) => ({
      file,
      generated: file.includes("/generated/"),
      bytes: Buffer.byteLength(this.read(file)),
    }));
  }

  read(file) {
    if (!V3_RUNTIME_FOUNDATION_FILES.includes(file)) {
      throw new ToolError("INVALID_ARGUMENT", `File "${file}" is not part of the V3 runtime foundation.`, {
        hint: "Call get_v3_theme_foundation without file to retrieve the allowed manifest.",
      });
    }

    const absolutePath = path.join(this.projectRoot, file);
    if (!fs.existsSync(absolutePath)) {
      throw new ToolError("NOT_FOUND", `V3 runtime foundation file "${file}" is unavailable.`, {
        hint: "Regenerate Theme V3 outputs in the MCP source repository before distributing the foundation.",
      });
    }
    return fs.readFileSync(absolutePath, "utf8");
  }
}
