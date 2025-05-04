import 'package:flutter/cupertino.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test_app/core/errors/SerializationError.dart';
import 'package:test_app/core/utils/demo_reader.dart';
import 'package:test_app/features/relations/data/models/relation.dart';
import 'package:test_app/features/relations/data/models/relation_type.dart';

abstract class RelationsRemoteSource {
  static AutoDisposeProvider<RelationsRemoteSource> provider =
      Provider.autoDispose((ref) {
        return _RelationsRemoteSourceImpl(ref.watch(DemoReader.provider));
      });

  Future<List<Relation>> getRelations(String person, RelationType type);

  Future<void> updateRelation(Relation relation, RelationType relationType);
}

class _RelationsRemoteSourceImpl implements RelationsRemoteSource {
  static const String _key = 'relations';
  final DemoReader _demoReader;

  const _RelationsRemoteSourceImpl(this._demoReader);

  @override
  Future<List<Relation>> getRelations(String person, RelationType type) async {
    var data = await _demoReader.getData();
    return (data[_key] as List)
        .where((p) {
          return p['person'] == person && p['relationType'] == type.name;
        })
        .map(deserialize)
        .toList();
  }

  @override
  Future<void> updateRelation(
    Relation relation,
    RelationType relationType,
  ) async {
    var data = await _demoReader.getData();
    var list = (data[_key] as List);
    var object =
        list.where((p) {
          return p['uid'] == relation.uid;
        }).singleOrNull;
    if (object != null) {
      object['relationType'] = relationType.name;
    }
    _demoReader.updateData(_key, list);
  }

  Relation deserialize(dynamic p) {
    try {
      return Relation.fromJson(p);
    } catch (e, s) {
      debugPrint("Error deserializing Relation");
      debugPrintStack(stackTrace: s);
      throw SerializationError(serializableType: Relation, data: p);
    }
  }
}
