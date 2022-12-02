part of 'dragon_bloc.dart';

abstract class DragonEvent {}

class DragonGetDragonsEvent extends DragonEvent {
  final int count;

  DragonGetDragonsEvent(this.count);
}