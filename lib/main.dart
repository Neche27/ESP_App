import 'package:esp8266_app/controller/file_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants.dart';
import  'widget_tree.dart';

void main() => runApp(
  MultiProvider(providers: [ChangeNotifierProvider(create: (_) => FileController())],
  child:const MyApp()),
  );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'ENSC100 Project';
    return MaterialApp(
      title: title,
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Colors.black.withOpacity(0.09)),
        colorScheme: ColorScheme(
  brightness: Brightness.light,
  background: backgroundColor,
  onBackground: textColor,
  primary: primaryColor,
  onPrimary: primaryFgColor,
  secondary: secondaryColor,
  onSecondary: secondaryFgColor,
  tertiary: accentColor,
  onTertiary: accentFgColor,
  surface: backgroundColor,
  onSurface: textColor,
  error: Brightness.light == Brightness.light ? Color(0xffB3261E) : Color(0xffF2B8B5),
  onError: Brightness.light == Brightness.light ? Color(0xffFFFFFF) : Color(0xff601410),),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)))),
        ),
      ),
      home: const WIdgetTree()
    );
  }
}


