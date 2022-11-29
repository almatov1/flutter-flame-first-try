import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_231122_gae/resources/game.dart';
import 'package:flutter_231122_gae/resources/overlays/dashboard.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();

  runApp(
    GameWidget(
      game: JoystickExample(),
      overlayBuilderMap: {
        "DashboardOverlay": (BuildContext context, JoystickExample game) =>
            Dashboard(game: game)
      },
    ),
  );
}
