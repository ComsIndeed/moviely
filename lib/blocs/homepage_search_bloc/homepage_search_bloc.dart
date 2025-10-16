import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviely/blocs/homepage_search_bloc/homepage_search_event.dart';
import 'package:moviely/blocs/homepage_search_bloc/homepage_search_state.dart';
import 'package:moviely/models/show_item.dart';
import 'package:moviely/repositories/tmdb_repository.dart';

class HomepageSearchBloc
    extends Bloc<HomepageSearchEvent, HomepageSearchState> {
  final TmdbRepository tmdbRepo;

  HomepageSearchBloc(this.tmdbRepo) : super(HomepageSearchInitialState()) {
    on<HomepageSearchQueryEvent>((event, emit) async {
      if (event.query.isEmpty) {
        emit(HomepageSearchInitialState());
        return;
      }

      emit(HomepageSearchLoadingState());
      print(event.query);

      try {
        final results = await tmdbRepo.search(query: event.query);
        Map<String, List<ShowItem>> searchResults = {
          "movies": [],
          "tv": [],
          "people": [],
        };

        for (var e in results) {
          if (e.mediaType == "movie") {
            searchResults["movies"]!.add(e);
          } else if (e.mediaType == "tv") {
            searchResults["tv"]!.add(e);
          } else if (e.mediaType == "person") {
            searchResults["people"]!.add(e);
          }
        }

        emit(HomepageSearchLoadedState(searchResults: searchResults));
      } catch (e) {
        emit(HomepageSearchErrorState(message: e.toString()));
      }
    });
  }
}
