import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:package_flutter/pages/main_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Do You Like Pokemon?",
          body: "Lorem ipsum...",
          image: Lottie.asset('assets/lotties/Pikachu.json'),
        ),
        PageViewModel(
          title: "Title",
          body: "Description",
          image: const Center(
            child: Text("👋", style: TextStyle(fontSize: 100.0)),
          ),
        ),
      ],
      showSkipButton: true,
      skip: const Icon(Icons.skip_next),
      next: const Text("Next"),
      done: const Text("Done"),
      onDone: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
        );
      },
    );
  }
}
