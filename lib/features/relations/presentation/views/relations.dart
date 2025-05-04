import 'package:flutter/material.dart';
import 'package:test_app/features/common/presentation/widgets/split_view.dart';
import 'package:test_app/features/relations/presentation/widgets/people.dart';
import 'package:test_app/features/relations/presentation/widgets/relations.dart';

class RelationsPage extends StatelessWidget {
  const RelationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplitView(
        navigationBuilder: (context, contentVisible) {
          return const SafeArea(child: PeopleView());
        },
        contentBuilder: (context) {
          return const SafeArea(child: RelationsView());
        },
      ),
    );
  }
}
