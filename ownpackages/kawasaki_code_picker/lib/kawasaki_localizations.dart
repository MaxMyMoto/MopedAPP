import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KawasakiLocalizations {
  final Locale locale;

  KawasakiLocalizations(this.locale);

  static KawasakiLocalizations of(BuildContext context) {
    return Localizations.of<KawasakiLocalizations>(
      context,
      KawasakiLocalizations,
    );
  }

  static const LocalizationsDelegate<KawasakiLocalizations> delegate =
      _KawasakiLocalizationsDelegate();

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    print('locale.languageCode: ${locale.languageCode}');
    String jsonString = await rootBundle.loadString(
        'packages/kawasaki_code_picker/i18n/${locale.languageCode}.json');
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

class _KawasakiLocalizationsDelegate
    extends LocalizationsDelegate<KawasakiLocalizations> {
  const _KawasakiLocalizationsDelegate();

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
  Future<KawasakiLocalizations> load(Locale locale) async {
    KawasakiLocalizations localizations = new KawasakiLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_KawasakiLocalizationsDelegate old) => false;
}
