import 'package:flutter/material.dart';
import 'package:package_flutter/pages/home_page.dart';
import 'package:package_flutter/pages/map.dart';
import 'package:package_flutter/partials/navigation_bar.dart';
import 'package:package_flutter/partials/drawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    MyMap(),
    Center(child: Text("Add")),
    Center(child: Text("Message")),
    Center(child: Text("Profile")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Basic Gradient AppBar example
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Pokemon App",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent, // Required
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red, Colors.amber],
              begin: Alignment.centerLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),

      body: IndexedStack(index: _selectedIndex, children: _pages),

      bottomNavigationBar: MyNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) {
          setState(() {
            _selectedIndex = i;
          });
        },
      ),

      drawer: const MyDrawer(),
    );
  }
}
