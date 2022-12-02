part of 'point_bloc.dart';

abstract class PointEvent {
  const PointEvent();

  List<Object> get props => [];
}

class IncreasePointEvent extends PointEvent {}

class MinusPointEvent extends PointEvent {}
