import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/core/utils/context_utils.dart';
import 'package:test_app/core/utils/ui_state_utils.dart';
import 'package:test_app/features/common/presentation/controllers/people.dart';
import 'package:test_app/features/common/presentation/items/person.dart';
import 'package:test_app/features/common/presentation/widgets/app_text.dart';
import 'package:test_app/features/common/presentation/widgets/lifecycle.dart';
import 'package:test_app/generated/locale_keys.g.dart';

class PeopleView extends ConsumerWidget {
  const PeopleView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(PeopleController.provider.notifier);
    return WidgetLifecycleListener(
      lateInit: () {
        controller.loadPeople();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(start: 24.w, top: 32.h),
            child: AppText(
              text: LocaleKeys.relations_people_title,
              fontWeight: FontWeight.w400,
              fontSize: 20.sp,
              textColor: context.appTheme.peopleViewTitleColor,
            ),
          ),
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                var state = ref.watch(PeopleController.provider);
                return SizedBox(
                  child: state.when(
                    onLoaded: (context, data) {
                      return ListView.separated(
                        itemCount: data.length,
                        padding: EdgeInsetsDirectional.only(
                          top: 24.h,
                          start: 28.h,
                          end: 21.h,
                          bottom: 24.w,
                        ),
                        itemBuilder: (context, index) {
                          return PersonTile(person: data[index]);
                        },
                        separatorBuilder: (context, _) {
                          return SizedBox(height: 12.h);
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
