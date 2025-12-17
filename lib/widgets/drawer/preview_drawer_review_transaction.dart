import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mcp_test_app/config/themes/theme_color.dart';
import 'package:mcp_test_app/generated/intl/app_localizations.dart';
import 'package:mcp_test_app/widgets/drawer/drawer_review_transaction.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class LocaleProvider extends ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  void setLocale(Locale newLocale) {
    _locale = newLocale;
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
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeProvider.themeMode,
          home: const DrawerReviewTransactionPreview(),
        );
      },
    );
  }
}

class DrawerReviewTransactionPreview extends StatelessWidget {
  const DrawerReviewTransactionPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final brightnessKey =
        Theme.of(context).brightness == Brightness.light ? 'light' : 'dark';

    return Scaffold(
      backgroundColor: ThemeColors.get(brightnessKey, 'fill/base/100'),
      appBar: AppBar(
        title: const Text('Drawer Review Transaction'),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  final l10n = AppLocalizations.of(context)!;
                  DrawerReviewTransaction.show(
                    context,
                    warningTitle: l10n.transferDrawerWarningTitleRecheckInfo,
                    warningDescription:
                        l10n.transferDrawerWarningInfoPreventFraud,
                    totalAmount: '5,000.00 THB',
                    feeAmount: 'Fee 0.00 THB',
                    fromLabel: 'From',
                    fromValue: 'Your Wi Wallet',
                    mobileLabel: 'Mobile Number',
                    mobileValue: '081-141-1234',
                    toLabel: 'To',
                    toValue: 'Siam Commercial Bank',
                    accountNameLabel: 'Account Name',
                    accountNameValue: 'Victor Von Doom',
                    accountNumberLabel: 'Account Number',
                    accountNumberValue: '1234567890',
                    objectLabel: 'Object',
                    objectValue: 'Personal expenses',
                    dateLabel: 'Date&Time',
                    dateValue: '06 Oct 2025 12:00',
                    confirmButtonText: 'Confirm',
                    onConfirm: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Transaction Confirmed!')),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
                child: const Text('Show Review Drawer'),
              ),
              const SizedBox(height: 16),
              Text(
                'Tap the button to open the drawer',
                style: TextStyle(
                  color: ThemeColors.get(brightnessKey, 'text/base/600'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
