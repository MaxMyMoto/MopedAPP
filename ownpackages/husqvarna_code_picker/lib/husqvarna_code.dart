import 'husqvarna_codes.dart';
import 'husqvarna_localizations.dart';
import 'package:flutter/cupertino.dart';

mixin ToAlias {}

@deprecated
class CElement = HusqvarnaCode with ToAlias;

/// Country element. This is the element that contains all the information
class HusqvarnaCode {
  /// the name of the country
  String name;

  /// the flag of the country
  final String logoUri;

  /// the country code (IT,AF..)
  final String code;

  /// the dial code (+39,+93..)
  final String dialCode;

  HusqvarnaCode({
    this.name,
    this.logoUri,
    this.code,
    this.dialCode,
  });

  factory HusqvarnaCode.fromCode(String isoCode) {
    final Map<String, String> jsonCode = codes.firstWhere(
      (code) => code['code'] == isoCode,
      orElse: () => null,
    );

    if (jsonCode == null) {
      return null;
    }

    return HusqvarnaCode.fromJson(jsonCode);
  }

  HusqvarnaCode localize(BuildContext context) {
    return this
      ..name =
          HusqvarnaLocalizations.of(context)?.translate(this.code) ?? this.name;
  }

  factory HusqvarnaCode.fromJson(Map<String, dynamic> json) {
    return HusqvarnaCode(
      name: json['name'],
      code: json['code'],
      dialCode: json['dial_code'],
      logoUri: 'logos/${json['code'].toLowerCase()}.png',
    );
  }

  @override
  String toString() => "$dialCode";

  String toLongString() => "$dialCode ${toHusqvarnaStringOnly()}";

  String toHusqvarnaStringOnly() {
    return '$name';
  }
}
