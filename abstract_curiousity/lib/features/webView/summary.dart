import 'package:flutter/material.dart';

class SummaryPage extends StatefulWidget {
  final String summary;
  const SummaryPage({
    super.key,
    required this.summary,
  });

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Summary",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 8,
            top: 15,
          ),
          child: Column(
            children: [
              Expanded(
                child: Text(
                  widget.summary,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Roboto",
                    color: Colors.white.withOpacity(0.8),
                  ),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
