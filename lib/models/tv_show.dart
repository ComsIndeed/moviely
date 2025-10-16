import 'dart:convert';
import 'package:moviely/models/episode.dart';
import 'package:moviely/models/genre.dart';
import 'package:moviely/models/network.dart';
import 'package:moviely/models/production_company.dart';
import 'package:moviely/models/production_country.dart';
import 'package:moviely/models/season.dart';
import 'package:moviely/models/show_item.dart';
import 'package:moviely/models/spoken_language.dart';

class TvShow {
  final bool adult;
  final String? backdropPath;
  final List<dynamic> createdBy; // Typically a list of maps
  final List<int> episodeRunTime;
  final DateTime? firstAirDate;
  final List<Genre> genres;
  final String homepage;
  final int id;
  final bool inProduction;
  final List<String> languages;
  final DateTime? lastAirDate;
  final Episode? lastEpisodeToAir;
  final String name;
  final List<Network> networks;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final List<Season> seasons;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;

  TvShow({
    required this.adult,
    this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    this.lastAirDate,
    this.lastEpisodeToAir,
    required this.name,
    required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.seasons,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TvShow.fromJson(String str) => TvShow.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TvShow.fromMap(Map<String, dynamic> json) => TvShow(
    adult: json["adult"] ?? false,
    backdropPath: json["backdrop_path"],
    createdBy: List<dynamic>.from((json["created_by"] ?? []).map((x) => x)),
    episodeRunTime: List<int>.from(
      (json["episode_run_time"] ?? []).map((x) => x),
    ),
    firstAirDate: DateTime.tryParse(json["first_air_date"] ?? ""),
    genres: List<Genre>.from(
      (json["genres"] ?? []).map((x) => Genre.fromMap(x)),
    ),
    homepage: json["homepage"] ?? "",
    id: json["id"],
    inProduction: json["in_production"] ?? false,
    languages: List<String>.from((json["languages"] ?? []).map((x) => x)),
    lastAirDate: DateTime.tryParse(json["last_air_date"] ?? ""),
    lastEpisodeToAir: json["last_episode_to_air"] == null
        ? null
        : Episode.fromMap(json["last_episode_to_air"]),
    name: json["name"] ?? "",
    networks: List<Network>.from(
      (json["networks"] ?? []).map((x) => Network.fromMap(x)),
    ),
    numberOfEpisodes: json["number_of_ episodes"] ?? 0,
    numberOfSeasons: json["number_of_seasons"] ?? 0,
    originCountry: List<String>.from(
      (json["origin_country"] ?? []).map((x) => x),
    ),
    originalLanguage: json["original_language"] ?? "",
    originalName: json["original_name"] ?? "",
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
    seasons: List<Season>.from(
      (json["seasons"] ?? []).map((x) => Season.fromMap(x)),
    ),
    spokenLanguages: List<SpokenLanguage>.from(
      (json["spoken_languages"] ?? []).map((x) => SpokenLanguage.fromMap(x)),
    ),
    status: json["status"] ?? "",
    tagline: json["tagline"] ?? "",
    type: json["type"] ?? "",
    voteAverage: (json["vote_average"] as num?)?.toDouble() ?? 0.0,
    voteCount: json["vote_count"] ?? 0,
  );

  Map<String, dynamic> toMap() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "created_by": List<dynamic>.from(createdBy.map((x) => x)),
    "episode_run_time": List<dynamic>.from(episodeRunTime.map((x) => x)),
    "first_air_date": firstAirDate?.toIso8601String(),
    "genres": List<dynamic>.from(genres.map((x) => x.toMap())),
    "homepage": homepage,
    "id": id,
    "in_production": inProduction,
    "languages": List<dynamic>.from(languages.map((x) => x)),
    "last_air_date": lastAirDate?.toIso8601String(),
    "last_episode_to_air": lastEpisodeToAir?.toMap(),
    "name": name,
    "networks": List<dynamic>.from(networks.map((x) => x.toMap())),
    "number_of_episodes": numberOfEpisodes,
    "number_of_seasons": numberOfSeasons,
    "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
    "original_language": originalLanguage,
    "original_name": originalName,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "production_companies": List<dynamic>.from(
      productionCompanies.map((x) => x.toMap()),
    ),
    "production_countries": List<dynamic>.from(
      productionCountries.map((x) => x.toMap()),
    ),
    "seasons": List<dynamic>.from(seasons.map((x) => x.toMap())),
    "spoken_languages": List<dynamic>.from(
      spokenLanguages.map((x) => x.toMap()),
    ),
    "status": status,
    "tagline": tagline,
    "type": type,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}
