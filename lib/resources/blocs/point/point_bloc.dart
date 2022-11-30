import 'package:flutter_bloc/flutter_bloc.dart';
part 'point_event.dart';
part 'point_state.dart';

class PointBloc extends Bloc<PointEvent, PointState> {
  PointBloc() : super(PointState.initial()) {
    on<IncreasePointEvent>((event, emit) {
      emit(state.copyWith(point: state.point + 1));
    });
  }
}
