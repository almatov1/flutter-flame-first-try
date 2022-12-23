import 'package:flutter/material.dart';
import 'package:flutter_231122_gae/resources/blocs/socket/socketvar_bloc.dart';
import 'package:flutter_231122_gae/resources/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  fetchServer() {
    // TEST SOCKET
    var socket = io(
        'http://37.151.200.143:3000?serverToken=r43xv43vi&userName=almat',
        OptionBuilder()
            .setTransports(['websocket'])
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

        BlocProvider.of<SocketVarBloc>(context).add(SocketVarSetEvent(socket));

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const GameCore()));
      } else {
        print('error: $data');
      }
    });

    // socket.on('usersList', (data) {
    //   BlocProvider.of<PlayersBloc>(context).add(PlayersSetEvent(data));
    // });
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
            fetchServer();
          },
          child: const Text('Connect to server'),
        ),
      ])),
    );
  }
}
