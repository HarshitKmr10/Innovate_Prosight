import 'package:abstract_curiousity/utils/models/topicmodel.dart';

import 'package:flutter/material.dart';

class ChooseTopics extends StatefulWidget {
  static const String routeName = '/personalise-topics';
  const ChooseTopics({super.key});

  @override
  State<ChooseTopics> createState() => _ChooseTopicsState();
}

class _ChooseTopicsState extends State<ChooseTopics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              "Follow alteast 5 Topics",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: const TopicSelectorPage(),
    );
  }
}
