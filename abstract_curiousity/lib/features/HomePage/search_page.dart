import 'package:flutter/material.dart';

class SearchBarN extends StatefulWidget {
  const SearchBarN({
    Key? key,
  }) : super(key: key);

  @override
  _SearchBarNState createState() => _SearchBarNState();
}

class _SearchBarNState extends State<SearchBarN> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ), // added border color
                        ),
                        filled: true,
                        fillColor: Colors.white
                            .withOpacity(0.08), // changed fill color
                        hintStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),

                        iconColor: Colors.amber,
                      ),
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white, // added cursor color
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Call onClose with 'false' when the widget is disposed

    super.dispose();
  }
}
