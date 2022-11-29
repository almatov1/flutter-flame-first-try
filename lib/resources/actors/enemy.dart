import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter_231122_gae/resources/actors/bullet.dart';
import 'package:flutter_231122_gae/resources/actors/player.dart';
import 'package:flutter_231122_gae/resources/game.dart';

class Enemy extends SpriteComponent
    with HasGameRef<JoystickExample>, CollisionCallbacks {
  final double enemyX;
  final double enemyY;
  Enemy(this.enemyX, this.enemyY);

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('layers/smoke.gif');
    size = Vector2(50, 50);
    position = Vector2(enemyX, enemyY);
    add(RectangleHitbox());

    debugMode = true;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is JoystickPlayer || other is Bullet) {
      FlameAudio.play('pickup.wav');
      gameRef.point++;
      gameRef.activePoints--;
      // ignore: invalid_use_of_internal_member
      gameRef.refreshWidget();
      removeFromParent();

      if (gameRef.point == 100) gameRef.win = true;
    }
  }
}
