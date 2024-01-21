import 'package:flutter/material.dart';

class EmailVerify extends StatelessWidget {
  const EmailVerify({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
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
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(
              Icons.mail_outline,
              size: 50,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Check your Email",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 05,
          ),
          Text(
            "We have sent a verification link to your email",
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 05,
          ),
          Text(
            "Tap the link to verify your account",
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      )),
    );
  }
}
