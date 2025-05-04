extension ObjectUtils<T> on T? {
  R? ifNotNull<R>(R Function(T) map, {R? orElse}) {
    if (this != null) return map.call(this as T);
    return orElse;
  }
}
