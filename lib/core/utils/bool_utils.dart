extension BoolUtils on bool {
  T? ifTrue<T>(T object, {T? orElse}) {
    if (this) return object;
    return orElse;
  }

  T? ifFalse<T>(T object, {T? orElse}) {
    if (!this) return object;
    return orElse;
  }
}
