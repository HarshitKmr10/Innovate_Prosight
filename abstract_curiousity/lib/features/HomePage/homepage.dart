import 'package:abstract_curiousity/Features/Headlines/headlines.dart';
import 'package:abstract_curiousity/Features/HomePage/home.dart';
import 'package:abstract_curiousity/Features/Posts/screens/posts.dart';
import 'package:abstract_curiousity/Features/Profile/profile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final int pageNumber;
  const HomePage({super.key, required this.pageNumber});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  @override
  void initState() {
    super.initState();
    _index = widget.pageNumber;
  }

  List<Widget> pages = const [Home(), Posts(), Headlines(), UserProfile()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   leading: IconButton(
      //     icon: const Icon(
      //       Icons.arrow_back_ios,
      //       color: Colors.white,
      //     ),
      //     onPressed: () => Navigator.of(context).pop(),
      //   ),
      // ),
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(color: Colors.white, size: 30),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black.withOpacity(0.2),
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        currentIndex: _index,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shape_line_rounded), label: 'Chat'),
          BottomNavigationBarItem(
              icon: Icon(Icons.newspaper), label: 'Headline'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
