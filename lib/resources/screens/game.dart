import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_231122_gae/resources/actors/dragon.dart';
import 'package:flutter_231122_gae/resources/actors/enemy.dart';
import 'package:flutter_231122_gae/resources/actors/player.dart';
import 'package:flutter_231122_gae/resources/blocs/point/point_bloc.dart';
import 'package:flutter_231122_gae/resources/overlays/shoot.dart';
import 'dart:math';

class JoystickExample extends FlameGame
    with HasDraggables, HasCollisionDetection, HasTappables {
  static const String description = '''
    In this example we showcase how to use the joystick by creating simple
    `CircleComponent`s that serve as the joystick's knob and background.
    Steer the player by using the joystick.
  ''';

  final PointBloc pointBloc;
  JoystickExample({required this.pointBloc});

  late final JoystickPlayer player;
  late final JoystickComponent joystick;
  late final Dragon dragon;
  late Timer timer;
  int point = 0;
  late SpriteComponent background;
  bool win = false;
  ShootButton dialogButton = ShootButton();
  Vector2 lastJoystickRelativeDelta = Vector2(0, -1);
  late Sprite bullet;

  @override
  Future<void> onLoad() async {
    Sprite backgroundSprite = await loadSprite('layers/background.jpg');
    background = SpriteComponent()
      ..sprite = backgroundSprite
      ..size = backgroundSprite.originalSize;
    add(background);

    dialogButton
      ..sprite = await loadSprite('layers/button.png')
      ..positionType = PositionType.viewport
      ..position = Vector2(size.x - 150, size.y - 100)
      ..size = Vector2(75, 50);

    add(dialogButton);

    bullet = await loadSprite('layers/bullet.png');

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

    add(Dragon());

    int counter = 0;
    var rng = Random();

    timer = Timer(
      1,
      repeat: true,
      onTick: () {
        if (counter < 100) {
          add(Enemy(
              rng.nextInt((background.size.x - 25.0).toInt()).toDouble() + 5.0,
              rng.nextInt((background.size.y - 25.0).toInt()).toDouble() +
                  5.0));
          counter++;
        } else {
          timer.stop();
        }
      },
    );

    overlays.add('DashboardOverlay');

    add(FlameBlocProvider.value(value: pointBloc));
  }

  @override
  void update(double dt) async {
    super.update(dt);

    timer.update(dt);
  }
}
