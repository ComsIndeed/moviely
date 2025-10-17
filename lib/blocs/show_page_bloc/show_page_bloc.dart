import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviely/blocs/show_page_bloc/show_page_event.dart';
import 'package:moviely/blocs/show_page_bloc/show_page_state.dart';
import 'package:moviely/repositories/tmdb_repository.dart';

class ShowPageBloc extends Bloc<ShowPageEvent, ShowPageState> {
  final TmdbRepository tmdbRepository;

  ShowPageBloc(this.tmdbRepository) : super(ShowPageInitialState()) {
    on<ShowPageFetchEvent>(_onFetchEvent);
  }

  FutureOr<void> _onFetchEvent(event, emit) async {
    emit(ShowPageLoadingState());
    try {
      if (event.mediaType == "movie") {
        final result = await tmdbRepository.getMovie(movieId: event.showId);
        emit(ShowPageLoadedState(data: result));
      } else if (event.mediaType == "tv") {
        final result = await tmdbRepository.getTvShowWithEpisodes(
          showId: event.showId,
        );
        emit(ShowPageLoadedState(data: result));
      }
    } catch (e) {
      emit(ShowPageErrorState(message: e.toString()));
    }
  }
}
