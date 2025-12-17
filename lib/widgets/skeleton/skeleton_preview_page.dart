import 'package:flutter/material.dart';
import 'package:mcp_test_app/config/themes/theme_color.dart';
import 'package:provider/provider.dart';
import 'package:mcp_test_app/widgets/navigator_bar/navigator_bar.dart';
import 'package:mcp_test_app/widgets/drawer/drawer_balance_detail.dart';
import 'package:mcp_test_app/generated/intl/app_localizations.dart';
import 'package:mcp_test_app/providers/theme_provider.dart';
import 'package:mcp_test_app/providers/locale_provider.dart';

import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: const SkeletonPreviewApp(),
    ),
  );
}

class SkeletonPreviewApp extends StatelessWidget {
  const SkeletonPreviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LocaleProvider>(
      builder: (context, themeProvider, localeProvider, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: localeProvider.locale,
          theme: ThemeData.light().copyWith(
            textTheme:
                localeProvider.locale?.languageCode == 'th'
                    ? GoogleFonts.notoSansThaiTextTheme()
                    : GoogleFonts.notoSansTextTheme(),
          ),
          darkTheme: ThemeData.dark().copyWith(
            textTheme:
                localeProvider.locale?.languageCode == 'th'
                    ? GoogleFonts.notoSansThaiTextTheme()
                    : GoogleFonts.notoSansTextTheme(),
          ),
          themeMode: themeProvider.themeMode,
          home: const SkeletonPreviewPage(),
        );
      },
    );
  }
}

class SkeletonPreviewPage extends StatefulWidget {
  const SkeletonPreviewPage({super.key});

  @override
  State<SkeletonPreviewPage> createState() => _SkeletonPreviewPageState();
}

class _SkeletonPreviewPageState extends State<SkeletonPreviewPage> {
  bool _isLoading = false;

  Future<void> _handleRefresh() async {
    setState(() {
      _isLoading = true;
    });
    // Simulate network delay but return immediately to hide the refresh indicator
    // so the skeleton can be seen clearly.
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final brightnessKey =
        Theme.of(context).brightness == Brightness.light ? 'light' : 'dark';
    return Scaffold(
      backgroundColor: ThemeColors.get(brightnessKey, 'fill/base/300'),
      extendBody: true,
      bottomNavigationBar: NavigatorBar(),
      appBar: AppBar(
        toolbarHeight: 56.0,
        centerTitle: true,
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          "Skeleton Preview",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: ThemeColors.get(brightnessKey, 'text/base/600'),
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: ThemeColors.get(brightnessKey, 'fill/base/100'),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return IconButton(
                icon: Icon(
                  themeProvider.themeMode == ThemeMode.dark
                      ? Icons.light_mode
                      : Icons.dark_mode,
                  color: ThemeColors.get(brightnessKey, 'text/base/600'),
                ),
                onPressed: () => themeProvider.toggleTheme(),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 0.0,
                  vertical: 1.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 1),
                    // Drawer Balance Detail
                    DrawerBalanceDetail(
                      totalBalanceAmount: '1,234.56',
                      currency: 'THB',
                      holdAmountLabel: 'Hold Amount',
                      holdAmountValue: '100.00',
                      ledgerBalanceLabel: 'Ledger Balance',
                      ledgerBalanceValue: '1,134.56',
                      warningText:
                          '*Hold Amount is the amount that is currently on hold.',
                      isLoading: _isLoading,
                      showButton: false,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
