import 'package:moviely/models/show_item.dart';
import 'package:moviely/models/tv_show.dart'; // Import your TvShow model
import 'package:tmdb_api/tmdb_api.dart';
import 'package:moviely/models/episode.dart';

class TmdbRepository {
  late TMDB _tmdb;
  V3 get api => _tmdb.v3;

  TmdbRepository({required String apiKey, required String readAccessToken}) {
    _tmdb = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true),
    );
  }

  void setCredentials({
    required String apiKey,
    required String readAccessToken,
  }) {
    _tmdb = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true),
    );
  }

  Future<List<ShowItem>> search({required String query}) async {
    final response =
        await api.search.queryMulti(query, includeAdult: true)
            as Map<String, dynamic>;
    final results = response['results'] as List;
    final showItems = results
        .map((item) => ShowItem.fromMap(item as Map<String, dynamic>))
        .toList();
    return showItems;
  }

  /// Fetches the details for a single movie.
  Future<Movie> getMovie({required int movieId}) async {
    final response =
        await api.movies.getDetails(movieId) as Map<String, dynamic>;
    return Movie.fromMap(response);
  }

  /// Fetches TV show details AND all episodes for all seasons.
  Future<TvShow> getTvShowWithEpisodes({required int showId}) async {
    // 1. Fetch the main TV show details first.
    final showResponse =
        await api.tv.getDetails(showId) as Map<String, dynamic>;
    final initialTvShow = TvShow.fromMap(showResponse);

    // 2. Prepare to fetch details for all seasons in parallel.
    final seasonFutures = initialTvShow.seasons.map((season) async {
      final seasonResponse =
          await api.tvSeasons.getDetails(showId, season.seasonNumber)
              as Map<String, dynamic>;

      // The season response contains a list of episodes. The Season.fromMap factory
      // will automatically parse them.
      final episodes = (seasonResponse['episodes'] as List)
          .map((e) => Episode.fromMap(e as Map<String, dynamic>))
          .toList();

      // Return a new Season object with the episode list included.
      return season.copyWith(episodes: episodes);
    }).toList();

    // 3. Wait for all season detail fetches to complete.
    final seasonsWithEpisodes = await Future.wait(seasonFutures);

    // 4. Create a final TvShow object with the fully populated seasons list.
    final finalTvShow = initialTvShow.copyWith(seasons: seasonsWithEpisodes);

    return finalTvShow;
  }
}
