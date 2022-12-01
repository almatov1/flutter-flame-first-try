import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_231122_gae/resources/screens/game.dart';

class Dragon extends SpriteComponent with HasGameRef<JoystickExample> {
  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('layers/dragon.png');
    size = Vector2(50, 50);
    position = Vector2(0, 0);
    add(RectangleHitbox());

    debugMode = true;
  }

  @override
  void update(double dt) async {
    super.update(dt);
    print('sad');
  }
}
