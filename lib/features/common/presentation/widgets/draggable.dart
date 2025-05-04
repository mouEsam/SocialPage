import 'package:flutter/material.dart';

class DraggableItem<T extends Object> extends StatefulWidget {
  const DraggableItem({super.key, required this.child, required this.data});

  final T data;
  final Widget child;

  @override
  State<DraggableItem<T>> createState() => _DraggableItemState<T>();
}

class _DraggableItemState<T extends Object> extends State<DraggableItem<T>> {
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<T>(
      data: widget.data,
      feedback: Builder(
        builder: (context) {
          var renderBox = _key.currentContext?.findRenderObject() as RenderBox;
          return ConstrainedBox(
            constraints: renderBox.constraints,
            child: Material(
              type: MaterialType.transparency,
              child: widget.child,
            ),
          );
        },
      ),
      childWhenDragging: Opacity(opacity: 0.5, child: widget.child),
      child: SizedBox(key: _key, child: widget.child),
    );
  }
}
