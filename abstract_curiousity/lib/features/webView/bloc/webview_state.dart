part of 'webview_bloc.dart';

@immutable
abstract class WebviewState extends Equatable {}

class WebviewSummaryLoading extends WebviewState {
  @override
  List<Object?> get props => [];
}

class WebviewSummaryLoaded extends WebviewState {
  @override
  List<Object?> get props => [];
}

class WebviewSummaryError extends WebviewState {
  @override
  List<Object?> get props => [];
}
