part of 'headline_bloc.dart';

@immutable
sealed class HeadlineState extends Equatable {}

class HeadlineLoading extends HeadlineState {
  @override
  List<Object?> get props => [];
}

//Loaded stated
class HeadlineLoaded extends HeadlineState {
  final List<CustomArticle> articles;
  HeadlineLoaded({required this.articles});
  @override
  List<Object?> get props => [articles];
}

//error state
class HeadlineError extends HeadlineState {
  final String error;
  HeadlineError({required this.error});
  @override
  List<Object?> get props => [error];
}
