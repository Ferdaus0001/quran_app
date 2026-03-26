import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'SetNewPasswordScreen.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final int otpLength = 6;
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _verifyOtp() {
    String otp = _pinController.text.trim();
    if (otp.length == otpLength) {
      // ✅ OTP Verified -> Navigate to Set New Password Screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const SetNewPasswordScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter full 6-digit OTP")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 60,
      textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey),
        color: Colors.grey[100],
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEF4444), width: 2),
        color: Colors.white,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 22),
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "OTP Verification",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                "Enter OTP Code",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                "We have sent a 6-digit code to your email",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),

              /// ✅ Pinput
              Pinput(
                length: otpLength,
                controller: _pinController,
                focusNode: _focusNode,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                onCompleted: (pin) => _verifyOtp(),
              ),

              const SizedBox(height: 50),

              /// ✅ Verify Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _verifyOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEF4444),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text(
                    "Verify OTP",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("OTP Resent to your email")),
                  );
                },
                child: const Text(
                  "Didn't receive code? Resend",
                  style: TextStyle(
                    color: Color(0xFFEF4444),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}