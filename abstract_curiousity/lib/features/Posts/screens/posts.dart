import 'package:abstract_curiousity/Features/Posts/_components/post_widget.dart';

import 'package:abstract_curiousity/Features/Posts/screens/new_screen.dart';
import 'package:flutter/material.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                // isScrollControlled: true,
                // isDismissible: true,
                useSafeArea: true,
                context: context,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    backgroundColor: Colors.black,
                    title: const Text(
                      'Select Post Type',
                      style: TextStyle(color: Colors.white),
                    ),
                    children: [
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const NewScreen(),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Icon(
                                Icons.web,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                'Share a Link',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const NewScreen(),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Icon(
                                Icons.wrap_text_sharp,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                'Write a Post',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                  // return Dialog(
                  //   child: Container(
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 10, vertical: 10),
                  //     // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  //     color: Colors.black,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         GestureDetector(
                  //           onTap: () {
                  //             Navigator.of(context).push(
                  //               MaterialPageRoute(
                  //                 builder: (context) => const NewScreen(),
                  //               ),
                  //             );
                  //           },
                  //           child: Column(
                  //             children: [
                  // Container(
                  //   padding: const EdgeInsets.all(10),
                  //   decoration: BoxDecoration(
                  //     color: Colors.white.withOpacity(0.3),
                  //     borderRadius: BorderRadius.circular(50),
                  //   ),
                  //   child: const Icon(
                  //     Icons.web,
                  //     size: 40,
                  //     color: Colors.white,
                  //   ),
                  // ),
                  //               const Text(
                  //                 "Share a Link",
                  //                 textAlign: TextAlign.center,
                  //                 style: TextStyle(
                  //                   color: Colors.white,
                  //                   fontSize: 10,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //         GestureDetector(
                  //           onTap: () {
                  //             Navigator.of(context).push(
                  //               MaterialPageRoute(
                  //                 builder: (context) => const NewScreen(),
                  //               ),
                  //             );
                  //           },
                  //           child: Column(
                  //             children: [
                  //               Container(
                  //                 padding: const EdgeInsets.all(10),
                  //                 decoration: BoxDecoration(
                  //                   color: Colors.white.withOpacity(0.3),
                  //                   borderRadius: BorderRadius.circular(50),
                  //                 ),
                  //                 child: const Icon(
                  //                   Icons.web,
                  //                   size: 40,
                  //                   color: Colors.white,
                  //                 ),
                  //               ),
                  //               const Text(
                  //                 "Share a Link",
                  //                 textAlign: TextAlign.center,
                  //                 style: TextStyle(
                  //                   color: Colors.white,
                  //                   fontSize: 10,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // );
                },
              );
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => const NewScreen(),
              //   ),
              // );
            },
            child: const Icon(
              Icons.share,
            ),
          ),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: AppBar(
              backgroundColor: Colors.black,
              bottom: const TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    text: "All Posts",
                  ),
                  Tab(text: "Following"),
                ],
              ),
            ),
          ),
          body: const TabBarView(
            children: [
              PostsScreenBuilder(),
              PostsScreenBuilder(),
            ],
          )),
    );
  }
}

class PostsScreenBuilder extends StatelessWidget {
  const PostsScreenBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Transform.rotate(
                    angle: 40,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.link,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Welcome to Shares',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'A Single Place to discover Articles, Stories written by the People you Love',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const PostWidget(),
            const PostWidget(),
            const PostWidget(),
            const PostWidget(),
          ],
        ),
      ),
    );
  }
}
