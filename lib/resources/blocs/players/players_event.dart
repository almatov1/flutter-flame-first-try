part of 'players_bloc.dart';

abstract class PlayersEvent {}

class PlayersSetEvent extends PlayersEvent {
  List players;

  PlayersSetEvent(this.players);
}
