import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();

  final _channel = WebSocketChannel.connect(
    Uri.parse('wss://echo.websocket.events'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Socket"),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: controller,
          ),
          StreamBuilder(
              stream: _channel.stream,
              initialData: "No Data",
              builder: (context, snapshot) {
                return Text("${snapshot.data}");
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.ac_unit),
        onPressed: () {
          _channel.sink.add(controller.text);
        },
      ),
    );
  }
}
