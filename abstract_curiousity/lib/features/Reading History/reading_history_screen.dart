
import 'package:abstract_curiousity/features/HomePage/services/homerepository.dart';
import 'package:abstract_curiousity/features/webView/webview.dart';
import 'package:abstract_curiousity/models/article.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReadingHistory extends StatefulWidget {
  const ReadingHistory({super.key});

  @override
  State<ReadingHistory> createState() => _ReadingHistoryState();
}

class _ReadingHistoryState extends State<ReadingHistory> {
  List<CustomArticle> headlines = [];
  Future _refresh() async {
    List<CustomArticle> articles = await HomeRepository()
        .fetchUserHistory(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      headlines = articles;
    });
  }

  @override
  void initState() {
    _refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Reading History",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 23,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
          ),
        ),
      ),
      body: Column(
        children: [
          ArticleListBuilder_FORHISTORY(
            headlines: headlines,
            refresh: _refresh,
          ),
        ],
      ),
    );
  }
}

class ArticleListBuilder_FORHISTORY extends StatefulWidget {
  final List<CustomArticle> headlines;
  final Future<void> Function() refresh;
  const ArticleListBuilder_FORHISTORY({
    Key? key,
    required this.headlines,
    required this.refresh,
  }) : super(key: key);

  @override
  State<ArticleListBuilder_FORHISTORY> createState() =>
      _ArticleListBuilder_FORHISTORYState();
}

class _ArticleListBuilder_FORHISTORYState
    extends State<ArticleListBuilder_FORHISTORY> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: widget.refresh,
        child: ListView.builder(
          itemCount: widget.headlines.length,
          itemBuilder: (context, index) {
            final article = widget.headlines[index];

            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => WebViewApp(article: article)));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 08, vertical: 7),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    trailing: Column(
                      children: [
                        article.urlToImage != null
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(
                                  article.urlToImage!,
                                ), // No matter how big it is, it won't overflow
                                onBackgroundImageError:
                                    (exception, stackTrace) {},
                              )
                            : const CircleAvatar(
                                backgroundImage: AssetImage(
                                    "assets/images/landingScreen5.png"),
                              )
                      ],
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (article.author != "")
                          Text(
                            "${article.author}",
                            style: TextStyle(
                              color: Colors.blue[200],
                            ),
                          ),
                        Text(
                          article.title,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          //number of likes, comments, and number of reads
                          Icon(
                            Icons.favorite_border,
                            color: Colors.grey[700],
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "0",
                            style: TextStyle(
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),

                          Text(
                            "0",
                            style: TextStyle(
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "comments",
                            style: TextStyle(
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.remove_red_eye,
                            color: Colors.grey[700],
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "reads",
                            style: TextStyle(
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            );
          },
        ),
      ),
    );
  }
}
