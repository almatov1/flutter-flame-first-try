import 'package:flutter/material.dart';
import 'package:flutter_231122_gae/resources/screens/game.dart';

class Dashboard extends StatelessWidget {
  final JoystickExample game;
  const Dashboard({Key? key, required this.game}) : super(key: key);

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
                  child: Text(
                    'Points: ${game.point} / 100',
                    style: const TextStyle(
                        fontSize: 24,
                        fontFamily: 'Arcade',
                        color: Colors.white),
                  ),
                ),
                if (game.win)
                  const Text(
                    'Win',
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Arcade',
                        color: Colors.white),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
