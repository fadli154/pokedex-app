import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class MyAvatarGlow extends StatelessWidget {
  const MyAvatarGlow({super.key});

  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      glowColor: Colors.red,
      child: Material(
        // Replace this child with your own
        elevation: 8.0,
        shape: CircleBorder(),
        child: CircleAvatar(
          backgroundColor: Colors.grey[100],
          radius: 30.0,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
