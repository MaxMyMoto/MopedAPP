import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SuzukiLocalizations {
  final Locale locale;

  SuzukiLocalizations(this.locale);

  static SuzukiLocalizations of(BuildContext context) {
    return Localizations.of<SuzukiLocalizations>(
      context,
      SuzukiLocalizations,
    );
  }

  static const LocalizationsDelegate<SuzukiLocalizations> delegate =
      _SuzukiLocalizationsDelegate();

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    print('locale.languageCode: ${locale.languageCode}');
    String jsonString = await rootBundle.loadString(
        'packages/suzuki_code_picker/i18n/${locale.languageCode}.json');
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

class _SuzukiLocalizationsDelegate
    extends LocalizationsDelegate<SuzukiLocalizations> {
  const _SuzukiLocalizationsDelegate();

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
  Future<SuzukiLocalizations> load(Locale locale) async {
    SuzukiLocalizations localizations = new SuzukiLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_SuzukiLocalizationsDelegate old) => false;
}
