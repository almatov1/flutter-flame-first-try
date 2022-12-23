import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_231122_gae/resources/screens/game.dart';

class Enemy extends SpriteComponent
    with HasGameRef<Online2DGame>, CollisionCallbacks {
  String id;
  Enemy({required this.id});

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('layers/player.png');
    size = Vector2(50, 50);
    position = Vector2(0, 0);
    angle = 0;
    anchor = Anchor.center;
    debugMode = true;

    gameRef.socket.on('userDisconnected', (data) {
      if (data == id) {
        print('deleted po idee - $id');
        gameRef.playersInGame.remove(id);
        removeFromParent();
      }
    });
  }

  @override
  void update(double dt) async {
    super.update(dt);
    gameRef.playersBloc.state.players?.forEach((element) {
      if (element['id'] == id) {
        position.x = double.parse(element['x'].toString());
        position.y = double.parse(element['y'].toString());
      }
    });
  }
}
