import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ShowItem {
  bool adult;
  String backdropPath;
  int id;
  String name;
  String originalName;
  String overview;
  String posterPath;
  String mediaType;
  String originalLanguage;
  List<int> genreIds;
  double popularity;
  String firstAirDate;
  double voteAverage;
  int voteCount;
  List<String> originCountry;
  ShowItem({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.name,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.originalLanguage,
    required this.genreIds,
    required this.popularity,
    required this.firstAirDate,
    required this.voteAverage,
    required this.voteCount,
    required this.originCountry,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'adult': adult,
      'backdropPath': backdropPath,
      'id': id,
      'name': name,
      'originalName': originalName,
      'overview': overview,
      'posterPath': posterPath,
      'mediaType': mediaType,
      'originalLanguage': originalLanguage,
      'genreIds': genreIds,
      'popularity': popularity,
      'firstAirDate': firstAirDate,
      'voteAverage': voteAverage,
      'voteCount': voteCount,
      'originCountry': originCountry,
    };
  }

  factory ShowItem.fromMap(Map<String, dynamic> map) {
    return ShowItem(
      adult: map['adult'] as bool,
      backdropPath: map['backdropPath'] as String,
      id: map['id'] as int,
      name: map['name'] as String,
      originalName: map['originalName'] as String,
      overview: map['overview'] as String,
      posterPath: map['posterPath'] as String,
      mediaType: map['mediaType'] as String,
      originalLanguage: map['originalLanguage'] as String,
      genreIds: List<int>.from(map['genreIds'] as List<int>),
      popularity: map['popularity'] as double,
      firstAirDate: map['firstAirDate'] as String,
      voteAverage: map['voteAverage'] as double,
      voteCount: map['voteCount'] as int,
      originCountry: List<String>.from(map['originCountry'] as List<String>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ShowItem.fromJson(String source) =>
      ShowItem.fromMap(json.decode(source) as Map<String, dynamic>);
}
