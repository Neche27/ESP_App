import 'package:esp8266_app/controller/file_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../core/constants.dart';

class SendPage extends StatefulWidget {
  const SendPage({super.key});

  @override
  State<SendPage> createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  final TextEditingController _controller = TextEditingController();
  final channel = WebSocketChannel.connect(
    Uri.parse('ws://esp8266LAN.local/ws'),
  );
  String text = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                pageBackgroundColor1,
                pageBackgroundColor2,
              ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Send Colors"),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(25, 25, 25, 100),
          child: Column(
            children: [
              Card(
                  elevation: 25,
                  child: Column(children: [
                    const SizedBox(height: 24),
                    Form(
                      child: TextFormField(
                        controller: _controller,
                        decoration: const InputDecoration(
                            labelText: 'Enter your color'),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ])),
              Card(
                  child: Column(
                    children: [
                      const SizedBox(height: 50, width: 500,),
                      SingleChildScrollView(
                                      child: Text(context
                        .select((FileController controller) => controller.text)),
                                    ),
                    ],
                  )),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _sendMessage();
            setState(() {
              text += _controller.text;
              text += "\n";
              context.read<FileController>().writeText(text);
            });
          },
          tooltip: 'Send message',
          child: const Icon(Icons.send),
        ),
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      channel.sink.add(_controller.text);
    }
  }
 @override
  void dispose() {
    channel.sink.close();
    _controller.dispose();
    super.dispose();
  }
}
