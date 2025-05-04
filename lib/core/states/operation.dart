sealed class OperationState {
  const OperationState();
}

class IdleState extends OperationState {
  const IdleState() : super();
}

class SuccessState<T> extends OperationState {
  const SuccessState(this.data);

  final T data;
}

class FailureState<T> extends OperationState {
  const FailureState(this.error);

  final Exception error;
}
