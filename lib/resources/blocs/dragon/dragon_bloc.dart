import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'dragon_event.dart';
part 'dragon_state.dart';

class DragonBloc extends Bloc<DragonEvent, DragonState> {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref();
  Map map = {
    'player': {'x': 0, 'y': 0, 'point': 0},
    'enemy': {'x': 0, 'y': 0, 'point': 0}
  };

  DragonBloc() : super(DragonState()) {
    on<DragonGetDragonsEvent>(_onGetDragon);
  }

  _onGetDragon(DragonGetDragonsEvent event, Emitter<DragonState> emit) async {
    List<Dragon> dragons = [];

    var loadFirebaseInfo = dbRef.once().then((DatabaseEvent databaseEvent) {
      var res = databaseEvent.snapshot.value;
      if (res != null) {
        map = res as Map;

        dragons = List.generate(
          event.count,
          (index) => Dragon(
            dragonX: double.parse(map['enemy']['x'].toString()),
            dragonY: double.parse(map['enemy']['y'].toString()),
            dragonAngle: double.parse(map['enemy']['angle'].toString()),
            playerX: double.parse(map['player']['x'].toString()),
            playerY: double.parse(map['player']['y'].toString()),
            playerAngle: double.parse(map['player']['angle'].toString()),
          ),
        );
      }
    });

    await loadFirebaseInfo.whenComplete(() {
      emit(state.copyWith(isLoading: true));
      emit(state.copyWith(dragons: dragons));
    });
  }
}
