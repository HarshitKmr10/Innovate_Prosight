import 'package:flutter/material.dart';

class AppInfoModal extends StatefulWidget {
  const AppInfoModal({super.key});

  @override
  State<AppInfoModal> createState() => _AppInfoModalState();
}

class _AppInfoModalState extends State<AppInfoModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 30),
      height: MediaQuery.of(context).size.height * 0.25,
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
                    Icons.info_outline,
                    color: Colors.grey,
                    size: 30,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Terms Of Service',
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
                    color: Colors.grey,
                    size: 30,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Privacy Policy',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 20),
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
                    Icons.logout_outlined,
                    color: Colors.red,
                    size: 30,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Community Guidelines',
                    style: TextStyle(
                        color: Colors.white,
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
