import 'kawasaki_codes.dart';
import 'kawasaki_localizations.dart';
import 'package:flutter/cupertino.dart';

mixin ToAlias {}

@deprecated
class CElement = KawasakiCode with ToAlias;

/// Country element. This is the element that contains all the information
class KawasakiCode {
  /// the name of the country
  String name;

  /// the flag of the country
  final String logoUri;

  /// the country code (IT,AF..)
  final String code;

  /// the dial code (+39,+93..)
  final String dialCode;

  KawasakiCode({
    this.name,
    this.logoUri,
    this.code,
    this.dialCode,
  });

  factory KawasakiCode.fromCode(String isoCode) {
    final Map<String, String> jsonCode = codes.firstWhere(
      (code) => code['code'] == isoCode,
      orElse: () => null,
    );

    if (jsonCode == null) {
      return null;
    }

    return KawasakiCode.fromJson(jsonCode);
  }

  KawasakiCode localize(BuildContext context) {
    return this
      ..name =
          KawasakiLocalizations.of(context)?.translate(this.code) ?? this.name;
  }

  factory KawasakiCode.fromJson(Map<String, dynamic> json) {
    return KawasakiCode(
      name: json['name'],
      code: json['code'],
      dialCode: json['dial_code'],
      logoUri: 'logos/${json['code'].toLowerCase()}.png',
    );
  }

  @override
  String toString() => "$dialCode";

  String toLongString() => "$dialCode ${toKawasakiStringOnly()}";

  String toKawasakiStringOnly() {
    return '$name';
  }
}
