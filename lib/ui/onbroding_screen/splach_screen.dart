import 'package:flutter/material.dart';

import '../../auth/auth_screen.dart';
import '../../auth/sing_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      // TODO: Change to your next screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>   AuthScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.red,
        ),
        child: const Center(
          child: CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Icon(Icons.flutter_dash, size: 40),
          ),
        ),
      ),
    );
  }
}