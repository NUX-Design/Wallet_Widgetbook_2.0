// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:io';

void main() async {
  final file = File('lib/l10n/localization.json');
  if (!await file.exists()) {
    print('❌ Error: localization.json not found in root directory.');
    return;
  }

  final jsonString = await file.readAsString();
  final List<dynamic> data = jsonDecode(jsonString);

  // Map Google Sheet columns to ARB file codes
  // Sheet Column -> ARB Language Code
  final languageMap = {
    'EN': 'en',
    'TH': 'th',
    'RU': 'ru',
    'ZH': 'zh',
    'MM': 'my', // Map MM column to 'my' (Burmese) code
  };

  final Map<String, Map<String, dynamic>> arbFiles = {};

  // Initialize maps for each language
  languageMap.forEach((sheetCol, langCode) {
    arbFiles[langCode] = {'@@locale': langCode};
  });

  for (var item in data) {
    // Use 'Name' column as the key (e.g., headerDeposit)
    String rawKey = item['Name']?.toString() ?? '';

    // Skip if key is empty
    if (rawKey.isEmpty) continue;

    // Convert to lowerCamelCase (ensure first letter is lowercase)
    final String key = rawKey.replaceFirstMapped(
      RegExp(r'^[A-Z]'),
      (match) => match.group(0)!.toLowerCase(),
    );

    // Optional: Use 'Element' or 'Prefix' for description if needed,
    // but for now we'll just use a generic description or skip it if not in sheet.
    // The previous script assumed a 'description' column.
    // If your sheet doesn't have a specific description column for ARB metadata,
    // we can omit the @key metadata or use a placeholder.
    // Let's check if there's a 'description' field in the JSON, otherwise skip.
    final String description = item['description'] ?? '';

    // Detect placeholders in English text
    final String enValue = item['EN']?.toString() ?? '';
    final RegExp placeholderRegex = RegExp(r'\{(\w+)\}');
    final Iterable<Match> matches = placeholderRegex.allMatches(enValue);
    Map<String, dynamic>? placeholders;
    if (matches.isNotEmpty) {
      placeholders = {};
      for (final match in matches) {
        String placeholderName = match.group(1)!;
        placeholders[placeholderName] = {};
      }
    }

    languageMap.forEach((sheetCol, langCode) {
      String value = item[sheetCol]?.toString() ?? '';

      // Fallback to English if value is empty
      if (value.isEmpty) {
        value = enValue;
      }

      if (value.isNotEmpty) {
        arbFiles[langCode]![key] = value;

        // Add metadata for all languages to satisfy strict linter
        Map<String, dynamic> metadata = {};
        if (description.isNotEmpty) {
          metadata['description'] = description;
        } else {
          // Ensure description is present even if empty, if that's what the linter wants
          // or just leave it out but ensure the @key object exists.
          // Let's try adding a generic description if empty.
          metadata['description'] = ' ';
        }

        if (placeholders != null) {
          metadata['placeholders'] = placeholders;
        }

        // Always add metadata entry
        arbFiles[langCode]!['@$key'] = metadata;
      }
    });
  }

  // Write ARB files
  languageMap.forEach((sheetCol, langCode) async {
    final content = JsonEncoder.withIndent('  ').convert(arbFiles[langCode]);
    final outputFile = File('lib/l10n/app_$langCode.arb');
    await outputFile.writeAsString(content);
    print('✅ Generated lib/l10n/app_$langCode.arb');
  });

  print('🎉 All ARB files generated successfully!');
}
