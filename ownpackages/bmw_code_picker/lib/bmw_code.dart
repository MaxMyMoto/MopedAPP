import 'bmw_codes.dart';
import 'bmw_localizations.dart';
import 'package:flutter/cupertino.dart';

mixin ToAlias {}

@deprecated
class CElement = BmwCode with ToAlias;

/// Country element. This is the element that contains all the information
class BmwCode {
  /// the name of the country
  String name;

  /// the flag of the country
  final String logoUri;

  /// the country code (IT,AF..)
  final String code;

  /// the dial code (+39,+93..)
  final String dialCode;

  BmwCode({
    this.name,
    this.logoUri,
    this.code,
    this.dialCode,
  });

  factory BmwCode.fromCode(String isoCode) {
    final Map<String, String> jsonCode = codes.firstWhere(
      (code) => code['code'] == isoCode,
      orElse: () => null,
    );

    if (jsonCode == null) {
      return null;
    }

    return BmwCode.fromJson(jsonCode);
  }

  BmwCode localize(BuildContext context) {
    return this
      ..name =
          BmwLocalizations.of(context)?.translate(this.code) ?? this.name;
  }

  factory BmwCode.fromJson(Map<String, dynamic> json) {
    return BmwCode(
      name: json['name'],
      code: json['code'],
      dialCode: json['dial_code'],
      logoUri: 'logos/${json['code'].toLowerCase()}.png',
    );
  }

  @override
  String toString() => "$dialCode";

  String toLongString() => "$dialCode ${toBmwStringOnly()}";

  String toBmwStringOnly() {
    return '$name';
  }
}
