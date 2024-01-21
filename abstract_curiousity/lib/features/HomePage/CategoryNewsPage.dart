// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:abstract_curiousity/Features/Headlines/headlines.dart';
import 'package:abstract_curiousity/features/HomePage/bloc/news_fetch_bloc.dart';

import 'package:abstract_curiousity/models/article.dart';
import 'package:abstract_curiousity/utils/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Import your CustomArticle model and the fetchTopHeadlines function here

class CategoricalArticles extends StatefulWidget {
  final String topic;
  const CategoricalArticles({super.key, required this.topic});

  @override
  State<CategoricalArticles> createState() => _CategoricalArticlesState();
}

class _CategoricalArticlesState extends State<CategoricalArticles> {
  // final HomeRepository _homeRepository = HomeRepository();

  List<CustomArticle> headlines = [];
  Future<void> _pullRefresh() async {
    BlocProvider.of<NewsFetchBloc>(context).add(
      NewsFetchRequested(topic: widget.topic),
    );
    setState(() {});
    // _homeRepository.fetchNewsByTopic(widget.topic).then((articles) {
    //   setState(() {
    //     headlines = articles;
    //   });
    // });
  }

  @override
  void initState() {
    super.initState();
    _pullRefresh();
    // _homeRepository.fetchNewsByTopic(widget.topic).then((articles) {
    //   setState(() {
    //     headlines = articles;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        color: Colors.white,
        backgroundColor: Colors.yellow,
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        child: BlocListener<NewsFetchBloc, NewsFetchState>(
          listener: (context, state) {
            if (state is NewsFetchLoading) {
              const Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            }
            if (state is NewsFetchError) {
              const Center(
                child: Text("Page Not Serviced"),
              );
            }
            if (state is NewsFetchLoaded) {
              headlines = state.articles;
            }
          },
          child: BlocBuilder<NewsFetchBloc, NewsFetchState>(
            builder: (context, state) {
              if (state is NewsFetchLoading) {
                return const Center(child: CustomLoadingWidget());
              }
              if (state is NewsFetchError) {
                return const Center(
                  child: Text("Page Not Services"),
                );
              }
              return SafeArea(
                child: Column(
                  children: [
                    ArticleListBuilder(
                      headlines: headlines,
                      refresh: _pullRefresh,
                      isHeadlines: false,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
