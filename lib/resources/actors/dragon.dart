import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_231122_gae/resources/actors/bullet.dart';
import 'package:flutter_231122_gae/resources/screens/game.dart';

class DragonSprite extends SpriteComponent
    with HasGameRef<JoystickExample>, CollisionCallbacks {
  @override
  Future<void> onLoad() async {
    sprite = gameRef.actor == 'rocket'
        ? await gameRef.loadSprite('layers/dragon.png')
        : await gameRef.loadSprite('layers/player.png');
    size = Vector2(50, 50);
    position = Vector2(150, 150);
    angle = 0;
    anchor = Anchor.center;
    debugMode = true;

    add(RectangleHitbox());
  }

  @override
  void update(double dt) async {
    super.update(dt);

    // if (gameRef.dragonBloc.state.dragons.isNotEmpty) {
    //   position = gameRef.actor == 'rocket'
    //       ? Vector2(gameRef.dragonBloc.state.dragons.first.dragonX,
    //           gameRef.dragonBloc.state.dragons.first.dragonY)
    //       : Vector2(gameRef.dragonBloc.state.dragons.first.playerX,
    //           gameRef.dragonBloc.state.dragons.first.playerY);
    // }

    if (gameRef.dragonBloc.state.dragons.isNotEmpty) {
      final double lastX = position.x;
      final double lastY = position.y;
      final double lastAngle = angle;

      angle += gameRef.actor == 'rocket'
          ? (gameRef.dragonBloc.state.dragons.first.dragonAngle - lastAngle) *
              0.3
          : (gameRef.dragonBloc.state.dragons.first.playerAngle - lastAngle) *
              0.3;

      position.add(gameRef.actor == 'rocket'
          ? Vector2(gameRef.dragonBloc.state.dragons.first.dragonX - lastX,
                  gameRef.dragonBloc.state.dragons.first.dragonY - lastY) *
              0.1
          : Vector2(gameRef.dragonBloc.state.dragons.first.playerX - lastX,
                  gameRef.dragonBloc.state.dragons.first.playerY - lastY) *
              0.1);
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Bullet) {
      removeFromParent();
    }
  }
}
