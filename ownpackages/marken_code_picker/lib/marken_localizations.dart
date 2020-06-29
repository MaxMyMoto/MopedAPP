import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MarkenLocalizations {
  final Locale locale;

  MarkenLocalizations(this.locale);

  static MarkenLocalizations of(BuildContext context) {
    return Localizations.of<MarkenLocalizations>(
      context,
      MarkenLocalizations,
    );
  }

  static const LocalizationsDelegate<MarkenLocalizations> delegate =
      _MarkenLocalizationsDelegate();

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    print('locale.languageCode: ${locale.languageCode}');
    String jsonString = await rootBundle.loadString(
        'packages/marken_code_picker/i18n/${locale.languageCode}.json');
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

class _MarkenLocalizationsDelegate
    extends LocalizationsDelegate<MarkenLocalizations> {
  const _MarkenLocalizationsDelegate();

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
  Future<MarkenLocalizations> load(Locale locale) async {
    MarkenLocalizations localizations = new MarkenLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_MarkenLocalizationsDelegate old) => false;
}
