
import 'package:abstract_curiousity/features/Headlines/services/headlinerepository.dart';
import 'package:abstract_curiousity/models/article.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'headline_event.dart';
part 'headline_state.dart';

class HeadlineBloc extends Bloc<HeadlineEvent, HeadlineState> {
  final HeadlineRepository headlineRepository;
  HeadlineBloc({required this.headlineRepository}) : super(HeadlineLoading()) {
    on<HeadlineRequested>((event, emit) async {
      try {
        emit(HeadlineLoading());
        List<CustomArticle> articles =
            await headlineRepository.fetchTopHeadlines();
        emit(HeadlineLoaded(articles: articles));
      } catch (e) {
        emit(HeadlineError(error: e.toString()));
      }
    });
  }
}
