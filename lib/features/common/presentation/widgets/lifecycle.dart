import 'package:flutter/material.dart';

class WidgetLifecycleListener extends StatefulWidget {
  const WidgetLifecycleListener({
    super.key,
    this.init,
    this.lateInit,
    this.dispose,
    required this.child,
  });

  final Function? init;
  final Function? lateInit;
  final Function? dispose;
  final Widget child;

  @override
  State<WidgetLifecycleListener> createState() =>
      _WidgetLifecycleListenerState();
}

class _WidgetLifecycleListenerState extends State<WidgetLifecycleListener> {
  @override
  void initState() {
    super.initState();
    widget.init?.call();
    Future(() {
      widget.lateInit?.call();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.dispose?.call();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
