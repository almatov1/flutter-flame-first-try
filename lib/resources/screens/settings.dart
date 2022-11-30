import 'package:flutter/material.dart';
import 'package:flutter_231122_gae/resources/screens/menu.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 50),
          child: Text('Settings'),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Volume offed'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const Menu()));
          },
          child: const Text('Go back'),
        ),
      ])),
    );
  }
}
