---
name: flutter-widget-v3-beginner
description: Create a new Flutter app with an installable Theme V3 runtime and starter Widget V3, or scan and extend V3 in an existing Flutter workspace using `flutter-widget-wallet-mcp`. Use for guided new-project setup or existing-project adoption with explicit confirmation before edits.
---

# Flutter Widget V3 Beginner

Use this skill from Kiro by selecting the skill directly or by asking Kiro to scan and bootstrap Theme V3 / Widget V3 usage naturally.

Use this skill when the user wants a brand-new Flutter app ready for Theme V3, or wants to add Widget V3 to an existing Flutter workspace.

For an existing project, only touch `lib/config/themes/v3/**`, `lib/widgets/v3/**`, and `test/widgets/v3/**`. For confirmed `bootstrap-new`, the skill may create the Flutter project structure and starter entrypoint, then install the V3 runtime under `lib/config/themes/v3/**`. Never edit legacy theme or legacy widgets.

## Mandatory Flow

Always run in this order:

1. Ask discovery questions.
2. Scan the workspace.
3. Summarize what exists and what is missing.
4. Ask for confirmation on the execution plan.
5. Execute only the confirmed scope.

Never edit the repo before the question flow completes.

## Discovery Questions

Before asking the user to choose, explain every option in the user's language. Never present bare labels such as `auto-detect` or `additive-only` without saying what they mean, when to use them, and what the skill may change. Recommend the safest choice when the user is unsure.

### 1. Goal

Question: `รอบนี้ต้องการให้ flutter-widget-v3-beginner ทำอะไร`

Options:

- `scan-only` — analyze existing Theme V3 / Widget V3 state only, create nothing, edit nothing, return a gap report.
- `bootstrap-existing` — the workspace already has Theme V3 foundation (`lib/config/themes/v3/generated/`); add a new Widget V3 or fill in missing preview/test/guide for an existing one.
- `bootstrap-new` — create a new Flutter app, install the MCP-provided Theme V3 runtime foundation, add one starter Widget V3 with a standalone preview and tests, then verify Light/Dark behavior.

### 2. Workspace State Preference

Question: `สภาพ workspace ตอนนี้เป็นแบบไหน หรืออยากให้ skill ตีความแบบไหน`

Explain these options before asking:

- `auto-detect` — recommended and safest when the user is unsure. Inspect the workspace and classify it automatically before proposing changes.
- `existing-v3-foundation` — an existing Flutter project that already contains Theme V3, normally including `lib/config/themes/v3/generated/`.
- `existing-flutter-no-v3` — an existing Flutter project with `pubspec.yaml` and `lib/main.dart`, but without the Theme V3 runtime foundation.
- `no-flutter-yet` — the destination is not a Flutter project. Creating it requires the explicit `bootstrap-new` goal.

### 3. Target Widget Scope

Question: `ต้องการเพิ่ม/แก้ widget V3 ตัวไหน`

Options: an explicit widget name, or `auto` to let the skill pick from `search_v3_widgets` / `list_v3_widgets`, preferring a widget not yet present in the target repo's `lib/widgets/v3/**`.

### 4. Change Policy

Question: `ให้ skill แตะ repo ได้ระดับไหน`

Explain these options before asking:

- `additive-only` — recommended. Create only missing files. Stop and report before any path collision; never overwrite an existing file.
- `allow-structure-setup` — allow creation of folders and structural files required by V3, but never overwrite existing files implicitly.
- `ask-before-overwrite` — if changing or replacing an existing file becomes necessary, request explicit permission for that file first.

For an existing project, state this allowed scope visibly before confirmation:

```text
lib/config/themes/v3/**
lib/widgets/v3/**
test/widgets/v3/**
```

State that legacy theme files and legacy widgets will not be changed.

### Additional Information For `bootstrap-new`

When the user selects `bootstrap-new`, explain and collect:

- `project name` — lowercase Dart package name using `_` instead of spaces, for example `wi_wallet_demo`.
- `destination directory` — a new or empty directory, for example `/Users/<user>/Documents/wi_wallet_demo`.
- `organization identifier` — reverse-domain namespace used by Android/iOS, for example `com.wi.wallet`.
- `target platforms` — only the required values from `android`, `ios`, `web`, `macos`, `windows`, or `linux` to avoid unnecessary platform files.

