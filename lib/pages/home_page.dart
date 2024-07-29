import 'dart:convert';
import 'package:esp8266_app/pages/send_page.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../model/client_json.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.channel,
  });

  final String title;
  final WebSocketChannel channel;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  final _channel = WebSocketChannel.connect(
    Uri.parse('ws://esp8266LAN.local/ws'),
  );
  List<String> btnValues = ['A', 'B', 'C', 'D'];
  Color? btnColor = const Color.fromARGB(255, 170, 34, 38);
  List<bool> isPressed = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 213, 207, 233),
                Color.fromARGB(255, 182, 176, 204),
              ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: const Icon(Icons.home_outlined),
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Stack(children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                        elevation: 25,
                        child: Column(children: [
                          Form(
                            child: TextFormField(
                              controller: _controller,
                              decoration: const InputDecoration(
                                  labelText: 'Send a message'),
                            ),
                          ),
                          const SizedBox(height: 24),
                          StreamBuilder(
                            stream: _channel.stream,
                            builder: (context, snapshot) {
                              return Wrap(
                                spacing: 100,
                                children: [
                                  Column(
                                    children: [
                                      const Text("TEMP:"),
                                      _getTemp(snapshot)
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Text("HUM: "),
                                      _getHU(snapshot)
                                    ],
                                  )
                                ],
                              );
                            },
                          ),
                        ])),
                    Card(
                      //shadowColor: Colors.black,
                      // color: Colors.black.withOpacity(0.1),
                      elevation: 20,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          runSpacing: 50,
                          spacing: 50,
                          children: <Widget>[
                            SizedBox(
                                height: 100,
                                width: 100,
                                child: buildButton(Icons.light_outlined, 0)),
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: buildButton(Icons.light_mode_outlined, 1),
                            ),
                            SizedBox(
                                height: 100,
                                width: 100,
                                child: buildButton(
                                    Icons.account_tree_outlined, 2)),
                            SizedBox(
                                height: 100,
                                width: 100,
                                child:
                                    buildButton(Icons.text_fields_outlined, 3)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget buildButton(IconData ic, int id) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: isPressed[id] ? Colors.green[300] : btnColor),
      onPressed: () {
        setState(() {
          if (id == 3) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SendPage()));
            for (int i = 0; (i < isPressed.length); i++) {
              isPressed[i] = false;
            }
          } else {
            isPressed[id] = !isPressed[id];
            if (isPressed[id]) {
              _sendButtonValue(btnValues[id]);
            } else {
              _sendButtonValue('N');
            }

            for (int i = 0; (i < isPressed.length - 1); i++) {
              if (i == id) {
                continue;
              }
              isPressed[i] = false;
            }
          }
        });
      },
      child: Icon(ic),
    );
  }

  Text _getTemp(AsyncSnapshot snapShot) {
    if (snapShot.hasData) {
      final espData =
          jsonDecode(snapShot.data.toString()) as Map<String, dynamic>;
      final espInfo = Client_JSON.fromJson(espData);
      return Text("${espInfo.temp} °C");
    } else {
      return const Text('');
    }
  }

  Text _getHU(AsyncSnapshot snapShot) {
    if (snapShot.hasData) {
      final espData =
          jsonDecode(snapShot.data.toString()) as Map<String, dynamic>;
      final espInfo = Client_JSON.fromJson(espData);
      return Text("${espInfo.hum} %");
    } else {
      return const Text('');
    }
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      if (_controller.text == 'R') {
        _controller.text = 'N';
      } else if (_controller.text == 'N') {
        _controller.text = 'R';
      }
      _channel.sink.add(_controller.text);
    }
  }

  void _sendButtonValue(String txt) {
    _channel.sink.add(txt);
  }

  @override
  void dispose() {
    _channel.sink.close();
    _controller.dispose();
    super.dispose();
  }
}
