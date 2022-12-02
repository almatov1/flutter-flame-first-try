import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter_231122_gae/resources/actors/dragon.dart';
import 'package:flutter_231122_gae/resources/actors/player.dart';
import 'package:flutter_231122_gae/resources/blocs/point/point_bloc.dart';
import 'package:flutter_231122_gae/resources/screens/game.dart';

class Enemy extends SpriteComponent
    with HasGameRef<JoystickExample>, CollisionCallbacks {
  final double enemyX;
  final double enemyY;
  Enemy(this.enemyX, this.enemyY);

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('layers/bullet.png');
    size = Vector2(50, 25);
    angle = -1.55;
    position = Vector2(enemyX, enemyY);
    add(RectangleHitbox());

    debugMode = true;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is JoystickPlayer) {
      FlameAudio.play('pickup.wav');
      gameRef.pointBloc.add(IncreasePointEvent());
      removeFromParent();
    }
    if (other is DragonSprite) {
      removeFromParent();
    }
  }
}
