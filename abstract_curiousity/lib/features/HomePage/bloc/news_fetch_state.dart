part of 'news_fetch_bloc.dart';

@immutable
sealed class NewsFetchState extends Equatable{}

class NewsFetchLoading extends NewsFetchState{
  @override
  List<Object?> get props => [];
}
//Loaded stated
class NewsFetchLoaded extends NewsFetchState{
  final List<CustomArticle> articles;
  NewsFetchLoaded({required this.articles});
  @override
  List<Object?> get props => [articles];
}
//error state
class NewsFetchError extends NewsFetchState{
  final String error;
  NewsFetchError({required this.error});
  @override
  List<Object?> get props => [error];
}
