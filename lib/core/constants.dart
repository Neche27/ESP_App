import 'dart:ui';

import 'package:web_socket_channel/web_socket_channel.dart';

final channel = WebSocketChannel.connect(
    Uri.parse('ws://esp8266LAN.local/ws'),
  );

const textColor = Color.fromARGB(255, 255, 255, 255);
const backgroundColor = Color.fromARGB(255, 170,34,38);
const primaryColor = Color.fromARGB(255, 255, 130, 28);
const primaryFgColor = Color(0xFF110a14);
const secondaryColor = Color(0xFF662680);
const secondaryFgColor = Color.fromARGB(255, 255, 130, 28);
const accentColor = Color(0xFFad41d7);
const accentFgColor = Color(0xFF110a14);