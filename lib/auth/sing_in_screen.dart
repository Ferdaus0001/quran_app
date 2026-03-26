import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Email"),
        const SizedBox(height: 8),
        _buildTextField("you@example.com", Icons.email_outlined),

        const SizedBox(height: 24),
        _buildLabel("Password"),
        const SizedBox(height: 8),
        _buildPasswordField(),

        const SizedBox(height: 16),

        // Sign In Button
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              // TODO: Add Login API here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              elevation: 0,
            ),
            child: const Text(
              "Sign in",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),
        ),

        const SizedBox(height: 16),
        Center(
          child: TextButton(
            onPressed: () {},
            child: const Text(
              "Forgot password?",
              style: TextStyle(color: Color(0xFFEF4444), fontWeight: FontWeight.w600),
            ),
          ),
        ),

        const SizedBox(height: 32),

        // OR + Social
        const Row(
          children: [
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "OR CONTINUE WITH",
                style: TextStyle(color: Colors.grey, fontSize: 12, letterSpacing: 1),
              ),
            ),
            Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 24),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _socialButton(Icons.g_mobiledata, Colors.red),
            const SizedBox(width: 16),
            _socialButton(Icons.facebook, const Color(0xFF1877F2)),
            const SizedBox(width: 16),
            _socialButton(Icons.apple, Colors.black),
          ],
        ),
      ],
    );
  }

  Widget _buildLabel(String text) => Text(
    text,
    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
  );

  Widget _buildTextField(String hint, IconData icon) => TextField(
    decoration: InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.grey),
      filled: true,
      fillColor: Colors.grey[50],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
    ),
  );

  Widget _buildPasswordField() => TextField(
    obscureText: true,
    decoration: InputDecoration(
      hintText: "••••••••••",
      prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
      suffixIcon: const Icon(Icons.visibility_off_outlined, color: Colors.grey),
      filled: true,
      fillColor: Colors.grey[50],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
    ),
  );

  Widget _socialButton(IconData icon, Color color) => Container(
    width: 60,
    height: 60,
    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Icon(icon, size: 28, color: color),
  );
}