import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_231122_gae/resources/actors/player.dart';
import 'package:flutter_231122_gae/resources/blocs/socket/socketvar_bloc.dart';

class JoystickExample extends FlameGame
    with HasDraggables, HasCollisionDetection, HasTappables {
  final SocketVarBloc socketBloc;

  JoystickExample({required this.socketBloc});

  late final JoystickPlayer player;
  late final JoystickComponent joystick;
  late SpriteComponent background;

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
    player = JoystickPlayer(joystick, background.size.x, background.size.y);

    add(player);
    add(joystick);

    camera.followComponent(player,
        worldBounds: Rect.fromLTRB(0, 0, background.size.x, background.size.y));

    socketBloc.state.socket!.emit('commandFromClient', 'Hello server!');
  }
}
