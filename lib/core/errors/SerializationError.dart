class SerializationError implements Exception {
  final Type serializableType;
  final dynamic data;

  const SerializationError({required this.serializableType, this.data});
}
