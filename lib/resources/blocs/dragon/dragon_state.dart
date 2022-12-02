part of 'dragon_bloc.dart';

class DragonState {
  final List<Dragon> dragons;
  final bool isLoading;

  DragonState({
    this.dragons = const [],
    this.isLoading = false,
  });

  DragonState copyWith({
    List<Dragon>? dragons,
    bool isLoading = false,
  }) {
    return DragonState(
      dragons: dragons ?? this.dragons,
      isLoading: isLoading,
    );
  }
}

class Dragon {
  final double dragonX;
  final double dragonY;
  final double dragonAngle;

  final double playerX;
  final double playerY;
  final double playerAngle;

  Dragon(
      {required this.dragonX,
      required this.dragonY,
      required this.dragonAngle,
      required this.playerX,
      required this.playerY,
      required this.playerAngle});
}
