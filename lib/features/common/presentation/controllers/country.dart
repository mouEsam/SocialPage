import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/core/controllers/controller.dart';
import 'package:test_app/features/common/data/models/country.dart';
import 'package:test_app/features/common/data/source/country_remote_source.dart';

class CountryController extends Controller<Country> {
  static var provider = StateNotifierProvider.autoDispose.family((
    ref,
    String uid,
  ) {
    return CountryController(uid, ref.watch(CountryRemoteSource.provider));
  });

  final String uid;
  final CountryRemoteSource _countryRemoteSource;

  CountryController(this.uid, this._countryRemoteSource) : super();

  Future<void> loadCountry() async {
    await fetch(fetchOperation: _countryRemoteSource.getCountry(uid));
  }
}
