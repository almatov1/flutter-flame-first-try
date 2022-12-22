import 'package:flutter/material.dart';
import 'package:flutter_231122_gae/resources/core.dart';
import 'package:socket_io_client/socket_io_client.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  void initState() {
    super.initState();

    // TEST SOCKET
    var socket = io(
        'http://localhost:3000?serverToken=r43xv43vi&userName=aza',
        OptionBuilder()
            .enableForceNewConnection()
            .disableAutoConnect()
            .build());

    socket.connect();

    socket.onConnectError((data) {
      print('fatal error $data');
      socket.disconnect();
    });

    socket.on('connectResult', (data) {
      if (data == true) {
        print('succes connected');
      } else {
        print('error: $data');
      }
    });
  }

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
                MaterialPageRoute(builder: (context) => const GameCore()));
          },
          child: const Text('Play'),
        ),
      ])),
    );
  }
}
