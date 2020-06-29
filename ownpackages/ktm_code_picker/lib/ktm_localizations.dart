import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KtmLocalizations {
  final Locale locale;

  KtmLocalizations(this.locale);

  static KtmLocalizations of(BuildContext context) {
    return Localizations.of<KtmLocalizations>(
      context,
      KtmLocalizations,
    );
  }

  static const LocalizationsDelegate<KtmLocalizations> delegate =
      _KtmLocalizationsDelegate();

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

class _KtmLocalizationsDelegate
    extends LocalizationsDelegate<KtmLocalizations> {
  const _KtmLocalizationsDelegate();

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
  Future<KtmLocalizations> load(Locale locale) async {
    KtmLocalizations localizations = new KtmLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_KtmLocalizationsDelegate old) => false;
}
