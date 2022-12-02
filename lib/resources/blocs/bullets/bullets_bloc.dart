import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'bullets_event.dart';
part 'bullets_state.dart';

class BulletsBloc extends Bloc<BulletsEvent, BulletsState> {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref();
  Map map = {
    'player': {'x': 0, 'y': 0, 'point': 0},
    'enemy': {'x': 0, 'y': 0, 'point': 0}
  };

  BulletsBloc() : super(BulletsState()) {
    on<BulletsGetBulletssEvent>(_onGetBullets);
  }

  _onGetBullets(
      BulletsGetBulletssEvent event, Emitter<BulletsState> emit) async {
    List<Bullets> bullets = [];

    var loadFirebaseInfo = dbRef.once().then((DatabaseEvent databaseEvent) {
      var res = databaseEvent.snapshot.value;
      if (res != null) {
        map = res as Map;

        // bullets = List.generate(
        //   event.count,
        //   (index) => Bullets(
        //     BulletsX: double.parse(map['enemy']['x'].toString()),
        //   ),
        // );
      }
    });

    await loadFirebaseInfo.whenComplete(() {
      emit(state.copyWith(isLoading: true));
      emit(state.copyWith(bullets: bullets));
    });
  }
}
