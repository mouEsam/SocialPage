import 'package:flutter/material.dart';
import 'package:test_app/core/utils/color_utils.dart';
import 'package:test_app/core/utils/context_utils.dart';

class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  final Color mainDividerColor;
  final Color personImageShadowColor;
  final Color relationsListsBackgroundColor;
  final Color relationTypePositiveColor;
  final Color relationTypeNegativeColor;
  final Color relationTypeNeutralColor;
  final Color relationDragHandleColor;
  final Color relationBackgroundColor;

  final Color peopleViewTitleColor;
  final Color personViewTitleColor;
  final Color relationsViewTitleColor;
  final Color relationViewTitleColor;

  const AppThemeExtension({
    required this.mainDividerColor,
    required this.personImageShadowColor,
    required this.relationsListsBackgroundColor,
    required this.relationTypePositiveColor,
    required this.relationTypeNegativeColor,
    required this.relationTypeNeutralColor,
    required this.relationDragHandleColor,
    required this.relationBackgroundColor,
    required this.peopleViewTitleColor,
    required this.personViewTitleColor,
    required this.relationsViewTitleColor,
    required this.relationViewTitleColor,
  });

  @override
  ThemeExtension<AppThemeExtension> copyWith() {
    return AppThemeExtension(
      mainDividerColor: mainDividerColor,
      personImageShadowColor: personImageShadowColor,
      relationsListsBackgroundColor: relationsListsBackgroundColor,
      relationTypePositiveColor: relationTypePositiveColor,
      relationTypeNegativeColor: relationTypeNegativeColor,
      relationTypeNeutralColor: relationTypeNeutralColor,
      relationDragHandleColor: relationDragHandleColor,
      relationBackgroundColor: relationBackgroundColor,
      peopleViewTitleColor: peopleViewTitleColor,
      personViewTitleColor: personViewTitleColor,
      relationsViewTitleColor: relationsViewTitleColor,
      relationViewTitleColor: relationViewTitleColor,
    );
  }

  @override
  ThemeExtension<AppThemeExtension> lerp(
    covariant ThemeExtension<AppThemeExtension>? other,
    double t,
  ) {
    var otherExt = other as AppThemeExtension;
    return AppThemeExtension(
      mainDividerColor: mainDividerColor.lerp(otherExt.mainDividerColor, t),
      personImageShadowColor: personImageShadowColor.lerp(
        otherExt.personImageShadowColor,
        t,
      ),
      relationsListsBackgroundColor: relationsListsBackgroundColor.lerp(
        otherExt.relationsListsBackgroundColor,
        t,
      ),
      relationTypePositiveColor: relationTypePositiveColor.lerp(
        otherExt.relationTypePositiveColor,
        t,
      ),
      relationTypeNegativeColor: relationTypeNegativeColor.lerp(
        otherExt.relationTypeNegativeColor,
        t,
      ),
      relationTypeNeutralColor: relationTypeNeutralColor.lerp(
        otherExt.relationTypeNeutralColor,
        t,
      ),
      relationDragHandleColor: relationDragHandleColor.lerp(
        otherExt.relationDragHandleColor,
        t,
      ),
      relationBackgroundColor: relationBackgroundColor.lerp(
        otherExt.relationBackgroundColor,
        t,
      ),
      peopleViewTitleColor: peopleViewTitleColor.lerp(
        otherExt.peopleViewTitleColor,
        t,
      ),
      personViewTitleColor: personViewTitleColor.lerp(
        otherExt.personViewTitleColor,
        t,
      ),
      relationsViewTitleColor: relationsViewTitleColor.lerp(
        otherExt.relationsViewTitleColor,
        t,
      ),
      relationViewTitleColor: relationViewTitleColor.lerp(
        otherExt.relationViewTitleColor,
        t,
      ),
    );
  }

  static AppThemeExtension of(BuildContext context) {
    return context.theme.extension<AppThemeExtension>()!;
  }
}
