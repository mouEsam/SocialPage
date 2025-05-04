// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> _en = {
  "relations": {
    "people": {
      "title": "Relations"
    }
  },
  "values": {
    "countries": {
      "uk": "United Kingdom"
    },
    "relationType": {
      "positive": "Positive",
      "neutral": "Neutral",
      "negative": "Negative"
    }
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": _en};
}
