import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter_231122_gae/resources/actors/bullet.dart';
import 'package:flutter_231122_gae/resources/screens/game.dart';

class ShootButton extends SpriteComponent
    with HasGameRef<JoystickExample>, Tappable {
  @override
  bool onTapDown(TapDownInfo info) {
    super.onTapDown(info);

    Bullet bullet = Bullet(gameRef.lastJoystickRelativeDelta,
        position: gameRef.player.position,
        size: Vector2(30, 15),
        sprite: gameRef.bullet,
        angle: gameRef.player.angle - 1.59);
    bullet.anchor = Anchor.center;
    gameRef.add(bullet);

    return true;
  }
}
