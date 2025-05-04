import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:riverpod/riverpod.dart';

class DemoReader {
  static var provider = Provider((ref) => DemoReader());

  bool _init = false;
  final Map<String, dynamic> _data = {};

  DemoReader();

  Future<void> _doInit() async {
    if (_init) return;
    _init = true;
    final data = await rootBundle.loadString("assets/demo.json");
    _data.addAll(jsonDecode(data));
  }

  Future<Map<String, dynamic>> getData() async {
    await _doInit();
    return Map.of(_data);
  }

  Future<void> updateData(String key, dynamic data) async {
    await _doInit();
    _data[key] = data;
  }
}
