import 'dart:convert';

import 'package:moviely/models/genre.dart';
import 'package:moviely/models/production_company.dart';
import 'package:moviely/models/production_country.dart';
import 'package:moviely/models/spoken_language.dart';

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

class Movie {
  final bool adult;
  final String? backdropPath;
  final dynamic belongsToCollection; // Can be a map, so handled as dynamic
  final int budget;
  final List<Genre> genres;
  final String homepage;
  final int id;
  final String? imdbId;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final DateTime releaseDate;
  final int revenue;
  final int? runtime;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Movie({
    required this.adult,
    this.backdropPath,
    this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Movie.fromJson(String str) => Movie.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Movie.fromMap(Map<String, dynamic> json) => Movie(
    adult: json["adult"] ?? false,
    backdropPath: json["backdrop_path"],
    belongsToCollection: json["belongs_to_collection"],
    budget: json["budget"] ?? 0,
    genres: List<Genre>.from(
      (json["genres"] ?? []).map((x) => Genre.fromMap(x)),
    ),
    homepage: json["homepage"] ?? "",
    id: json["id"],
    imdbId: json["imdb_id"],
    originalLanguage: json["original_language"] ?? "",
    originalTitle: json["original_title"] ?? "",
    overview: json["overview"] ?? "",
    popularity: (json["popularity"] as num?)?.toDouble() ?? 0.0,
    posterPath: json["poster_path"],
    productionCompanies: List<ProductionCompany>.from(
      (json["production_companies"] ?? []).map(
        (x) => ProductionCompany.fromMap(x),
      ),
    ),
    productionCountries: List<ProductionCountry>.from(
      (json["production_countries"] ?? []).map(
        (x) => ProductionCountry.fromMap(x),
      ),
    ),
    releaseDate:
        DateTime.tryParse(json["release_date"] ?? "") ?? DateTime.now(),
    revenue: json["revenue"] ?? 0,
    runtime: json["runtime"],
    spokenLanguages: List<SpokenLanguage>.from(
      (json["spoken_languages"] ?? []).map((x) => SpokenLanguage.fromMap(x)),
    ),
    status: json["status"] ?? "",
    tagline: json["tagline"] ?? "",
    title: json["title"] ?? "",
    video: json["video"] ?? false,
    voteAverage: (json["vote_average"] as num?)?.toDouble() ?? 0.0,
    voteCount: json["vote_count"] ?? 0,
  );

  Map<String, dynamic> toMap() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "belongs_to_collection": belongsToCollection,
    "budget": budget,
    "genres": List<dynamic>.from(genres.map((x) => x.toMap())),
    "homepage": homepage,
    "id": id,
    "imdb_id": imdbId,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "production_companies": List<dynamic>.from(
      productionCompanies.map((x) => x.toMap()),
    ),
    "production_countries": List<dynamic>.from(
      productionCountries.map((x) => x.toMap()),
    ),
    "release_date":
        "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    "revenue": revenue,
    "runtime": runtime,
    "spoken_languages": List<dynamic>.from(
      spokenLanguages.map((x) => x.toMap()),
    ),
    "status": status,
    "tagline": tagline,
    "title": title,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}
