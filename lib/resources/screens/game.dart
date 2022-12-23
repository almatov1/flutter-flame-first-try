import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_231122_gae/resources/actors/enemies.dart';
import 'package:flutter_231122_gae/resources/actors/player.dart';
import 'package:flutter_231122_gae/resources/blocs/players/players_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';

class Online2DGame extends FlameGame
    with HasDraggables, HasCollisionDetection, HasTappables {
  final Socket socket;
  final PlayersBloc playersBloc;
  Online2DGame({required this.socket, required this.playersBloc});

  late final MainPlayer player;
  late final JoystickComponent joystick;
  late SpriteComponent background;
  List playersInGame = [];

  @override
  Future<void> onLoad() async {
    Sprite backgroundSprite = await loadSprite('layers/background.jpg');
    background = SpriteComponent()
      ..sprite = backgroundSprite
      ..size = backgroundSprite.originalSize;
    add(background);

    final knobPaint = BasicPalette.red.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.purple.withAlpha(100).paint();
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 15, paint: knobPaint),
      background: CircleComponent(radius: 50, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );
    player = MainPlayer(joystick, background.size.x, background.size.y);

    add(player);
    add(joystick);

    camera.followComponent(player,
        worldBounds: Rect.fromLTRB(0, 0, background.size.x, background.size.y));
  }

  @override
  void update(double dt) async {
    super.update(dt);
    playersBloc.state.players?.forEach((element) {
      if (!playersInGame.contains(element['id'])) {
        playersInGame.add(element['id']);
        add(Enemy(id: element['id']));
      }
    });
  }
}

