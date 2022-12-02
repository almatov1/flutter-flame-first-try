import 'package:flutter/material.dart';
import 'package:flutter_231122_gae/resources/core.dart';
import 'package:flutter_231122_gae/resources/screens/settings.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 50),
          child: Text('2D arcade online game'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const GameCore(actor: 'rocket')));
          },
          child: const Text('Play as Rocket'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const GameCore(actor: 'dragon')));
          },
          child: const Text('Play as Dragon'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const Settings()));
          },
          child: const Text('Settings'),
        ),
      ])),
    );
  }
}
