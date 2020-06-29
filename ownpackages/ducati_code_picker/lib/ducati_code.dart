import 'ducati_codes.dart';
import 'ducati_localizations.dart';
import 'package:flutter/cupertino.dart';

mixin ToAlias {}

@deprecated
class CElement = DucatiCode with ToAlias;

/// Country element. This is the element that contains all the information
class DucatiCode {
  /// the name of the country
  String name;

  /// the flag of the country
  final String logoUri;

  /// the country code (IT,AF..)
  final String code;

  /// the dial code (+39,+93..)
  final String dialCode;

  DucatiCode({
    this.name,
    this.logoUri,
    this.code,
    this.dialCode,
  });

  factory DucatiCode.fromCode(String isoCode) {
    final Map<String, String> jsonCode = codes.firstWhere(
      (code) => code['code'] == isoCode,
      orElse: () => null,
    );

    if (jsonCode == null) {
      return null;
    }

    return DucatiCode.fromJson(jsonCode);
  }

  DucatiCode localize(BuildContext context) {
    return this
      ..name =
          DucatiLocalizations.of(context)?.translate(this.code) ?? this.name;
  }

  factory DucatiCode.fromJson(Map<String, dynamic> json) {
    return DucatiCode(
      name: json['name'],
      code: json['code'],
      dialCode: json['dial_code'],
      logoUri: 'logos/${json['code'].toLowerCase()}.png',
    );
  }

  @override
  String toString() => "$dialCode";

  String toLongString() => "$dialCode ${toDucatiStringOnly()}";

  String toDucatiStringOnly() {
    return '$name';
  }
}
