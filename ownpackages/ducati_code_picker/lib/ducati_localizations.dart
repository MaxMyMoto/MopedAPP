import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DucatiLocalizations {
  final Locale locale;

  DucatiLocalizations(this.locale);

  static DucatiLocalizations of(BuildContext context) {
    return Localizations.of<DucatiLocalizations>(
      context,
      DucatiLocalizations,
    );
  }

  static const LocalizationsDelegate<DucatiLocalizations> delegate =
      _DucatiLocalizationsDelegate();

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    print('locale.languageCode: ${locale.languageCode}');
    String jsonString = await rootBundle.loadString(
        'packages/ducati_code_picker/i18n/${locale.languageCode}.json');
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

class _DucatiLocalizationsDelegate
    extends LocalizationsDelegate<DucatiLocalizations> {
  const _DucatiLocalizationsDelegate();

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
  Future<DucatiLocalizations> load(Locale locale) async {
    DucatiLocalizations localizations = new DucatiLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_DucatiLocalizationsDelegate old) => false;
}
