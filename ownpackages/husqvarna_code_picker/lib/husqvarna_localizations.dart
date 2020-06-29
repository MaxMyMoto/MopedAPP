import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HusqvarnaLocalizations {
  final Locale locale;

  HusqvarnaLocalizations(this.locale);

  static HusqvarnaLocalizations of(BuildContext context) {
    return Localizations.of<HusqvarnaLocalizations>(
      context,
      HusqvarnaLocalizations,
    );
  }

  static const LocalizationsDelegate<HusqvarnaLocalizations> delegate =
      _HusqvarnaLocalizationsDelegate();

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    print('locale.languageCode: ${locale.languageCode}');
    String jsonString = await rootBundle.loadString(
        'packages/husqvarna_code_picker/i18n/${locale.languageCode}.json');
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

class _HusqvarnaLocalizationsDelegate
    extends LocalizationsDelegate<HusqvarnaLocalizations> {
  const _HusqvarnaLocalizationsDelegate();

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
  Future<HusqvarnaLocalizations> load(Locale locale) async {
    HusqvarnaLocalizations localizations = new HusqvarnaLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_HusqvarnaLocalizationsDelegate old) => false;
}
