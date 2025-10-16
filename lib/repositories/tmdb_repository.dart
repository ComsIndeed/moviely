import 'package:moviely/models/show_item.dart';
import 'package:tmdb_api/tmdb_api.dart';

class TmdbRepository {
  TMDB _tmdb;
  V3 get api => _tmdb.v3;
  TmdbRepository({required String apiKey, required String readAcessToken})
    : _tmdb = TMDB(ApiKeys(apiKey, readAcessToken));

  void setCredentials({
    required String apiKey,
    required String readAcessToken,
  }) {
    _tmdb = TMDB(ApiKeys(apiKey, readAcessToken));
  }

  Future<List<ShowItem>> search({required String query}) async {
    final response =
        await api.search.queryMulti(query, includeAdult: true)
            as Map<String, dynamic>;
    final items = response["results"] as List<Map<String, dynamic>>;
    final showItems = items.map((e) => ShowItem.fromMap(e)).toList();
    return showItems;
  }
}
