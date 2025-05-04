import 'package:event_bus/event_bus.dart';
import 'package:riverpod/riverpod.dart';

sealed class AppProviders {
  static final eventBus = Provider((ref) => EventBus());
}
