import 'yamaha_codes.dart';
import 'yamaha_localizations.dart';
import 'package:flutter/cupertino.dart';

mixin ToAlias {}

@deprecated
class CElement = YamahaCode with ToAlias;

/// Country element. This is the element that contains all the information
class YamahaCode {
  /// the name of the country
  String name;

  /// the flag of the country
  final String logoUri;

  /// the country code (IT,AF..)
  final String code;

  /// the dial code (+39,+93..)
  final String dialCode;

  YamahaCode({
    this.name,
    this.logoUri,
    this.code,
    this.dialCode,
  });

  factory YamahaCode.fromCode(String isoCode) {
    final Map<String, String> jsonCode = codes.firstWhere(
      (code) => code['code'] == isoCode,
      orElse: () => null,
    );

    if (jsonCode == null) {
      return null;
    }

    return YamahaCode.fromJson(jsonCode);
  }

  YamahaCode localize(BuildContext context) {
    return this
      ..name =
          YamahaLocalizations.of(context)?.translate(this.code) ?? this.name;
  }

  factory YamahaCode.fromJson(Map<String, dynamic> json) {
    return YamahaCode(
      name: json['name'],
      code: json['code'],
      dialCode: json['dial_code'],
      logoUri: 'logos/${json['code'].toLowerCase()}.png',
    );
  }

  @override
  String toString() => "$dialCode";

  String toLongString() => "$dialCode ${toYamahaStringOnly()}";

  String toYamahaStringOnly() {
    return '$name';
  }
}
