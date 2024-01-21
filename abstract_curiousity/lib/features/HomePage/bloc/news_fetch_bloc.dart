import 'package:abstract_curiousity/Features/HomePage/services/homerepository.dart';
import 'package:abstract_curiousity/models/article.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'news_fetch_event.dart';
part 'news_fetch_state.dart';

class NewsFetchBloc extends Bloc<NewsFetchEvent, NewsFetchState> {
  final HomeRepository homeRepository;
  NewsFetchBloc({required this.homeRepository}) : super(NewsFetchLoading()) {
    on<NewsFetchRequested>((event, emit) async {
      try {
        emit(NewsFetchLoading());
        print(event.topic);
        List<CustomArticle> articles =
            await homeRepository.fetchNewsByTopic(event.topic);
        print(articles);
        emit(NewsFetchLoaded(articles: articles));
      } catch (e) {
        emit(NewsFetchError(error: e.toString()));
      }
    });
  }
}
