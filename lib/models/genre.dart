class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromMap(Map<String, dynamic> json) =>
      Genre(id: json["id"], name: json["name"]);

  Map<String, dynamic> toMap() => {"id": id, "name": name};
}
