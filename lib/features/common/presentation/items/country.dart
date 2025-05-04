import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/core/utils/context_utils.dart';
import 'package:test_app/features/common/data/models/country.dart';
import 'package:test_app/features/common/presentation/widgets/app_text.dart';
import 'package:test_app/features/common/presentation/widgets/image.dart';
import 'package:test_app/generated/locale_keys.g.dart';

class CountryTile extends StatelessWidget {
  const CountryTile({super.key, required this.country});

  final Country country;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 30.w,
          width: 40.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(9.r)),
            border: Border.all(
              color: Colors.black.withValues(alpha: 0.09),
              strokeAlign: BorderSide.strokeAlignInside,
            ),
          ),
          clipBehavior: Clip.hardEdge,
          child: AppImage(imageUrl: country.icon),
        ),
        SizedBox(width: 8.w),
        AppText(
          text: LocaleKeys.values_countries,
          fontWeight: FontWeight.w300,
          fontSize: 16.sp,
          textColor: context.appTheme.relationsViewTitleColor,
          keyValue: country.code,
        ),
      ],
    );
  }
}
