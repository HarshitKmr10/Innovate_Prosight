import 'package:flutter/material.dart';

class DangerModal extends StatefulWidget {
  const DangerModal({super.key});

  @override
  State<DangerModal> createState() => _DangerModalState();
}

class _DangerModalState extends State<DangerModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 30),
      height: MediaQuery.of(context).size.height * 0.2,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  Icon(
                    Icons.person_remove_alt_1_outlined,
                    color: Colors.grey,
                    size: 30,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Deactivate Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  Icon(
                    Icons.shield_moon_outlined,
                    color: Colors.red,
                    size: 30,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Delete Account',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w400,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
