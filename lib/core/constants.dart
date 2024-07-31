import 'dart:ui';



//values
List<String> btnValues = ['A', 'B', 'C', 'D'];
List<bool> isPressed = [false, false, false, false];
//colors
const pageBackgroundColor1 = Color.fromARGB(255, 213, 207, 233);
const pageBackgroundColor2 = Color.fromARGB(255, 182, 176, 204);
Color? btnColor = const Color.fromARGB(255, 170, 34, 38);
const textColor = Color.fromARGB(255, 255, 255, 255);
const backgroundColor = Color.fromARGB(255, 170,34,38);
const primaryColor = Color.fromARGB(255, 255, 130, 28);
const primaryFgColor = Color(0xFF110a14);
const secondaryColor = Color(0xFF662680);
const secondaryFgColor = Color.fromARGB(255, 255, 130, 28);
const accentColor = Color(0xFFad41d7);
const accentFgColor = Color(0xFF110a14);
//Text
const String txtD = """
  This is our ENSC100 Project, in which we create an iot app to access and control Led lights.
  It also works well with the voice activated lights project.
  You can control the led lights through through the various buttons in our app.
  The first, second and third buttons control the various light animations and
  the last button can be used to control the solid colors.
""";
const double fSize = 18;