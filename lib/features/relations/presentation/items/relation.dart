import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/core/utils/context_utils.dart';
import 'package:test_app/features/common/presentation/widgets/app_text.dart';
import 'package:test_app/features/common/presentation/widgets/image.dart';
import 'package:test_app/features/relations/data/models/relation.dart';

class RelationTile extends StatelessWidget {
  const RelationTile({super.key, required this.relation});

  final Relation relation;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(9.r)),
      ),
      contentPadding: EdgeInsetsDirectional.only(
        start: 6.w,
        top: 8.w,
        bottom: 8.w,
        end: 8.w,
      ),
      minTileHeight: 0,
      minVerticalPadding: 0,
      tileColor: context.appTheme.relationBackgroundColor,
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 6.w,
        children: [
          Icon(
            Icons.drag_handle,
            size: 20.w,
            color: context.appTheme.relationDragHandleColor,
          ),
          SizedBox.square(
            dimension: 32.w,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(7.r)),
                border: Border.all(
                  color: Colors.black.withValues(alpha: 0.2),
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
              ),
              clipBehavior: Clip.hardEdge,
              child: AppImage(imageUrl: relation.imageUrl),
            ),
          ),
        ],
      ),
      title: AppText(
        text: relation.title,
        localize: false,
        fontWeight: FontWeight.w300,
        fontSize: 12.sp,
        textColor: context.appTheme.relationViewTitleColor,
      ),
      subtitle: AppText(
        text: relation.name,
        localize: false,
        fontWeight: FontWeight.w300,
        fontSize: 14.sp,
      ),
    );
  }
}
