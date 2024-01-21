import 'package:flutter/material.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  TextEditingController newsLinkController = TextEditingController();
  TextEditingController articleTextController = TextEditingController();
  final QuillEditorController controller = QuillEditorController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: newsLinkController,
                decoration: InputDecoration(
                  labelText: 'News Link',
                  hintText: 'https://www.example.com',
                  fillColor: Colors.grey[300],
                  filled: true,
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: articleTextController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Write your article',
                  hintText: //dummy text here
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec euismod, nisl eget ultricies aliquam, nunc nisl aliquet nunc, quis aliquam nisl nunc quis nisl. Donec euismod, nisl eget ultricies aliquam, nunc nisl aliquet nunc, quis aliquam nisl nunc quis nisl.',
                  fillColor: Colors.grey[300],
                  filled: true,
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Handle the logic for submitting the post here
                  // You can use newsLinkController.text and articleTextController.text
                },
                child: const Text('Post'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
