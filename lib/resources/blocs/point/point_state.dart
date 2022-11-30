part of 'point_bloc.dart';

class PointState {
  final int point;

  const PointState({
    required this.point,
  });

  factory PointState.initial() => const PointState(point: 0);
  List<Object> get props => [point];

  PointState copyWith({
    int? point,
  }) {
    return PointState(
      point: point ?? this.point,
    );
  }

  @override
  String toString() => 'PointState(point: $point)';

  @override
  bool operator ==(covariant PointState other) {
    if (identical(this, other)) return true;

    return other.point == point;
  }

  @override
  int get hashCode => point.hashCode;
}
