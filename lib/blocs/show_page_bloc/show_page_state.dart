abstract class ShowPageState {}

class ShowPageInitialState extends ShowPageState {}

class ShowPageLoadingState extends ShowPageState {}

class ShowPageLoadedState<T> extends ShowPageState {
  final T data;

  ShowPageLoadedState({required this.data});
}

class ShowPageErrorState extends ShowPageState {
  final String message;

  ShowPageErrorState({required this.message});
}
