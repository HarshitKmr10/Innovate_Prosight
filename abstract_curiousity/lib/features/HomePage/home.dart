import 'package:abstract_curiousity/Features/Headlines/headlines.dart';
import 'package:abstract_curiousity/Features/HomePage/CategoryNewsPage.dart';
import 'package:abstract_curiousity/Features/HomePage/search_page.dart';


import 'package:abstract_curiousity/Features/HomePage/usercomponent.dart';
import 'package:abstract_curiousity/features/HomePage/services/homerepository.dart';
import 'package:abstract_curiousity/models/article.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  bool isSearchBarOpen = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: SafeArea(
          child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              bottom: isSearchBarOpen
                  ? null
                  : const TabBar(
                      isScrollable: true,
                      physics: BouncingScrollPhysics(),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(
                          text: "For You",
                        ),
                        Tab(text: "Entertainment"),
                        Tab(text: "Business"),
                        Tab(text: "Technology"),
                        Tab(text: "Sports"),
                      ],
                    ),
              backgroundColor: Colors.black,
              actions: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Icon(
                    Icons.shield_moon,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Read your daily news',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return const SearchBarN();
                        },
                      ),
                    );
                  },
                ),
              ],
            )
          ];
        },
        body: const TabBarView(
          children: [
            ForYouPage(),
            CategoricalArticles(topic: "entertainment"),
            CategoricalArticles(topic: "business"),
            CategoricalArticles(topic: "technology"),
            CategoricalArticles(topic: "sports"),
          ],
        ),
      )),
    );
  }
}

class ForYouPage extends StatefulWidget {
  const ForYouPage({
    super.key,
  });

  @override
  State<ForYouPage> createState() => _ForYouPageState();
}

class _ForYouPageState extends State<ForYouPage> {
  final HomeRepository _homeRepository = HomeRepository();
  String quote = "Always be curious";
  List<CustomArticle> headlines = [];
  Future _refresh() async {
    _homeRepository.fetchNews().then((articles) {
      setState(() {
        headlines = articles;
      });
    });
  }

  bool isQuoteExpanded = false;
  Future<void> fetchQuote() async {
    String output = await _homeRepository.fetchRandomQuote();

    setState(() {
      quote = output;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchQuote();
    _homeRepository.fetchNews().then((articles) {
      setState(() {
        headlines = articles;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            YourWidget(userId: FirebaseAuth.instance.currentUser!.uid),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            'Quote of the day',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Flexible(
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                isQuoteExpanded = !isQuoteExpanded;
                              });
                            },
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4),
                      child: Text(
                        isQuoteExpanded
                            ? '“$quote”'
                            : '“${quote.substring(0, quote.length > 60 ? 60 : quote.length)}...”',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              color: Colors.white30,
            ),
            ArticleListBuilder(
              headlines: headlines,
              refresh: _refresh,
              isHeadlines: false,
            ),
          ],
        ),
      ),
    );
  }
}
