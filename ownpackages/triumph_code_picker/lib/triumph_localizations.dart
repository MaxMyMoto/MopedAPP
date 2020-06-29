import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TriumphLocalizations {
  final Locale locale;

  TriumphLocalizations(this.locale);

  static TriumphLocalizations of(BuildContext context) {
    return Localizations.of<TriumphLocalizations>(
      context,
      TriumphLocalizations,
    );
  }

  static const LocalizationsDelegate<TriumphLocalizations> delegate =
      _TriumphLocalizationsDelegate();

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    print('locale.languageCode: ${locale.languageCode}');
    String jsonString = await rootBundle.loadString(
        'packages/triumph_code_picker/i18n/${locale.languageCode}.json');
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

class _TriumphLocalizationsDelegate
    extends LocalizationsDelegate<TriumphLocalizations> {
  const _TriumphLocalizationsDelegate();

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
  Future<TriumphLocalizations> load(Locale locale) async {
    TriumphLocalizations localizations = new TriumphLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_TriumphLocalizationsDelegate old) => false;
}
