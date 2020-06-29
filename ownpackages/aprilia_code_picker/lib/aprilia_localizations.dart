import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ApriliaLocalizations {
  final Locale locale;

  ApriliaLocalizations(this.locale);

  static ApriliaLocalizations of(BuildContext context) {
    return Localizations.of<ApriliaLocalizations>(
      context,
      ApriliaLocalizations,
    );
  }

  static const LocalizationsDelegate<ApriliaLocalizations> delegate =
      _ApriliaLocalizationsDelegate();

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    print('locale.languageCode: ${locale.languageCode}');
    String jsonString = await rootBundle.loadString(
        'packages/aprilia_code_picker/i18n/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String translate(String key) {
    return _localizedStrings[key];
  }
}

class _ApriliaLocalizationsDelegate
    extends LocalizationsDelegate<ApriliaLocalizations> {
  const _ApriliaLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return [
      'en',
      'it',
      'fr',
      'es',
      'de',
      'pt',
    ].contains(locale.languageCode);
  }

  @override
  Future<ApriliaLocalizations> load(Locale locale) async {
    ApriliaLocalizations localizations = new ApriliaLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_ApriliaLocalizationsDelegate old) => false;
}
