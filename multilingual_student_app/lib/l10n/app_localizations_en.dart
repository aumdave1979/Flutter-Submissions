// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Student Information';

  @override
  String get welcome => 'Welcome';

  @override
  String get studentName => 'Student Name';

  @override
  String get language => 'Select Language';

  @override
  String get today => 'Today\'s Date';

  @override
  String get number => 'Student Count';

  @override
  String get save => 'Save Language';

  @override
  String get languageSaved => 'Language saved successfully';
}
