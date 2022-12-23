part of 'players_bloc.dart';

class PlayersState {
  final List? players;
  final bool isLoading;

  PlayersState({this.players, this.isLoading = false});

  PlayersState copyWith({
    required List playersToSave,
    required bool isLoading,
  }) {
    return PlayersState(players: playersToSave, isLoading: isLoading);
  }
}
