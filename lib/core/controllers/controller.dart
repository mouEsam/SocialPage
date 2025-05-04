import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/core/states/data.dart';
import 'package:test_app/core/states/operation.dart';

abstract class Controller<T> extends StateNotifier<DataState<T>> {
  final StreamController<OperationState> _operationEvents =
      StreamController.broadcast();

  Stream<OperationState> get operationEvents => _operationEvents.stream;

  Controller({DataState<T> state = const InitialState()}) : super(state);

  @override
  void dispose() {
    super.dispose();
    _operationEvents.close();
  }

  @protected
  Future<T> fetch({required Future<T> fetchOperation}) async {
    state = state.toLoading();
    try {
      var data = await fetchOperation;
      state = state.toLoaded(data);
      return data;
    } on Exception catch (e) {
      state = state.toError(e);
      rethrow;
    }
  }

  @protected
  Future<R> operate<R>({
    required Future<R> operation,
    void Function()? onFailure,
    void Function()? onSuccess,
  }) async {
    _operationEvents.add(IdleState());
    try {
      var data = await operation;
      _operationEvents.add(SuccessState(data));
      onSuccess?.call();
      return data;
    } on Exception catch (e) {
      _operationEvents.add(FailureState(e));
      onFailure?.call();
      rethrow;
    }
  }
}
