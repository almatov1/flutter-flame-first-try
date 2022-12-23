import 'package:flutter_bloc/flutter_bloc.dart';
part 'players_event.dart';
part 'players_state.dart';

class PlayersBloc extends Bloc<PlayersEvent, PlayersState> {
  PlayersBloc() : super(PlayersState()) {
    on<PlayersSetEvent>(_onGetPlayers);
  }

  _onGetPlayers(PlayersSetEvent event, Emitter<PlayersState> emit) async {
    emit(state.copyWith(playersToSave: event.players, isLoading: true));
  }
}
