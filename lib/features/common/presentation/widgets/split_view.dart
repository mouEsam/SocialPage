import 'package:flutter/material.dart';
import 'package:test_app/core/utils/context_utils.dart';

typedef NavigationWidgetBuilder =
    Widget Function(BuildContext context, bool contentVisible);

class SplitView extends StatelessWidget {
  const SplitView({
    super.key,
    required this.navigationBuilder,
    required this.contentBuilder,
    this.breakpoint = 600,
    this.navigationWidth = 400,
  });

  final NavigationWidgetBuilder navigationBuilder;
  final WidgetBuilder contentBuilder;
  final double breakpoint;
  final double navigationWidth;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    if (screenWidth >= breakpoint) {
      final dividerColor = context.appTheme.mainDividerColor;
      return Row(
        children: [
          SizedBox(
            width: navigationWidth,
            child: navigationBuilder(context, true),
          ),
          VerticalDivider(
            width: 1,
            thickness: 1,
            indent: 0,
            endIndent: 0,
            color: dividerColor,
          ),
          Expanded(child: contentBuilder(context)),
        ],
      );
    } else {
      return navigationBuilder(context, false);
    }
  }
}
