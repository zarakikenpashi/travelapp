import 'package:flutter/material.dart';
import 'screens/ajouterlieux.dart';
import 'screens/customizelieux.dart';
import 'screens/listelieux.dart';
import 'screens/myDrawer.dart';

class AccueilPage extends StatefulWidget {
  const AccueilPage({super.key});

  @override
  State<AccueilPage> createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Saved"),
        centerTitle: true,
        actions: const [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.notifications_none,
                size: 35,
                color: Colors.grey,
              ),
              Icon(
                Icons.search_rounded,
                size: 35,
                color: Colors.grey,
              ),
            ],
          )
        ],
      ),
      body: const [
        ListeLieuxPage(),
        AjouterLieuPage(),
        CustomizeLieuPage()
      ][_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.pink,
          unselectedItemColor: Colors.grey,
          iconSize: 40,
          currentIndex: _selectedIndex,
          onTap: (value) => setState(() {
                _selectedIndex = value;
              }),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.public_outlined), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.control_point_outlined), label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.menu_outlined,
                ),
                label: ""),
          ]),
    );
  }
}
