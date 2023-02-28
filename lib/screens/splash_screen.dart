import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("spalshcreen");
    return const Scaffold(
      body: Center(
        child: Text('Loading...'),
      ),
    );
  }
}
