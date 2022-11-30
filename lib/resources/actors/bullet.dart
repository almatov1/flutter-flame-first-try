import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_231122_gae/resources/screens/game.dart';

class Bullet extends SpriteComponent with HasGameRef<JoystickExample> {
  final double _speed = 20;
  Vector2 direct;
  Bullet(this.direct,
      {Vector2? position, Sprite? sprite, Vector2? size, double? angle})
      : super(position: position, sprite: sprite, size: size, angle: angle);

  @override
  void onMount() async {
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
    position += direct * _speed;

    if (position.x <= 0 ||
        position.y <= 0 ||
        position.x >= gameRef.background.size.x ||
        position.y >= gameRef.background.size.y) {
      removeFromParent();
    }
  }
}
