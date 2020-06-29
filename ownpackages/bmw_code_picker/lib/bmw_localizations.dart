import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BmwLocalizations {
  final Locale locale;

  BmwLocalizations(this.locale);

  static BmwLocalizations of(BuildContext context) {
    return Localizations.of<BmwLocalizations>(
      context,
      BmwLocalizations,
    );
  }

  static const LocalizationsDelegate<BmwLocalizations> delegate =
      _BmwLocalizationsDelegate();

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    print('locale.languageCode: ${locale.languageCode}');
    String jsonString = await rootBundle.loadString(
        'packages/bmw_code_picker/i18n/${locale.languageCode}.json');
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

class _BmwLocalizationsDelegate
    extends LocalizationsDelegate<BmwLocalizations> {
  const _BmwLocalizationsDelegate();

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
  Future<BmwLocalizations> load(Locale locale) async {
    BmwLocalizations localizations = new BmwLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_BmwLocalizationsDelegate old) => false;
}
