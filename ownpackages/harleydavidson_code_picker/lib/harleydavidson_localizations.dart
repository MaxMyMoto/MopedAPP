import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HarleydavidsonLocalizations {
  final Locale locale;

  HarleydavidsonLocalizations(this.locale);

  static HarleydavidsonLocalizations of(BuildContext context) {
    return Localizations.of<HarleydavidsonLocalizations>(
      context,
      HarleydavidsonLocalizations,
    );
  }

  static const LocalizationsDelegate<HarleydavidsonLocalizations> delegate =
      _HarleydavidsonLocalizationsDelegate();

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    print('locale.languageCode: ${locale.languageCode}');
    String jsonString = await rootBundle.loadString(
        'packages/harleydavidson_code_picker/i18n/${locale.languageCode}.json');
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

class _HarleydavidsonLocalizationsDelegate
    extends LocalizationsDelegate<HarleydavidsonLocalizations> {
  const _HarleydavidsonLocalizationsDelegate();

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
  Future<HarleydavidsonLocalizations> load(Locale locale) async {
    HarleydavidsonLocalizations localizations = new HarleydavidsonLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_HarleydavidsonLocalizationsDelegate old) => false;
}
