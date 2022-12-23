import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_231122_gae/resources/blocs/players/players_bloc.dart';
import 'package:flutter_231122_gae/resources/blocs/socket/socketvar_bloc.dart';
import 'package:flutter_231122_gae/resources/screens/game.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameCore extends StatefulWidget {
  const GameCore({Key? key}) : super(key: key);

  @override
  State<GameCore> createState() => _GameCoreState();
}

class _GameCoreState extends State<GameCore> {
  late PlayersBloc _playersBloc;
  late SocketVarBloc _socketVarBloc;

  @override
  void initState() {
    _playersBloc = BlocProvider.of<PlayersBloc>(context);
    _socketVarBloc = BlocProvider.of<SocketVarBloc>(context);

    _socketVarBloc.state.socket!.on('usersList', (data) {
      _playersBloc.add(PlayersSetEvent(data));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: Online2DGame(
          socket: _socketVarBloc.state.socket!, playersBloc: _playersBloc),
    );
  }

  @override
  void dispose() {
    _playersBloc.close();
    _socketVarBloc.close();
    super.dispose();
  }
}
