import 'package:firebase_core/firebase_core.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_231122_gae/resources/blocs/point/point_bloc.dart';
import 'package:flutter_231122_gae/resources/screens/menu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Flame.device.fullScreen();
  Flame.device.setLandscape();

  runApp(const FlameApp());
}

class FlameApp extends StatelessWidget {
  const FlameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PointBloc>(
          create: (context) => PointBloc(),
        ),
      ],
      child: MaterialApp(
          themeMode: ThemeMode.dark,
          darkTheme: ThemeData.dark(),
          home: const Menu()),
    );
  }
}
