import 'dart:convert';

class ShowItem {
  final int id;
  final String mediaType;

  // Fields that can be null
  final String? backdropPath;
  final String? posterPath;
  final String? overview;

  // Unified fields (name/title, release/air date)
  final String name;
  final String releaseDate;

  // Fields with default values
  final bool adult;
  final List<int> genreIds;
  final double popularity;
  final double voteAverage;
  final int voteCount;

  ShowItem({
    required this.id,
    required this.mediaType,
    this.backdropPath,
    this.posterPath,
    this.overview,
    required this.name,
    required this.releaseDate,
    this.adult = false,
    this.genreIds = const [],
    this.popularity = 0.0,
    this.voteAverage = 0.0,
    this.voteCount = 0,
  });

  factory ShowItem.fromMap(Map<String, dynamic> map) {
    // Determine the media type first, it's crucial
    final mediaType = map['media_type'] as String? ?? 'unknown';

    // Handle name/title differences
    String name;
    if (mediaType == 'movie') {
      name = map['title'] as String? ?? '';
    } else if (mediaType == 'tv' || mediaType == 'person') {
      name = map['name'] as String? ?? '';
    } else {
      name = '';
    }

    // Handle date differences
    String releaseDate;
    if (mediaType == 'movie') {
      releaseDate = map['release_date'] as String? ?? '';
    } else if (mediaType == 'tv') {
      releaseDate = map['first_air_date'] as String? ?? '';
    } else {
      releaseDate = ''; // People don't have release dates
    }

    return ShowItem(
      id: map['id'] as int? ?? 0,
      mediaType: mediaType,
      name: name,
      releaseDate: releaseDate,
      adult: map['adult'] as bool? ?? false,
      backdropPath: map['backdrop_path'] as String?,
      posterPath: map['poster_path'] as String?,
      overview: map['overview'] as String?,
      genreIds: List<int>.from(map['genre_ids'] as List? ?? []),
      // Safe casting for numbers
      popularity: (map['popularity'] as num?)?.toDouble() ?? 0.0,
      voteAverage: (map['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: map['vote_count'] as int? ?? 0,
    );
  }

  factory ShowItem.fromJson(String source) =>
      ShowItem.fromMap(json.decode(source) as Map<String, dynamic>);
}
