import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class DisplayScreen extends StatefulWidget {
  DisplayScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _DisplayScreenState createState() => new _DisplayScreenState(title: 'Hello');
}

class _DisplayScreenState extends State<DisplayScreen> {
  final String htmlData;

  _DisplayScreenState({required String title}) : htmlData = "r${title}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('flutter_html Example'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Html(
          data: htmlData,
        ),
      ),
    );
  }
}
