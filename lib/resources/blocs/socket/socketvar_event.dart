part of 'socketvar_bloc.dart';

abstract class SocketVarEvent {}

class SocketVarSetEvent extends SocketVarEvent {
  Socket socket;

  SocketVarSetEvent(this.socket);
}
