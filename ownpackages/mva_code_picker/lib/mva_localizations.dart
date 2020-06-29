import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MvaLocalizations {
  final Locale locale;

  MvaLocalizations(this.locale);

  static MvaLocalizations of(BuildContext context) {
    return Localizations.of<MvaLocalizations>(
      context,
      MvaLocalizations,
    );
  }

  static const LocalizationsDelegate<MvaLocalizations> delegate =
      _MvaLocalizationsDelegate();

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    print('locale.languageCode: ${locale.languageCode}');
    String jsonString = await rootBundle.loadString(
        'packages/mva_code_picker/i18n/${locale.languageCode}.json');
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

class _MvaLocalizationsDelegate
    extends LocalizationsDelegate<MvaLocalizations> {
  const _MvaLocalizationsDelegate();

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
  Future<MvaLocalizations> load(Locale locale) async {
    MvaLocalizations localizations = new MvaLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_MvaLocalizationsDelegate old) => false;
}
