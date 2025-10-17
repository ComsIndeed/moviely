abstract class ShowPageEvent {}

class ShowPageFetchEvent extends ShowPageEvent {
  final int showId;
  final String mediaType;

  ShowPageFetchEvent({required this.showId, required this.mediaType});
}
