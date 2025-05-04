import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';

@JsonSerializable()
@immutable
class Person {
  const Person({
    required this.uid,
    required this.name,
    required this.imageUrl,
    required this.country,
  });

  final String uid;
  final String name;
  final String imageUrl;
  final String country;

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
