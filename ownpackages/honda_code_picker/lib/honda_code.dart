import 'honda_codes.dart';
import 'honda_localizations.dart';
import 'package:flutter/cupertino.dart';

mixin ToAlias {}

@deprecated
class CElement = HondaCode with ToAlias;

/// Country element. This is the element that contains all the information
class HondaCode {
  /// the name of the country
  String name;

  /// the flag of the country
  final String logoUri;

  /// the country code (IT,AF..)
  final String code;

  /// the dial code (+39,+93..)
  final String dialCode;

  HondaCode({
    this.name,
    this.logoUri,
    this.code,
    this.dialCode,
  });

  factory HondaCode.fromCode(String isoCode) {
    final Map<String, String> jsonCode = codes.firstWhere(
      (code) => code['code'] == isoCode,
      orElse: () => null,
    );

    if (jsonCode == null) {
      return null;
    }

    return HondaCode.fromJson(jsonCode);
  }

  HondaCode localize(BuildContext context) {
    return this
      ..name =
          HondaLocalizations.of(context)?.translate(this.code) ?? this.name;
  }

  factory HondaCode.fromJson(Map<String, dynamic> json) {
    return HondaCode(
      name: json['name'],
      code: json['code'],
      dialCode: json['dial_code'],
      logoUri: 'logos/${json['code'].toLowerCase()}.png',
    );
  }

  @override
  String toString() => "$dialCode";

  String toLongString() => "$dialCode ${toHondaStringOnly()}";

  String toHondaStringOnly() {
    return '$name';
  }
}
