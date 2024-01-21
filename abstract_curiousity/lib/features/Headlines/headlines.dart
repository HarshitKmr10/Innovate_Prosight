
import 'package:abstract_curiousity/features/Headlines/bloc/headline_bloc.dart';
import 'package:abstract_curiousity/features/HomePage/services/homerepository.dart';
import 'package:abstract_curiousity/features/webView/webview.dart';
import 'package:abstract_curiousity/models/article.dart';
import 'package:abstract_curiousity/utils/widgets/custom_loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Import your CustomArticle model and the fetchTopHeadlines function here

class Headlines extends StatefulWidget {
  const Headlines({Key? key}) : super(key: key);

  @override
  State<Headlines> createState() => _HeadlinesState();
}

class _HeadlinesState extends State<Headlines> {
  List<CustomArticle> headlines = [];
  Future _refresh() async {
    BlocProvider.of<HeadlineBloc>(context).add(
      HeadlineRequested(),
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocListener<HeadlineBloc, HeadlineState>(
          listener: (context, state) {
            if (state is HeadlineLoading) {
              const Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            }
            if (state is HeadlineError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
            if (state is HeadlineLoaded) {
              headlines = state.articles;
            }
          },
          child: BlocBuilder<HeadlineBloc, HeadlineState>(
            builder: (context, state) {
              if (state is HeadlineLoading) {
                return const Center(child: CustomLoadingWidget());
              }
              if (state is HeadlineLoaded) {
                headlines = state.articles;
                return Column(children: [
                  const Center(
                    child: Text(
                      "Headlines",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ArticleListBuilder(
                    headlines: headlines,
                    refresh: _refresh,
                    isHeadlines: true,
                  ),
                ]);
              }
              return const Center(
                child: Text("Page Not Serviced"),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ArticleListBuilder extends StatefulWidget {
  final List<CustomArticle> headlines;
  final Future<void> Function() refresh;
  final bool isHeadlines;
  const ArticleListBuilder({
    Key? key,
    required this.headlines,
    required this.refresh,
    required this.isHeadlines,
  }) : super(key: key);

  @override
  State<ArticleListBuilder> createState() => _ArticleListBuilderState();
}

class _ArticleListBuilderState extends State<ArticleListBuilder> {
  HomeRepository _repository = HomeRepository();
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
                _repository.incrementNumberOfArticlesRead();
                _repository.saveArticleToUserHistory(article);
                _repository.incrementReadCount(article);
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

                      //color
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              ),
                      ],
                    ),
                    // contentPadding: const EdgeInsets.symmetric(
                    //   horizontal: 20,
                    //   vertical: 10,
                    // ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (article.author != "")
                              Text(
                                "${article.author}",
                                style: TextStyle(
                                  color: Colors.blue[200],
                                ),
                              ),
                            if (article.isFlagged)
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                child: Text(
                                  "Clickbait",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            // add a badge using article.isFlagged
                          ],
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
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LiveArticleAttributesWidget(
                          articleUrl: article.url,
                          isHeadlines: widget.isHeadlines,
                        ),
                      ],
                    )),
              ),
            );
          },
        ),
      ),
    );
  }
}

class LiveArticleAttributesWidget extends StatelessWidget {
  final String articleUrl;
  final bool isHeadlines;

  const LiveArticleAttributesWidget(
      {super.key, required this.articleUrl, required this.isHeadlines});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CustomArticle?>(
      stream: getArticleDataStream(), // Replace with your user data stream
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Data is still loading
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Error occurred
          return Text('Error: ${snapshot.error}');
        } else {
          final articleData = snapshot.data;

          if (articleData == null) {
            return const Text('details not found');
          }
          // print(articleData.toMap().toString());
          // Display UserLevelComponent with fetched data
          return Container(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Icon(
                  Icons.favorite_border,
                  color: Colors.grey[700],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    articleData.likes.toString(),
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                // add a vertical line
                Container(
                  height: 15,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: 1,
                  color: Colors.grey[700],
                ),
                Text(
                  "0",
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "comments",
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                Container(
                  height: 15,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: 1,
                  color: Colors.grey[700],
                ),
                Icon(
                  Icons.remove_red_eye,
                  color: Colors.grey[700],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    articleData.readCount.toString(),
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Stream<CustomArticle?> getArticleDataStream() {
    final firestore = FirebaseFirestore.instance;
    final collection = isHeadlines
        ? firestore.collection("headlines")
        : firestore.collection("articles");

    return collection
        .where("url", isEqualTo: articleUrl)
        .snapshots()
        .map((doc) {
      if (doc.docs.isNotEmpty) {
        return CustomArticle.fromMap(doc.docs[0].data());
      } else {
        return null;
      }
    });
  }
}
