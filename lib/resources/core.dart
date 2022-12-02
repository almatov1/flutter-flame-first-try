import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_231122_gae/resources/blocs/dragon/dragon_bloc.dart';
import 'package:flutter_231122_gae/resources/blocs/point/point_bloc.dart';
import 'package:flutter_231122_gae/resources/overlays/dashboard.dart';
import 'package:flutter_231122_gae/resources/screens/game.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameCore extends StatelessWidget {
  final String actor;
  const GameCore({Key? key, required this.actor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: JoystickExample(
          pointBloc: context.read<PointBloc>(),
          dragonBloc: context.read<DragonBloc>(),
          actor: actor),
      overlayBuilderMap: {
        "DashboardOverlay": (BuildContext context, JoystickExample game) =>
            const Dashboard()
      },
    );
  }
}
