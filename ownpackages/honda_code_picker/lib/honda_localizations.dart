import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HondaLocalizations {
  final Locale locale;

  HondaLocalizations(this.locale);

  static HondaLocalizations of(BuildContext context) {
    return Localizations.of<HondaLocalizations>(
      context,
      HondaLocalizations,
    );
  }

  static const LocalizationsDelegate<HondaLocalizations> delegate =
      _HondaLocalizationsDelegate();

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    print('locale.languageCode: ${locale.languageCode}');
    String jsonString = await rootBundle.loadString(
        'packages/honda_code_picker/i18n/${locale.languageCode}.json');
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

class _HondaLocalizationsDelegate
    extends LocalizationsDelegate<HondaLocalizations> {
  const _HondaLocalizationsDelegate();

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
  Future<HondaLocalizations> load(Locale locale) async {
    HondaLocalizations localizations = new HondaLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_HondaLocalizationsDelegate old) => false;
}
