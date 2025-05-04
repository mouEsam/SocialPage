sealed class DataState<T> {
  final T? _data;

  const DataState(this._data);

  bool get isLoading => false;

  bool get isLoaded => false;

  T? get data => _data;

  DataState<T> updateData(T data);
}

class InitialState<T> extends DataState<T> {
  const InitialState() : super(null);

  @override
  DataState<T> updateData(T data) {
    return const InitialState();
  }
}

class LoadedState<T> extends DataState<T> {
  const LoadedState(T super.data);

  @override
  T get data => _data as T;

  @override
  bool get isLoaded => true;

  @override
  DataState<T> updateData(T data) {
    return LoadedState(data);
  }
}

class LoadingState<T> extends DataState<T> {
  const LoadingState({T? data}) : super(data);

  @override
  bool get isLoading => true;

  @override
  DataState<T> updateData(T data) {
    return LoadingState(data: data);
  }
}

class ErrorState<T> extends DataState<T> {
  const ErrorState(this.error, {T? data}) : super(data);

  final Exception error;

  @override
  DataState<T> updateData(T data) {
    return ErrorState(error, data: data);
  }
}

extension DataStateUtils<T> on DataState<T> {
  DataState<T> toLoading() {
    return LoadingState(data: _data);
  }

  DataState<T> toError(Exception error) {
    return ErrorState(error, data: _data);
  }

  DataState<T> toLoaded(T data) {
    return LoadedState(data);
  }
}
