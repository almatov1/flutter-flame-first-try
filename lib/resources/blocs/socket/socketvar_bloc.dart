import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';
part 'socketvar_event.dart';
part 'socketvar_state.dart';

class SocketVarBloc extends Bloc<SocketVarEvent, SocketVarState> {
  SocketVarBloc() : super(SocketVarState()) {
    on<SocketVarSetEvent>(_onGetSocketVar);
  }

  _onGetSocketVar(SocketVarSetEvent event, Emitter<SocketVarState> emit) async {
    emit(state.copyWith(socketToSave: event.socket, isLoading: true));
  }
}
