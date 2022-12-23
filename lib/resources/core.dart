import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_231122_gae/resources/blocs/socket/socketvar_bloc.dart';
import 'package:flutter_231122_gae/resources/screens/game.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameCore extends StatelessWidget {
  const GameCore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: JoystickExample(socketBloc: context.read<SocketVarBloc>()),
    );
  }
}
