abstract class HomepageSearchEvent {}

class HomepageSearchQueryEvent extends HomepageSearchEvent {
  final String query;

  HomepageSearchQueryEvent({required this.query});
}
