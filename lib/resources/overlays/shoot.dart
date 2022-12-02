import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter_231122_gae/resources/actors/bullet.dart';
import 'package:flutter_231122_gae/resources/blocs/point/point_bloc.dart';
import 'package:flutter_231122_gae/resources/screens/game.dart';

class ShootButton extends SpriteComponent
    with HasGameRef<JoystickExample>, Tappable {
  @override
  bool onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    if (gameRef.pointBloc.state.point > 0) {
      Map<String, dynamic> childrenPathValueMap = {};
      childrenPathValueMap["x"] = gameRef.player.position.x;
      childrenPathValueMap["y"] = gameRef.player.position.y;
      childrenPathValueMap["angle"] = gameRef.player.angle - 1.59;
      childrenPathValueMap["directX"] = gameRef.lastJoystickRelativeDelta.x;
      childrenPathValueMap["directY"] = gameRef.lastJoystickRelativeDelta.y;

      var res = gameRef.dragonBloc.dbRef.child('bullets').push();
      res.update(childrenPathValueMap);

      Bullet bullet = Bullet(
        gameRef.lastJoystickRelativeDelta,
        res.key!,
        position: gameRef.player.position,
        size: Vector2(30, 15),
        sprite: gameRef.bullet,
        angle: gameRef.player.angle - 1.59,
      );
      gameRef.bulletsOnScene.add(res.key);
      gameRef.add(bullet);

      gameRef.pointBloc.add(MinusPointEvent());
    }

    return true;
  }
}
