import 'package:flutter/material.dart';
import 'package:mcp_test_app/config/themes/base_theme.dart';
import 'package:mcp_test_app/config/themes/theme_color.dart';
import 'package:mcp_test_app/generated/intl/app_localizations.dart';
import 'package:mcp_test_app/widgets/card/card_review_transaction.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;
  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class LocaleProvider extends ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  void setLocale(Locale newLocale) {
    _locale = newLocale;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LocaleProvider>(
      builder: (context, themeProvider, localeProvider, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: localeProvider.locale,
          theme: ThemeData.from(
            colorScheme: BaseTheme.lightColorScheme,
            useMaterial3: true,
          ).copyWith(
            textTheme: GoogleFonts.notoSansThaiTextTheme(),
            scaffoldBackgroundColor: ThemeColors.get('light', 'fill/base/300'),
          ),
          darkTheme: ThemeData.from(
            colorScheme: BaseTheme.darkColorScheme,
            useMaterial3: true,
          ).copyWith(
            textTheme: GoogleFonts.notoSansThaiTextTheme(),
            scaffoldBackgroundColor: ThemeColors.get('dark', 'fill/base/300'),
          ),
          themeMode: themeProvider.themeMode,
          home: const CardReviewTransactionPreview(),
        );
      },
    );
  }
}

class CardReviewTransactionPreview extends StatelessWidget {
  const CardReviewTransactionPreview({super.key});

  DropdownMenuItem<Locale> _buildDropdownItem(
    BuildContext context,
    Locale locale,
    String text,
    String brightnessKey,
  ) {
    return DropdownMenuItem(
      value: locale,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: ThemeColors.get(brightnessKey, 'text/base/600'),
        ),
      ),
    );
  }

  Locale _getCurrentLocale(BuildContext context) {
    final currentLocale = Localizations.localeOf(context);
    for (final locale in AppLocalizations.supportedLocales) {
      if (locale.languageCode == currentLocale.languageCode) {
        return locale;
      }
    }
    return const Locale('en');
  }

  @override
  Widget build(BuildContext context) {
    final brightnessKey =
        Theme.of(context).brightness == Brightness.light ? 'light' : 'dark';
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: ThemeColors.get(brightnessKey, 'fill/base/100'),
      appBar: AppBar(
        title: Text(l10n.cardReviewPreviewTitle),
        backgroundColor: ThemeColors.get(brightnessKey, 'fill/base/100'),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return IconButton(
                icon: Icon(
                  themeProvider.themeMode == ThemeMode.light
                      ? Icons.dark_mode
                      : Icons.light_mode,
                ),
                onPressed: () => themeProvider.toggleTheme(),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: ThemeColors.get(brightnessKey, 'fill/base/100'),
                borderRadius: BorderRadius.circular(16),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Locale>(
                  value: _getCurrentLocale(context),
                  isExpanded: true,
                  icon: Icon(
                    Icons.language,
                    color: ThemeColors.get(brightnessKey, 'text/base/600'),
                  ),
                  dropdownColor: ThemeColors.get(
                    brightnessKey,
                    'fill/base/200',
                  ),
                  items: [
                    _buildDropdownItem(
                      context,
                      const Locale('en'),
                      'English',
                      brightnessKey,
                    ),
                    _buildDropdownItem(
                      context,
                      const Locale('th'),
                      'ภาษาไทย',
                      brightnessKey,
                    ),
                    _buildDropdownItem(
                      context,
                      const Locale('zh'),
                      '中文',
                      brightnessKey,
                    ),
                    _buildDropdownItem(
                      context,
                      const Locale('ru'),
                      'Русский',
                      brightnessKey,
                    ),
                    _buildDropdownItem(
                      context,
                      const Locale('my'),
                      'မြန်မာ',
                      brightnessKey,
                    ),
                  ],
                  onChanged: (Locale? newLocale) {
                    if (newLocale != null) {
                      Provider.of<LocaleProvider>(
                        context,
                        listen: false,
                      ).setLocale(newLocale);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            CardReviewTransaction(
              totalAmount: l10n.transactionDetailTotalAmountThb(
                '100.00',
                'THB',
              ),
              feeAmount: l10n.transactionDetailFeeAmountThb('100.00', 'THB'),
              fromLabel: l10n.transferDrawerDetailFrom,
              fromValue: l10n.transferDrawerDetailValueYourWallet,
              mobileLabel: l10n.transferDrawerDetailMobileNumber,
              mobileValue: l10n.transferDrawerDetailMobileNumberValue(
                '081-141-6859',
              ),
              toLabel: l10n.transferDrawerDetailTo,
              toValue: l10n.transferDrawerDetailToValue(l10n.valueDrawerScb),
              accountNameLabel: l10n.transferDrawerDetailAccountName,
              accountNameValue: l10n.transferDrawerDetailAccountNameValue(
                'Niwat Yahuadong',
              ),
              accountNumberLabel: l10n.transferDrawerDetailAccountNumber,
              accountNumberValue: l10n.transferDrawerDetailAccountNumberValue(
                '123456789',
              ),
              dateLabel: l10n.transactionDetailTextLabelDate,
              dateValue: l10n.transactionDetailTextValueDate(
                DateFormat('dd-MM-yyyy').format(DateTime.now()),
                DateFormat('HH:mm:ss').format(DateTime.now()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
