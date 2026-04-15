import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mcp_test_app/config/themes/theme_color.dart';
import 'package:mcp_test_app/generated/intl/app_localizations.dart';
import 'announcement.dart';
import 'announcement_warning.dart';

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
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeProvider.themeMode,
          home: const CombinedAnnouncementExample(),
        );
      },
    );
  }
}

class CombinedAnnouncementExample extends StatefulWidget {
  const CombinedAnnouncementExample({super.key});

  @override
  State<CombinedAnnouncementExample> createState() =>
      _CombinedAnnouncementExampleState();
}

class _CombinedAnnouncementExampleState
    extends State<CombinedAnnouncementExample> {
  late List<String> _announcements;

  @override
  void initState() {
    super.initState();
    _announcements = [
      'System maintenance completed successfully. All services are now fully operational.',
      'New security features have been added to protect your account. Please review your settings.',
      'Mobile app version 2.1.0 is now available with improved performance and new features.',
    ];
  }

  void _rotateAnnouncements() {
    setState(() {
      _announcements = [..._announcements.sublist(1), _announcements[0]];
    });
  }

  @override
  Widget build(BuildContext context) {
    final brightnessKey =
        Theme.of(context).brightness == Brightness.light ? 'light' : 'dark';

    return Scaffold(
      backgroundColor: ThemeColors.get(brightnessKey, 'fill/base/100'),
      appBar: AppBar(
        title: const Text('Combined Announcement Example'),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Warning Section
              Text(
                'Important Warning',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: ThemeColors.get(brightnessKey, 'text/base/600'),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              const AnnouncementWarning(
                title: 'Please recheck information before proceeding',
                description:
                    'To prevent wrong account transfers or fraudulent activities. It cannot be changed once confirmed.',
              ),

              const SizedBox(height: 32),

              // Announcements Section
              Text(
                'System Announcements',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: ThemeColors.get(brightnessKey, 'text/base/600'),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              AnnouncementStack(
                messages: _announcements,
                onClose: _rotateAnnouncements,
              ),

              const SizedBox(height: 32),

              // Controls Section
              Text(
                'Controls',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: ThemeColors.get(brightnessKey, 'text/base/600'),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  ElevatedButton.icon(
                    onPressed: _rotateAnnouncements,
                    icon: const Icon(Icons.refresh, size: 16),
                    label: const Text('Next Announcement'),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Usage Info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: ThemeColors.get(brightnessKey, 'fill/base/200'),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: ThemeColors.get(brightnessKey, 'stroke/base/100'),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Usage Guidelines',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: ThemeColors.get(brightnessKey, 'text/base/600'),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '• AnnouncementWarning: Use for critical alerts that require user attention\n'
                      '• AnnouncementStack: Use for general information and updates\n'
                      '• Warning appears above announcements in importance hierarchy\n'
                      '• AnnouncementWarning is static (no dismiss button)',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: ThemeColors.get(brightnessKey, 'text/base/600'),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
