import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviely/blocs/homepage_search_bloc/homepage_search_event.dart';
import 'package:moviely/blocs/homepage_search_bloc/homepage_search_state.dart';
import 'package:moviely/models/show_item.dart';
import 'package:moviely/repositories/tmdb_repository.dart';
import 'package:moviely/utilities/debouncer.dart';

class HomepageSearchBloc
    extends Bloc<HomepageSearchEvent, HomepageSearchState> {
  final TmdbRepository tmdbRepo;
  final debouncer = Debouncer(Duration(milliseconds: 50));

  HomepageSearchBloc(this.tmdbRepo) : super(HomepageSearchInitialState()) {
    on<HomepageSearchQueryEvent>((event, emit) async {
      emit(HomepageSearchLoadingState());

      debouncer.run(() async {
        try {
          final results = await tmdbRepo.search(query: event.query);
          Map<String, List<ShowItem>> searchResults = {};
          for (var e in results) {
            if (e.mediaType == "movie") {
              searchResults.putIfAbsent("movies", () => []).add(e);
            } else if (e.mediaType == "tv") {
              searchResults.putIfAbsent("tv", () => []).add(e);
            } else if (e.mediaType == "person") {
              searchResults.putIfAbsent("people", () => []).add(e);
            }
          }

          emit(HomepageSearchLoadedState(searchResults: searchResults));
        } catch (e) {
          emit(HomepageSearchErrorState(message: e.toString()));
        }
      });
    });
  }
}
