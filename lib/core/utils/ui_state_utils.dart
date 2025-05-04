import 'package:flutter/widgets.dart';
import 'package:test_app/core/states/data.dart';
import 'package:test_app/core/utils/object_utils.dart';

typedef InitialBuilder = Widget? Function(BuildContext context);
typedef LoadingBuilder<T> = Widget? Function(BuildContext context, T? data);
typedef ErrorBuilder<T> =
    Widget? Function(BuildContext context, Exception error, T? data);
typedef LoadedBuilder<T> = Widget? Function(BuildContext context, T data);

extension UiStateUtils<T> on DataState<T> {
  Widget? when({
    InitialBuilder? onInitial,
    LoadingBuilder<T>? onLoading,
    LoadedBuilder<T>? onLoaded,
    ErrorBuilder<T>? onError,
  }) {
    return switch (this) {
      InitialState() => onInitial.ifNotNull((onInitial) {
        return Builder(
          builder: (context) {
            return SizedBox(child: onInitial(context));
          },
        );
      }),
      LoadedState(data: T data) => onLoaded.ifNotNull((onLoaded) {
        return Builder(
          builder: (context) {
            return SizedBox(child: onLoaded(context, data));
          },
        );
      }),
      LoadingState(data: T? data) => onLoading.ifNotNull((onLoading) {
        return Builder(
          builder: (context) {
            return SizedBox(child: onLoading(context, data));
          },
        );
      }),
      ErrorState(error: Exception error, data: T? data) => onError.ifNotNull((
        onError,
      ) {
        return Builder(
          builder: (context) {
            return SizedBox(child: onError(context, error, data));
          },
        );
      }),
    };
  }
}
