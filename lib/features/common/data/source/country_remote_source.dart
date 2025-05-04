import 'package:flutter/cupertino.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test_app/core/errors/SerializationError.dart';
import 'package:test_app/core/utils/demo_reader.dart';
import 'package:test_app/features/common/data/models/country.dart';

abstract class CountryRemoteSource {
  static AutoDisposeProvider<CountryRemoteSource> provider =
      Provider.autoDispose((ref) {
        return _CountryRemoteSourceImpl(ref.watch(DemoReader.provider));
      });

  Future<Country> getCountry(String country);
}

class _CountryRemoteSourceImpl implements CountryRemoteSource {
  static const String _key = 'countries';
  final DemoReader _demoReader;

  const _CountryRemoteSourceImpl(this._demoReader);

  @override
  Future<Country> getCountry(String country) async {
    var data = await _demoReader.getData();
    return (data[_key] as List)
        .where((data) {
          return data['uid'] == country;
        })
        .map(deserialize)
        .single;
  }

  Country deserialize(dynamic p) {
    try {
      return Country.fromJson(p);
    } catch (e, s) {
      debugPrint("Error deserializing Country");
      debugPrintStack(stackTrace: s);
      throw SerializationError(serializableType: Country, data: p);
    }
  }
}
