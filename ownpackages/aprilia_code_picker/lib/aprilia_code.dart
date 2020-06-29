import 'aprilia_codes.dart';
import 'aprilia_localizations.dart';
import 'package:flutter/cupertino.dart';

mixin ToAlias {}

@deprecated
class CElement = ApriliaCode with ToAlias;

/// Country element. This is the element that contains all the information
class ApriliaCode {
  /// the name of the country
  String name;

  /// the flag of the country
  final String logoUri;

  /// the country code (IT,AF..)
  final String code;

  /// the dial code (+39,+93..)
  final String dialCode;

  ApriliaCode({
    this.name,
    this.logoUri,
    this.code,
    this.dialCode,
  });

  factory ApriliaCode.fromCode(String isoCode) {
    final Map<String, String> jsonCode = codes.firstWhere(
      (code) => code['code'] == isoCode,
      orElse: () => null,
    );

    if (jsonCode == null) {
      return null;
    }

    return ApriliaCode.fromJson(jsonCode);
  }

  ApriliaCode localize(BuildContext context) {
    return this
      ..name =
          ApriliaLocalizations.of(context)?.translate(this.code) ?? this.name;
  }

  factory ApriliaCode.fromJson(Map<String, dynamic> json) {
    return ApriliaCode(
      name: json['name'],
      code: json['code'],
      dialCode: json['dial_code'],
      logoUri: 'logos/${json['code'].toLowerCase()}.png',
    );
  }

  @override
  String toString() => "$dialCode";

  String toLongString() => "$dialCode ${toApriliaStringOnly()}";

  String toApriliaStringOnly() {
    return '$name';
  }
}
