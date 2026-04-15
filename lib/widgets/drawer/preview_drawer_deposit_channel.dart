import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mcp_test_app/config/themes/theme_color.dart';
import 'package:mcp_test_app/generated/intl/app_localizations.dart';
import 'drawer_deposit_channel.dart';
import 'package:mcp_test_app/widgets/button/buttons.dart';

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
  Locale? _locale = const Locale('en');

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
          home: const PreviewDrawerDepositChannel(),
        );
      },
    );
  }
}

class PreviewDrawerDepositChannel extends StatefulWidget {
  const PreviewDrawerDepositChannel({super.key});

  @override
  State<PreviewDrawerDepositChannel> createState() =>
      _PreviewDrawerDepositChannelState();
}

class _PreviewDrawerDepositChannelState
    extends State<PreviewDrawerDepositChannel> {
  bool _didShowDrawer = false;

  void _showDrawer(BuildContext context) {
    DrawerDepositChannel.show(
      context,
      onBankSelected: (bank) {
        Navigator.pop(context);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Selected: ${bank.name}')));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_didShowDrawer) {
      _didShowDrawer = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _showDrawer(context);
        }
      });
    }

    final brightnessKey =
        Theme.of(context).brightness == Brightness.light ? 'light' : 'dark';
    return Scaffold(
      backgroundColor: ThemeColors.get(brightnessKey, 'fill/base/300'),
      appBar: AppBar(
        title: const Text('Drawer Deposit Channel'),
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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Buttons(
            text: 'Show Drawer',
            type: ButtonType.primary,
            enabled: true,
            onPressed: () => _showDrawer(context),
          ),
        ),
      ),
    );
  }
}
