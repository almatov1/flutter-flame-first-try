part of 'bullets_bloc.dart';

class BulletsState {
  final List<Bullets> bullets;
  final bool isLoading;

  BulletsState({
    this.bullets = const [],
    this.isLoading = false,
  });

  BulletsState copyWith({
    List<Bullets>? bullets,
    bool isLoading = false,
  }) {
    return BulletsState(
      bullets: bullets ?? this.bullets,
      isLoading: isLoading,
    );
  }
}

class Bullets {
  final double bulletsX;
  

  Bullets(
      {required this.bulletsX});
}
