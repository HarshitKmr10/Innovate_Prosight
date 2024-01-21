part of 'webview_bloc.dart';

@immutable
sealed class WebviewEvent {}

class SummaryRequested extends WebviewEvent {
  final String extractedText;

  SummaryRequested({
    required this.extractedText,
  });
}

class ContentRequested extends WebviewEvent {
  final String url;
  ContentRequested({
    required this.url,
  });
}

class SummaryUploadRequested extends WebviewEvent {
  final String extractedText;
  final String url;

  SummaryUploadRequested({
    required this.extractedText,
    required this.url,
  });
}
