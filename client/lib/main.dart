// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'WebSocket Demo';
    return const MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      home: MyHomePage(
        title: title,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Socket socket;
  int number = 0;

  @override
  void initState() {
    connectToServer();
    super.initState();
  }

  void connectToServer() {
    try {
      socket = io('http://127.0.0.1:3000', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
      });

      // Connect to websocket
      socket.connect();

      socket.on('number', (data) {
        print(data['i']);
        setState(() {
          number = data['i'];
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              socket.emit('number', 'Hello from client');
            },
            child: const Text('Start'),
          ),
          Text(
            number.toString(),
            style: const TextStyle(fontSize: 100),
          ),
        ],
      ),
    ));
  }
}
