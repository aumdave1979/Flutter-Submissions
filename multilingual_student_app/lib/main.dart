import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'event_planner_screen.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(const StudentApp());
}

class StudentApp extends StatefulWidget {
  const StudentApp({super.key});

  @override
  State<StudentApp> createState() => _StudentAppState();
}

class _StudentAppState extends State<StudentApp> {
  Locale _locale = const Locale('en');

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final language = prefs.getString('language') ?? 'en';

    if (mounted) {
      setState(() {
        _locale = Locale(language);
      });
    }
  }

  Future<void> _changeLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);

    setState(() {
      _locale = Locale(language);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: StudentHomeScreen(
        onLanguageChanged: _changeLanguage,
        selectedLanguage: _locale.languageCode,
      ),
    );
  }
}

class StudentHomeScreen extends StatelessWidget {
  final Function(String) onLanguageChanged;
  final String selectedLanguage;

  const StudentHomeScreen({
    super.key,
    required this.onLanguageChanged,
    required this.selectedLanguage,
  });

  @override
  Widget build(BuildContext context) {
    final app = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final date = DateFormat.yMMMMd(locale).format(DateTime.now());
    final count = NumberFormat.decimalPattern(locale).format(25);

    return Scaffold(
      appBar: AppBar(
        title: Text(app.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.event),
            tooltip: 'Event Planner',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const EventPlannerScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              app.welcome,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text('${app.studentName}: Aum Dave'),
            const SizedBox(height: 12),
            Text('${app.today}: $date'),
            const SizedBox(height: 12),
            Text('${app.number}: $count'),
            const SizedBox(height: 24),
            Text(app.language, style: const TextStyle(fontSize: 18)),
            DropdownButton<String>(
              value: selectedLanguage,
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: 'en', child: Text('English')),
                DropdownMenuItem(value: 'gu', child: Text('ગુજરાતી')),
                DropdownMenuItem(value: 'hi', child: Text('हिन्दी')),
              ],
              onChanged: (value) {
                if (value != null) {
                  onLanguageChanged(value);
                }
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(app.languageSaved)));
              },
              child: Text(app.save),
            ),
          ],
        ),
      ),
    );
  }
}
