import 'dart:ui';

extension ColorUtils on Color {
  Color lerp(Color? other, double t) {
    return Color.lerp(this, other, t) ?? this;
  }
}
