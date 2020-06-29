import 'suzuki_codes.dart';
import 'suzuki_localizations.dart';
import 'package:flutter/cupertino.dart';

mixin ToAlias {}

@deprecated
class CElement = SuzukiCode with ToAlias;

/// Country element. This is the element that contains all the information
class SuzukiCode {
  /// the name of the country
  String name;

  /// the flag of the country
  final String logoUri;

  /// the country code (IT,AF..)
  final String code;

  /// the dial code (+39,+93..)
  final String dialCode;

  SuzukiCode({
    this.name,
    this.logoUri,
    this.code,
    this.dialCode,
  });

  factory SuzukiCode.fromCode(String isoCode) {
    final Map<String, String> jsonCode = codes.firstWhere(
      (code) => code['code'] == isoCode,
      orElse: () => null,
    );

    if (jsonCode == null) {
      return null;
    }

    return SuzukiCode.fromJson(jsonCode);
  }

  SuzukiCode localize(BuildContext context) {
    return this
      ..name =
          SuzukiLocalizations.of(context)?.translate(this.code) ?? this.name;
  }

  factory SuzukiCode.fromJson(Map<String, dynamic> json) {
    return SuzukiCode(
      name: json['name'],
      code: json['code'],
      dialCode: json['dial_code'],
      logoUri: 'logos/${json['code'].toLowerCase()}.png',
    );
  }

  @override
  String toString() => "$dialCode";

  String toLongString() => "$dialCode ${toSuzukiStringOnly()}";

  String toSuzukiStringOnly() {
    return '$name';
  }
}
