import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/profile.dart';

class WIdgetTree extends StatefulWidget {
  const WIdgetTree({super.key});

  @override
  State<WIdgetTree> createState() => _WIdgetTreeState();
}

class _WIdgetTreeState extends State<WIdgetTree> {
  int currentPageIndex = 0;
  List<Widget> pageList = [
    MyHomePage(title: "ENSC 100 Project",),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.home_max_outlined), label: "Home"),
          NavigationDestination(
            icon: Icon(Icons.description), label: "Profile")
        ],
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int value)
        {
          setState(() {
            currentPageIndex = value;
          });
        },
      ),
    );
  }
  

}
