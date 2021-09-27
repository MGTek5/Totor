class Genre {
  int id;
  String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(dynamic data) {
    return Genre(id: data["id"], name: data["name"]);
  }
}
