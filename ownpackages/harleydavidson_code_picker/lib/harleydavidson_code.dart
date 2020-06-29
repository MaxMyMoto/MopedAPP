import 'harleydavidson_codes.dart';
import 'harleydavidson_localizations.dart';
import 'package:flutter/cupertino.dart';

mixin ToAlias {}

@deprecated
class CElement = HarleydavidsonCode with ToAlias;

/// Country element. This is the element that contains all the information
class HarleydavidsonCode {
  /// the name of the country
  String name;

  /// the flag of the country
  final String logoUri;

  /// the country code (IT,AF..)
  final String code;

  /// the dial code (+39,+93..)
  final String dialCode;

  HarleydavidsonCode({
    this.name,
    this.logoUri,
    this.code,
    this.dialCode,
  });

  factory HarleydavidsonCode.fromCode(String isoCode) {
    final Map<String, String> jsonCode = codes.firstWhere(
      (code) => code['code'] == isoCode,
      orElse: () => null,
    );

    if (jsonCode == null) {
      return null;
    }

    return HarleydavidsonCode.fromJson(jsonCode);
  }

  HarleydavidsonCode localize(BuildContext context) {
    return this
      ..name =
          HarleydavidsonLocalizations.of(context)?.translate(this.code) ?? this.name;
  }

  factory HarleydavidsonCode.fromJson(Map<String, dynamic> json) {
    return HarleydavidsonCode(
      name: json['name'],
      code: json['code'],
      dialCode: json['dial_code'],
      logoUri: 'logos/${json['code'].toLowerCase()}.png',
    );
  }

  @override
  String toString() => "$dialCode";

  String toLongString() => "$dialCode ${toHarleydavidsonStringOnly()}";

  String toHarleydavidsonStringOnly() {
    return '$name';
  }
}
