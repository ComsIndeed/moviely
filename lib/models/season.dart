import 'package:moviely/models/episode.dart';

class Season {
  final DateTime? airDate;
  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;
  final double voteAverage;
  final List<Episode> episodes; // <-- NEW FIELD

  Season({
    this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
    this.episodes = const [], // Default to an empty list
  });

  factory Season.fromMap(Map<String, dynamic> json) => Season(
    airDate: DateTime.tryParse(json["air_date"] ?? ""),
    episodeCount: json["episode_count"] ?? 0,
    id: json["id"],
    name: json["name"] ?? "",
    overview: json["overview"] ?? "",
    posterPath: json["poster_path"],
    seasonNumber: json["season_number"],
    voteAverage: (json["vote_average"] as num?)?.toDouble() ?? 0.0,
    // If the 'episodes' key exists (from the season detail call), parse it.
    episodes: List<Episode>.from(
      (json["episodes"] ?? []).map((x) => Episode.fromMap(x)),
    ),
  );

  // copyWith is essential for updating the season with its fetched episodes.
  Season copyWith({List<Episode>? episodes}) {
    return Season(
      airDate: airDate,
      episodeCount: episodeCount,
      id: id,
      name: name,
      overview: overview,
      posterPath: posterPath,
      seasonNumber: seasonNumber,
      voteAverage: voteAverage,
      episodes: episodes ?? this.episodes, // Use the new episodes list
    );
  }
}

// NOTE: All other helper models like Episode, Network, Genre, etc.
// should be included in this file or imported. I've omitted them here
// to focus on the changes, but you'll need them for this code to run.
