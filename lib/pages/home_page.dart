import 'dart:convert';
import 'dart:ui';
import 'package:esp8266_app/controller/file_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../model/client_json.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  final _channel = WebSocketChannel.connect(
    Uri.parse('ws://esp8266LAN.local/ws'),
  );
  String btnValue1 = 'O';
  String btnValue2 = 'R';
  Color? btnColor = const Color.fromARGB(255, 170, 34, 38);
  bool isPressed1 = false;
  bool isPressed2 = false;
  bool isPressed3 = false;
  bool isPressed4 = false;

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
            // Positioned(
            //   child: Container(
            //     width: 300,
            //     height: 300,
            //     decoration: const BoxDecoration(
            //         shape: BoxShape.rectangle,
            //         gradient: LinearGradient(colors: [
            //           Color.fromARGB(255, 174, 157, 235),
            //           Color.fromARGB(255, 153, 133, 226),
            //         ])),
            //   ),
            // ),
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
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: isPressed1
                                        ? Colors.green[300]
                                        : btnColor),
                                onPressed: () {
                                  _sendButtonValue(btnValue2);
                                  if (btnValue2 == 'R') {
                                    btnValue2 = 'N';
                                  } else if (btnValue2 == 'N') {
                                    btnValue2 = 'R';
                                  }
                                  context.read<FileController>().writeText();
                                  setState(() {
                                    isPressed1 = !isPressed1;
                                  });
                                },
                                child: const Icon(Icons.light_outlined),
                              ),
                            ),
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: isPressed2
                                        ? Colors.green[300]
                                        : btnColor),
                                onPressed: () {
                                  _sendButtonValue(btnValue2);
                                  if (btnValue2 == 'R') {
                                    btnValue2 = 'N';
                                  } else if (btnValue2 == 'N') {
                                    btnValue2 = 'R';
                                  }
                                  context.read<FileController>().writeClient();
                                  setState(() {
                                    isPressed2 = !isPressed2;
                                  });
                                },
                                child: const Icon(Icons.light_mode_outlined),
                              ),
                            ),
                            SizedBox(
                                height: 100,
                                width: 100,
                                child:
                                    buildButton(Icons.account_tree_outlined)),
                            SizedBox(
                                height: 100,
                                width: 100,
                                child: buildButton(Icons.text_fields_outlined)),
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

  Container buildButton(IconData ic) {
    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: isPressed3 ? Colors.green[300] : btnColor),
        onPressed: () {
          _sendButtonValue(btnValue2);
          if (btnValue2 == 'R') {
            btnValue2 = 'N';
          } else if (btnValue2 == 'N') {
            btnValue2 = 'R';
          }
          setState(() {
            isPressed3 = !isPressed3;
          });
        },
        child: Icon(ic),
      ),
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
