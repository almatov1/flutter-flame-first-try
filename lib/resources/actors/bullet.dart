import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_231122_gae/resources/game.dart';

class Bullet extends CircleComponent with HasGameRef<JoystickExample> {
  final double _speed = 450;
  Vector2 direct;
  Bullet(this.direct, {Vector2? position, double? radius, Paint? paint})
      : super(position: position, radius: radius, paint: paint);

  @override
  void onMount() {
    super.onMount();

    final shape = CircleHitbox.relative(
      0.4,
      parentSize: size,
      position: size / 2,
      anchor: Anchor.center,
    );
    add(shape);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += direct * _speed * dt;

    if (position.x <= 0 ||
        position.y <= 0 ||
        position.x >= gameRef.background.size.x ||
        position.y >= gameRef.background.size.y) {
      removeFromParent();
    }
  }
}
