import 'package:flutter/material.dart';
import '../core/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
          leading: const Icon(Icons.description_outlined),
          title: const Text("Description"),
        ),
        body: Container(
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Card(
                  elevation: 25,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("ENSC100 Project Details", style: TextStyle(fontSize: 24, ), textAlign: TextAlign.center,),
                          SizedBox(height: 20,),
                        Text(
                                      txtD,
                                      style: TextStyle(
                      fontSize: fSize,
                                      ),
                                      textAlign: TextAlign.justify,
                                    )
                      ]),
                    ),
                  )),
            )),
      ),
    );
  }
}
