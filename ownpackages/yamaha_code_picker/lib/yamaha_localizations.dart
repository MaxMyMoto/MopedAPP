import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class YamahaLocalizations {
  final Locale locale;

  YamahaLocalizations(this.locale);

  static YamahaLocalizations of(BuildContext context) {
    return Localizations.of<YamahaLocalizations>(
      context,
      YamahaLocalizations,
    );
  }

  static const LocalizationsDelegate<YamahaLocalizations> delegate =
      _YamahaLocalizationsDelegate();

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    print('locale.languageCode: ${locale.languageCode}');
    String jsonString = await rootBundle.loadString(
        'packages/yamaha_code_picker/i18n/${locale.languageCode}.json');
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

class _YamahaLocalizationsDelegate
    extends LocalizationsDelegate<YamahaLocalizations> {
  const _YamahaLocalizationsDelegate();

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
  Future<YamahaLocalizations> load(Locale locale) async {
    YamahaLocalizations localizations = new YamahaLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_YamahaLocalizationsDelegate old) => false;
}
