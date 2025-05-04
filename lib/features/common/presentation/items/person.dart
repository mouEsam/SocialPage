import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/core/utils/bool_utils.dart';
import 'package:test_app/core/utils/context_utils.dart';
import 'package:test_app/features/common/data/models/person.dart';
import 'package:test_app/features/common/presentation/controllers/people.dart';
import 'package:test_app/features/common/presentation/widgets/app_text.dart';
import 'package:test_app/features/common/presentation/widgets/image.dart';

class PersonTile extends ConsumerWidget {
  const PersonTile({super.key, required this.person});

  final Person person;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var selected = ref.watch(
      PeopleController.selectedPersonProvider.select((state) {
        return state == person;
      }),
    );
    var controller = ref.watch(PeopleController.provider.notifier);
    return ListTile(
      onTap: () => controller.select(person),
      selected: selected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(9.r)),
      ),
      minTileHeight: 60.w,
      leading: SizedBox.square(
        dimension: 60.w,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(9.r)),
            boxShadow: [
              BoxShadow(
                color: context.appTheme.personImageShadowColor,
                offset: Offset(0, 4),
                blurRadius: 4,
              ),
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: AppImage(imageUrl: person.imageUrl),
        ),
      ),
      title: AppText(
        text: person.name,
        localize: false,
        fontWeight: selected.ifTrue(FontWeight.w500, orElse: FontWeight.w300),
        fontSize: selected.ifTrue(14, orElse: 15)?.sp,
        textColor: selected.ifFalse(context.appTheme.personViewTitleColor),
      ),
    );
  }
}
