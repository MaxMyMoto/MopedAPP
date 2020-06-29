import 'ktm_codes.dart';
import 'ktm_localizations.dart';
import 'package:flutter/cupertino.dart';

mixin ToAlias {}

@deprecated
class CElement = KtmCode with ToAlias;

/// Country element. This is the element that contains all the information
class KtmCode {
  /// the name of the country
  String name;

  /// the flag of the country
  final String logoUri;

  /// the country code (IT,AF..)
  final String code;

  /// the dial code (+39,+93..)
  final String dialCode;

  KtmCode({
    this.name,
    this.logoUri,
    this.code,
    this.dialCode,
  });

  factory KtmCode.fromCode(String isoCode) {
    final Map<String, String> jsonCode = codes.firstWhere(
      (code) => code['code'] == isoCode,
      orElse: () => null,
    );

    if (jsonCode == null) {
      return null;
    }

    return KtmCode.fromJson(jsonCode);
  }

  KtmCode localize(BuildContext context) {
    return this
      ..name =
          KtmLocalizations.of(context)?.translate(this.code) ?? this.name;
  }

  factory KtmCode.fromJson(Map<String, dynamic> json) {
    return KtmCode(
      name: json['name'],
      code: json['code'],
      dialCode: json['dial_code'],
      logoUri: 'logos/${json['code'].toLowerCase()}.png',
    );
  }

  @override
  String toString() => "$dialCode";

  String toLongString() => "$dialCode ${toKtmStringOnly()}";

  String toKtmStringOnly() {
    return '$name';
  }
}
