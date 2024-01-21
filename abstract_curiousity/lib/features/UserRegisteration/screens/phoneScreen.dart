import 'package:abstract_curiousity/Features/UserRegisteration/screens/otpScreen.dart';
import 'package:abstract_curiousity/utils/widgets/extendedTextButton.dart';
import 'package:flutter/material.dart';

import 'emailscreen.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final phoneNumberController = TextEditingController();
  bool isInteger(num value) => (value % 1) == 0;
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
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Enter your phone number",
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
                "Your Phone Number will be used for each signIn.",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade600,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
                      child: Text(
                        "+91",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextFormField(
                          controller: phoneNumberController,
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          decoration: const InputDecoration(
                            hintText: "Enter your phone number",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const EmailScreen()));
                  },
                  child: const Text(
                    "Use Email Instead?",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
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
                title: "Confirm Phone Number",
                onPressed: () {
                  if (phoneNumberController.text.isNotEmpty &&
                      phoneNumberController.text.length == 10 &&
                      isInteger(
                        num.parse(phoneNumberController.text),
                      )) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const Otpscreen()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          "Please enter a valid phone number",
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
