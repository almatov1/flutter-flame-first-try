import 'package:flutter/material.dart';
import 'package:flutter_231122_gae/resources/blocs/point/point_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BlocBuilder<PointBloc, PointState>(
                    builder: (context, state) {
                      return Text(
                        'Points: ${state.point} / 100',
                        style: const TextStyle(
                            fontSize: 24,
                            fontFamily: 'Arcade',
                            color: Colors.white),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// class Dashboard extends StatelessWidget {
//   Dashboard({Key? key}) : super(key: key);

//   DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('point');

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Padding(
//             padding: const EdgeInsets.only(top: 15),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: BlocBuilder<PointBloc, PointState>(
//                     builder: (context, state) {
//                       return StreamBuilder(
//                         stream: dbRef.onValue,
//                         builder: (context, snap) {
//                           Object? point = 0;

//                           if (snap.hasData &&
//                               !snap.hasError &&
//                               snap.data?.snapshot.value != null) {
//                             point = snap.data?.snapshot.value;
//                           } else {
//                             point = 0;
//                           }

//                           return Text(
//                             'Points: $point / 100',
//                             style: const TextStyle(
//                                 fontSize: 24,
//                                 fontFamily: 'Arcade',
//                                 color: Colors.white),
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }