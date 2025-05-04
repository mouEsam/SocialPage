import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/core/utils/context_utils.dart';
import 'package:test_app/core/utils/ui_state_utils.dart';
import 'package:test_app/features/common/data/models/person.dart';
import 'package:test_app/features/common/presentation/widgets/app_text.dart';
import 'package:test_app/features/common/presentation/widgets/draggable.dart';
import 'package:test_app/features/common/presentation/widgets/lifecycle.dart';
import 'package:test_app/features/relations/data/models/relation.dart';
import 'package:test_app/features/relations/data/models/relation_type.dart';
import 'package:test_app/features/relations/presentation/controllers/relations.dart';
import 'package:test_app/features/relations/presentation/items/relation.dart';
import 'package:test_app/generated/locale_keys.g.dart';

class RelationsList extends ConsumerWidget {
  const RelationsList({
    super.key,
    required this.relationType,
    required this.person,
  });

  final Person person;
  final RelationType relationType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = RelationControllerArg(person.uid, relationType);
    final provider = RelationsController.provider(key);
    final controller = ref.watch(provider.notifier);
    return WidgetLifecycleListener(
      key: ValueKey(key),
      lateInit: controller.loadRelations,
      child: Container(
        width: 260.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(9.r)),
        ),
        clipBehavior: Clip.hardEdge,
        child: DragTarget<_DraggableRelation>(
          builder: (context, candidateItems, rejectedItems) {
            return Consumer(
              builder: (context, ref, _) {
                final state = ref.watch(provider);
                return SizedBox(
                  child: state.when(
                    onLoaded: (context, data) {
                      return _RelationsList(
                        relationType: relationType,
                        relations: data,
                      );
                    },
                  ),
                );
              },
            );
          },
          onAcceptWithDetails: (details) {
            if (details.data.relationType != relationType) {
              controller.add(details.data.relation, details.data.relationType);
            }
          },
        ),
      ),
    );
  }
}

class _RelationsList extends StatefulWidget {
  final RelationType relationType;
  final List<Relation> relations;

  const _RelationsList({
    super.key,
    required this.relationType,
    required this.relations,
  });

  @override
  State<_RelationsList> createState() => _RelationsListState();
}

class _RelationsListState extends State<_RelationsList> {
  final LinkedHashMap<Relation, bool> _relations = LinkedHashMap();

  @override
  void initState() {
    super.initState();
    _relations.addEntries(
      widget.relations.map((relation) {
        return MapEntry(relation, true);
      }),
    );
  }

  @override
  void didUpdateWidget(covariant _RelationsList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.relations != widget.relations) {
      for (final key in _relations.keys.toList()) {
        _relations[key] = false;
      }
      for (final key in widget.relations.toList()) {
        _relations[key] = true;
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {});
        }
      });
    }
  }

  void _remove(Relation key) {
    if (_relations.remove(key) != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {});
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 4.w,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: widget.relationType.relationColor(context),
          ),
          alignment: Alignment.center,
          child: AppText(
            text: LocaleKeys.values_relationType,
            enumValue: widget.relationType,
            textColor: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
          ),
        ),
        ..._relations.entries.map((entry) {
          var relation = entry.key;
          Widget item = DraggableItem(
            data: _DraggableRelation(
              relation: relation,
              relationType: widget.relationType,
            ),
            child: RelationTile(relation: relation),
          );
          if (!entry.value) {
            item = Opacity(opacity: 0.5, child: item)
                .animate(
                  onComplete: (_) {
                    _remove(entry.key);
                  },
                )
                .fadeOut()
                .scaleY(begin: 1.0, end: 0.5);
          }
          return item;
        }),
      ],
    );
  }
}

class _DraggableRelation {
  final Relation relation;
  final RelationType relationType;

  const _DraggableRelation({
    required this.relation,
    required this.relationType,
  });
}

extension on RelationType {
  Color? relationColor(BuildContext context) {
    switch (this) {
      case RelationType.positive:
        return context.appTheme.relationTypePositiveColor;
      case RelationType.neutral:
        return context.appTheme.relationTypeNeutralColor;
      case RelationType.negative:
        return context.appTheme.relationTypeNegativeColor;
    }
  }
}
