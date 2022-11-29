import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_231122_gae/resources/actors/bullet.dart';
import 'dart:math';
import 'package:flutter_231122_gae/resources/game.dart';

class ShootButton extends SpriteComponent
    with HasGameRef<JoystickExample>, Tappable {
  @override
  bool onTapDown(TapDownInfo info) {
    super.onTapDown(info);

    var rng = Random();
    PaletteEntry red = BasicPalette.red;
    PaletteEntry green = BasicPalette.green;
    PaletteEntry blue = BasicPalette.blue;
    PaletteEntry yellow = BasicPalette.yellow;
    PaletteEntry pink = BasicPalette.pink;
    PaletteEntry black = BasicPalette.black;
    PaletteEntry white = BasicPalette.white;
    PaletteEntry purple = BasicPalette.purple;
    PaletteEntry orange = BasicPalette.orange;
    List colors = [
      red,
      green,
      blue,
      yellow,
      pink,
      black,
      purple,
      orange,
      white
    ];

    final paint = colors[rng.nextInt(9)].paint()..style = PaintingStyle.fill;
    Bullet bullet = Bullet(
      gameRef.lastJoystickRelativeDelta,
      position: gameRef.player.position,
      radius: 10.0,
      paint: paint,
    );
    bullet.anchor = Anchor.center;
    gameRef.add(bullet);

    return true;
  }
}
