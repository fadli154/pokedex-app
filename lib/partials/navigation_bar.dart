import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class MyNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MyNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      style: TabStyle.fixedCircle,
      initialActiveIndex: currentIndex,
      backgroundColor: Colors.red,
      height: 70,
      items: [
        TabItem(icon: Icons.home, title: 'Home'),
        TabItem(icon: Icons.map, title: 'Map'),
        TabItem(icon: Icons.add, title: 'Add'),
        TabItem(icon: Icons.message, title: 'Message'),
        TabItem(icon: Icons.people, title: 'Profile'),
      ],
      onTap: onTap,
    );
  }
}
