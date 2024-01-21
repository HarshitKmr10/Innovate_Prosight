import 'package:flutter/material.dart';

class ModalSheet extends StatefulWidget {
  const ModalSheet({
    super.key,
  });

  @override
  State<ModalSheet> createState() => _ModalSheetState();
}

class _ModalSheetState extends State<ModalSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 30),
      height: MediaQuery.of(context).size.height * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: GestureDetector(
              onTap: () {},
              child: const Text(
                'Follow',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ),
          Divider(
            color: Colors.grey.withOpacity(0.5),
            indent: 20.0,
            endIndent: 20.0,
          ),
          GestureDetector(
            onTap: () {},
            child: const Text(
              'Share',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          Divider(
            color: Colors.grey.withOpacity(0.5),
            indent: 20.0,
            endIndent: 20.0,
          ),
          GestureDetector(
            onTap: () {},
            child: const Text(
              'Report user',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          Divider(
            color: Colors.grey.withOpacity(0.5),
            indent: 20.0,
            endIndent: 20.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
