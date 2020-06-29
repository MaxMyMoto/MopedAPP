import 'mva_codes.dart';
import 'mva_localizations.dart';
import 'package:flutter/cupertino.dart';

mixin ToAlias {}

@deprecated
class CElement = MvaCode with ToAlias;

/// Country element. This is the element that contains all the information
class MvaCode {
  /// the name of the country
  String name;

  /// the flag of the country
  final String logoUri;

  /// the country code (IT,AF..)
  final String code;

  /// the dial code (+39,+93..)
  final String dialCode;

  MvaCode({
    this.name,
    this.logoUri,
    this.code,
    this.dialCode,
  });

  factory MvaCode.fromCode(String isoCode) {
    final Map<String, String> jsonCode = codes.firstWhere(
      (code) => code['code'] == isoCode,
      orElse: () => null,
    );

    if (jsonCode == null) {
      return null;
    }

    return MvaCode.fromJson(jsonCode);
  }

  MvaCode localize(BuildContext context) {
    return this
      ..name =
          MvaLocalizations.of(context)?.translate(this.code) ?? this.name;
  }

  factory MvaCode.fromJson(Map<String, dynamic> json) {
    return MvaCode(
      name: json['name'],
      code: json['code'],
      dialCode: json['dial_code'],
      logoUri: 'logos/${json['code'].toLowerCase()}.png',
    );
  }

  @override
  String toString() => "$dialCode";

  String toLongString() => "$dialCode ${toMvaStringOnly()}";

  String toMvaStringOnly() {
    return '$name';
  }
}
