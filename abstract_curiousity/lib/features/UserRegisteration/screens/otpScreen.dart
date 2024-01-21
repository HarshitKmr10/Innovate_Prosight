import 'package:flutter/material.dart';

class Otpscreen extends StatefulWidget {
  const Otpscreen({super.key});

  @override
  State<Otpscreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends State<Otpscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: const Center(
        child: Text("OTP Screen",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            )),
      ),
    );
  }
}
