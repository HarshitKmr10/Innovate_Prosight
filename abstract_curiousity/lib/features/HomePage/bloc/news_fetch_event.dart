part of 'news_fetch_bloc.dart';

@immutable
sealed class NewsFetchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NewsFetchRequested extends NewsFetchEvent {
  final String topic;

  NewsFetchRequested({
    required this.topic,
  });
}
