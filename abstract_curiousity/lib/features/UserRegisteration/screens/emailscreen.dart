import 'package:abstract_curiousity/Features/UserRegisteration/screens/emailVerify.dart';
import 'package:abstract_curiousity/utils/widgets/extendedTextButton.dart';
import 'package:flutter/material.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final emailEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 5),
                child: Text(
                  "Enter your Email",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  "Your Email will be used for logging to Abstract.",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailEditingController,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Enter your Email",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              const Expanded(
                child: SizedBox(
                  height: 10,
                ),
              ),
              ExtendedTextButton(
                color: Colors.grey.shade900,
                title: "Continue to Verification",
                onPressed: () {
                  if (emailEditingController.text.isNotEmpty &&
                      emailEditingController.text.contains("@") &&
                      emailEditingController.text.contains(".")) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const EmailVerify(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          "Please enter a valid email",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
