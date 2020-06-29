import 'triumph_codes.dart';
import 'triumph_localizations.dart';
import 'package:flutter/cupertino.dart';

mixin ToAlias {}

@deprecated
class CElement = TriumphCode with ToAlias;

/// Country element. This is the element that contains all the information
class TriumphCode {
  /// the name of the country
  String name;

  /// the flag of the country
  final String logoUri;

  /// the country code (IT,AF..)
  final String code;

  /// the dial code (+39,+93..)
  final String dialCode;

  TriumphCode({
    this.name,
    this.logoUri,
    this.code,
    this.dialCode,
  });

  factory TriumphCode.fromCode(String isoCode) {
    final Map<String, String> jsonCode = codes.firstWhere(
      (code) => code['code'] == isoCode,
      orElse: () => null,
    );

    if (jsonCode == null) {
      return null;
    }

    return TriumphCode.fromJson(jsonCode);
  }

  TriumphCode localize(BuildContext context) {
    return this
      ..name =
          TriumphLocalizations.of(context)?.translate(this.code) ?? this.name;
  }

  factory TriumphCode.fromJson(Map<String, dynamic> json) {
    return TriumphCode(
      name: json['name'],
      code: json['code'],
      dialCode: json['dial_code'],
      logoUri: 'logos/${json['code'].toLowerCase()}.png',
    );
  }

  @override
  String toString() => "$dialCode";

  String toLongString() => "$dialCode ${toTriumphStringOnly()}";

  String toTriumphStringOnly() {
    return '$name';
  }
}
