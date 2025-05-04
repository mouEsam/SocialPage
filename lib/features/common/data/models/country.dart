import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

@JsonSerializable()
@immutable
class Country {
  const Country({required this.uid, required this.code, required this.icon});

  final String uid;
  final String code;
  final String icon;

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);
}
