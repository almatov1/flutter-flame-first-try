part of 'bullets_bloc.dart';

abstract class BulletsEvent {}

class BulletsGetBulletssEvent extends BulletsEvent {
  final int count;

  BulletsGetBulletssEvent(this.count);
}