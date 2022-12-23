part of 'socketvar_bloc.dart';

class SocketVarState {
  final Socket? socket;
  final bool isLoading;

  SocketVarState({this.socket, this.isLoading = false});

  SocketVarState copyWith({
    Socket? socketToSave,
    required bool isLoading,
  }) {
    return SocketVarState(socket: socketToSave ?? socket, isLoading: isLoading);
  }
}
