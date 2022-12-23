import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_231122_gae/resources/blocs/players/players_bloc.dart';
import 'package:flutter_231122_gae/resources/blocs/socket/socketvar_bloc.dart';
import 'package:flutter_231122_gae/resources/screens/menu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<SocketVarBloc>(
          create: (context) => SocketVarBloc(),
        ),
        BlocProvider<PlayersBloc>(
          create: (context) => PlayersBloc(),
        ),
      ],
      child: MaterialApp(
          themeMode: ThemeMode.dark,
          darkTheme: ThemeData.dark(),
          home: const Menu()),
    );
  }
}
