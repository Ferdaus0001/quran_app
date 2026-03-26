import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/auth/sing_in_screen.dart';
import 'package:quran_app/auth/sing_up_screen.dart';


class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                // Welcome Text
                Text(
                  isLogin ? "Welcome" : "Create Account",
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  isLogin
                      ? "Sign in to your account or create a new one"
                      : "Please fill the information to create your account",
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),

                const SizedBox(height: 40),

                // Cupertino Tab
                SizedBox(
                  width: double.infinity,
                  height:60,
                  child: CupertinoSlidingSegmentedControl<bool>(

                    groupValue: isLogin,

                    backgroundColor: Colors.grey[100]!,
                    thumbColor: Colors.white,
                    padding: const EdgeInsets.all(4),
                    children: const {
                      true: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text('Login', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                      false: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text('Register', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                    },
                    onValueChanged: (bool? value) {
                      if (value != null) {
                        setState(() => isLogin = value);
                      }
                    },
                  ),
                ),

                const SizedBox(height: 32),

                // Show Login or Register Screen
                isLogin ? const LoginScreen() : const RegisterScreen(),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}