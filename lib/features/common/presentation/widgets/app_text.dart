import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/core/extensions/gender.dart';

class AppText extends StatelessWidget {
  const AppText({
    super.key,
    required this.text,
    this.localize = true,
    this.toPluralize,
    this.textArgs,
    this.textNamedArgs,
    this.gender,
    this.fontWeight,
    this.enumValue,
    this.keyValue,
    this.textColor,
    this.fontSize,
  });

  final String text;
  final double? toPluralize;
  final List<String>? textArgs;
  final Map<String, String>? textNamedArgs;
  final Gender? gender;
  final bool localize;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Enum? enumValue;
  final String? keyValue;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: _genText(context),
        style: TextStyle(
          fontWeight: fontWeight,
          color: textColor,
          fontSize: fontSize,
        ),
      ),
    );
  }

  String _genText(BuildContext context) {
    var text = this.text;
    if (enumValue != null) {
      text += '.${enumValue?.name}';
    }
    if (keyValue != null) {
      text += '.$keyValue';
    }
    if (!localize) {
      return text;
    }
    if (toPluralize != null) {
      return text.plural(
        toPluralize!,
        context: context,
        args: textArgs,
        namedArgs: textNamedArgs,
      );
    }
    return text.tr(
      context: context,
      args: textArgs,
      namedArgs: textNamedArgs,
      gender: gender?.name,
    );
  }
}
