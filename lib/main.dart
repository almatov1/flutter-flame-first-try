import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_231122_gae/resources/screens/menu.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();

  runApp(const FlameApp());
}

class FlameApp extends StatelessWidget {
  const FlameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark(),
        home: const Menu());
  }
}
