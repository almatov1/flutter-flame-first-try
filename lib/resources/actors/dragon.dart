import 'package:flame/components.dart';
import 'package:flutter_231122_gae/resources/screens/game.dart';

class DragonSprite extends SpriteComponent with HasGameRef<JoystickExample> {
  @override
  Future<void> onLoad() async {
    sprite = gameRef.actor == 'rocket'
        ? await gameRef.loadSprite('layers/dragon.png')
        : await gameRef.loadSprite('layers/plane.png');
    size = Vector2(50, 50);
    position = Vector2(0, 0);
    angle = 0;
    debugMode = true;
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
              0.1
          : (gameRef.dragonBloc.state.dragons.first.playerAngle - lastAngle) *
              0.1;

      position.add(gameRef.actor == 'rocket'
          ? Vector2(gameRef.dragonBloc.state.dragons.first.dragonX - lastX,
                  gameRef.dragonBloc.state.dragons.first.dragonY - lastY) *
              0.1
          : Vector2(gameRef.dragonBloc.state.dragons.first.playerX - lastX,
                  gameRef.dragonBloc.state.dragons.first.playerY - lastY) *
              0.1);
    }

    // Map<String, dynamic> childrenPathValueMap = {};

    // childrenPathValueMap["x"] = map['x'] + rng.nextInt(5) - 1;
    // childrenPathValueMap["y"] = map['y'] + rng.nextInt(5) - 1;
    // dbRef.update(childrenPathValueMap);
  }
}
