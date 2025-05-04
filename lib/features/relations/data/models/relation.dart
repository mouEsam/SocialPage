import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'relation.g.dart';

@JsonSerializable()
@immutable
class Relation {
  const Relation({
    required this.uid,
    required this.title,
    required this.name,
    required this.imageUrl,
  });

  final String uid;
  final String title;
  final String name;
  final String imageUrl;

  factory Relation.fromJson(Map<String, dynamic> json) =>
      _$RelationFromJson(json);

  Map<String, dynamic> toJson() => _$RelationToJson(this);
}
