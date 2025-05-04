// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file


part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
  uid: json['uid'] as String,
  name: json['name'] as String,
  imageUrl: json['imageUrl'] as String,
  country: json['country'] as String,
);

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
  'uid': instance.uid,
  'name': instance.name,
  'imageUrl': instance.imageUrl,
  'country': instance.country,
};
