import 'package:flutter/cupertino.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test_app/core/errors/SerializationError.dart';
import 'package:test_app/core/utils/demo_reader.dart';
import 'package:test_app/features/common/data/models/person.dart';

abstract class PeopleRemoteSource {
  static AutoDisposeProvider<PeopleRemoteSource> provider =
      Provider.autoDispose((ref) {
        return _PeopleRemoteSourceImpl(ref.watch(DemoReader.provider));
      });

  Future<List<Person>> getPeople();
}

class _PeopleRemoteSourceImpl implements PeopleRemoteSource {
  static const String _key = 'people';
  final DemoReader _demoReader;

  const _PeopleRemoteSourceImpl(this._demoReader);

  @override
  Future<List<Person>> getPeople() async {
    var data = await _demoReader.getData();
    return (data[_key] as List).map(deserialize).toList();
  }

  Person deserialize(dynamic p) {
    try {
      return Person.fromJson(p);
    } catch (e, s) {
      debugPrint("Error deserializing Person");
      debugPrintStack(stackTrace: s);
      throw SerializationError(serializableType: Person, data: p);
    }
  }
}
