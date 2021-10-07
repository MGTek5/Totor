import 'package:totor/models/movie.dart';

enum PersonType { cast, crew }

class Person {
  int id;
  String name;
  String? originalName;
  String department;
  String? profilePath;
  String? biography;
  String? placeOfBirth;
  List<Movie> movieCredits = [];

  String getProfilePic({String size = "w500"}) {
    if (profilePath != null) {
      return "https://image.tmdb.org/t/p/$size/$profilePath";
    }
    return ("https://via.placeholder.com/500x700");
  }

  Person(
      {required this.id,
      required this.name,
      required this.originalName,
      required this.department,
      required this.profilePath});

  factory Person.fromJson(
      {required dynamic data, required PersonType type, bool details = false}) {
    Cast c = Cast(
        id: data["id"],
        character: data["character"],
        name: data["name"],
        originalName: data["original_name"],
        department: data["known_for_department"],
        profilePath: data["profile_path"]);

    if (details) {
      c.biography = data["biography"];
      c.placeOfBirth = data["place_of_birth"];
      for (var m in data["movie_credits"]["cast"]) {
        c.movieCredits.add(Movie.fromJson(m));
      }
    }

    return c;
  }
}

class Cast extends Person {
  String? character;

  Cast(
      {required id,
      required name,
      required originalName,
      required department,
      required profilePath,
      required this.character})
      : super(
            id: id,
            name: name,
            originalName: originalName,
            department: department,
            profilePath: profilePath);
}
