class Episode {
  final int id;
  final String name;
  final String overview;
  final double voteAverage;
  final int voteCount;
  final DateTime? airDate;
  final int episodeNumber;
  final String productionCode;
  final int? runtime;
  final int seasonNumber;
  final int showId;
  final String? stillPath;

  Episode({
    required this.id,
    required this.name,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
    this.airDate,
    required this.episodeNumber,
    required this.productionCode,
    this.runtime,
    required this.seasonNumber,
    required this.showId,
    this.stillPath,
  });

  factory Episode.fromMap(Map<String, dynamic> json) => Episode(
    id: json["id"],
    name: json["name"],
    overview: json["overview"],
    voteAverage: (json["vote_average"] as num?)?.toDouble() ?? 0.0,
    voteCount: json["vote_count"],
    airDate: DateTime.tryParse(json["air_date"] ?? ""),
    episodeNumber: json["episode_number"],
    productionCode: json["production_code"],
    runtime: json["runtime"],
    seasonNumber: json["season_number"],
    showId: json["show_id"],
    stillPath: json["still_path"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "overview": overview,
    "vote_average": voteAverage,
    "vote_count": voteCount,
    "air_date": airDate?.toIso8601String(),
    "episode_number": episodeNumber,
    "production_code": productionCode,
    "runtime": runtime,
    "season_number": seasonNumber,
    "show_id": showId,
    "still_path": stillPath,
  };
}
