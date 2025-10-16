import 'package:moviely/models/show_item.dart';

abstract class HomepageSearchState {}

class HomepageSearchInitialState extends HomepageSearchState {}

class HomepageSearchLoadingState extends HomepageSearchState {}

class HomepageSearchLoadedState extends HomepageSearchState {
  final Map<String, List<ShowItem>> searchResults;

  HomepageSearchLoadedState({required this.searchResults});
}

class HomepageSearchErrorState extends HomepageSearchState {
  final String message;

  HomepageSearchErrorState({required this.message});
}
