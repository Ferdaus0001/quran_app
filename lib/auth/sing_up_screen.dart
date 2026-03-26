import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Full Name"),
        const SizedBox(height: 8),
        _buildTextField("John Doe", Icons.person_outline),

        const SizedBox(height: 20),
        _buildLabel("Email"),
        const SizedBox(height: 8),
        _buildTextField("you@example.com", Icons.email_outlined),

        const SizedBox(height: 20),
        _buildLabel("Password"),
        const SizedBox(height: 8),
        _buildPasswordField(),

        const SizedBox(height: 20),
        _buildLabel("Confirm Password"),
        const SizedBox(height: 8),
        _buildPasswordField(),

        const SizedBox(height: 32),

        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              // TODO: Add Register API here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              elevation: 0,
            ),
            child: const Text(
              "Create Account",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),
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
}