Show this answer template when useful:

```text
goal: bootstrap-new
workspace: no-flutter-yet
widget: auto
policy: additive-only
project name: wi_wallet_demo
destination: /Users/<user>/Documents/wi_wallet_demo
organization: com.wi.wallet
platforms: android, ios
```

If the user wants only the safest assessment of the current workspace, recommend:

```text
scan-only, auto-detect, auto, additive-only
```

## Workspace Scan

Inspect at least:

- whether `flutter` is available and `flutter doctor` reports a usable SDK
- `pubspec.yaml` and `lib/main.dart` (Flutter project detection)
- `lib/config/themes/v3/generated/` (Theme V3 foundation readiness)
- `lib/widgets/v3/**` existing widgets and their category/pattern
- `test/widgets/v3/**` and `preview_v3_*.dart` coverage
- whether the target widget already exists (if so, prefer `flutter-widget-v3-upgrade` or `flutter-widget-v3-adapt` instead)

## Summary And Confirmation

Summarize before editing: whether Theme V3 foundation exists, what Widget V3 already exists, what will be created/edited, and any risk (most commonly: missing Theme V3 foundation). Then ask:

Question: `จากสิ่งที่สแกนพบ จะให้ดำเนินการตามแผนนี้หรือไม่`

Options: `proceed`, `revise-scope`, `stop-after-scan`.

## Execute

- For confirmed `bootstrap-new`:
  1. Re-check that the destination does not contain files that would be overwritten. Stop on a non-empty conflicting directory.
  2. Run `flutter create --project-name <name> --org <org> --platforms <platforms> <destination>` with the confirmed values.
  3. Call `get_v3_theme_foundation` without `file`, then fetch every manifest entry by exact path and create those files unchanged in the new project.
  4. Install the confirmed starter widget using `get_v3_widget_metadata` + `get_v3_widget_code`, or scaffold one with `get_v3_flutter_widget_template`. Rewrite only package-name imports that refer to the MCP source package; never rewrite relative V3 imports.
  5. Create `lib/main.dart` with Material 3 Light/Dark themes and the starter Widget V3, plus `preview_v3_<widget>.dart` and targeted tests. User-facing strings remain caller-owned and localization-ready.
  6. Run `dart format .`, `flutter analyze`, and `flutter test`. When a runnable device is available, smoke-test the starter app or standalone preview.
- If the target widget already exists in the MCP V3 catalog: use `get_v3_widget_metadata`, `get_v3_widget_code`, and `get_v3_widget_preview`.
- If it does not exist yet: use `get_v3_flutter_widget_template` to scaffold. When local/stdio MCP is available, `generate_v3_widgetbook_use_case` may optionally produce preview wiring.
- Follow `docs/v3/V3_WIDGET_CONVENTIONS.md` for file layout, naming, and the required `V3 Metadata` guide section.

## Remote-Safe Fallback

When connected through Remote MCP, keep using the remotely exposed `get_v3_flutter_widget_template`, metadata, token, code, and preview tools. Author the Widgetbook use case or standalone preview locally from those read-only results and the target repo conventions; do not call `generate_v3_widgetbook_use_case`, silently switch to a legacy tool, or stop an otherwise valid workflow.

## MCP Tools

- `get_v3_design_system_info`
- `get_v3_theme_foundation`
- `get_v3_codebase_patterns`
- `list_v3_categories`
- `search_v3_widgets`
- `get_v3_widget_metadata`
- `get_v3_widget_code`
- `get_v3_widget_preview`
- `get_v3_flutter_widget_template`
- `generate_v3_widgetbook_use_case`

## Guardrails

- Never assume Theme V3 foundation exists without scanning for `lib/config/themes/v3/generated/`.
- Never create or replace a Flutter project unless the user selected `bootstrap-new` and confirmed the exact destination.
- In existing projects, never touch widgets or theme files outside `lib/config/themes/v3/**`, `lib/widgets/v3/**`, and `test/widgets/v3/**`.
- Never fall back to legacy MCP tools or `ThemeColors.get()` when V3 data is missing; report the gap instead.
- If no Flutter project exists and the user did not select `bootstrap-new`, report the gap and offer that mode; do not create a project implicitly.
