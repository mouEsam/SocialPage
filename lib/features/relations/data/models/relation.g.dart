// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file


part of 'relation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Relation _$RelationFromJson(Map<String, dynamic> json) => Relation(
  uid: json['uid'] as String,
  title: json['title'] as String,
  name: json['name'] as String,
  imageUrl: json['imageUrl'] as String,
);

Map<String, dynamic> _$RelationToJson(Relation instance) => <String, dynamic>{
  'uid': instance.uid,
  'title': instance.title,
  'name': instance.name,
  'imageUrl': instance.imageUrl,
};
