import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/core/utils/context_utils.dart';
import 'package:test_app/core/utils/ui_state_utils.dart';
import 'package:test_app/features/common/presentation/controllers/country.dart';
import 'package:test_app/features/common/presentation/controllers/people.dart';
import 'package:test_app/features/common/presentation/items/country.dart';
import 'package:test_app/features/common/presentation/widgets/lifecycle.dart';
import 'package:test_app/features/relations/data/models/relation_type.dart';
import 'package:test_app/features/relations/presentation/widgets/relations_list.dart';

class RelationsView extends StatelessWidget {
  const RelationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(start: 24.w, top: 32.h),
          child: Consumer(
            builder: (context, ref, _) {
              final person = ref.watch(PeopleController.selectedPersonProvider);
              if (person == null) {
                return SizedBox();
              }
              final provider = CountryController.provider(person.country);
              final controller = ref.watch(provider.notifier);
              return WidgetLifecycleListener(
                lateInit: () {
                  controller.loadCountry();
                },
                child: Consumer(
                  builder: (context, ref, _) {
                    final state = ref.watch(provider);
                    return SizedBox(
                      child: state.when(
                        onLoaded: (context, data) {
                          return CountryTile(country: data);
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
        Expanded(
          child: Consumer(
            builder: (context, ref, _) {
              final person = ref.watch(
                PeopleController.selectedPersonProvider,
              );
              if (person == null) return const SizedBox();

              return SingleChildScrollView(
                padding: EdgeInsetsDirectional.only(
                  start: 24.w,
                  top: 24.w,
                  bottom: 24.w,
                  end: 15.w,
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 26.w),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: appTheme.relationsListsBackgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(13.r)),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.all(12.w),
                    child: Material(
                      type: MaterialType.transparency,
                      child: IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          spacing: 28.w,
                          children:
                          [
                            RelationType.positive,
                            RelationType.neutral,
                            RelationType.negative,
                          ].map((type) {
                            return RelationsList(
                              relationType: type,
                              person: person,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          ),
        ),
      ],
    );
  }
}
