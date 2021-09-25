import 'package:totor/models/genre.dart';
import 'package:totor/models/image.dart';
import 'package:totor/models/person.dart';

class Movie {
  Movie(
      {required this.id,
      required this.title,
      required this.overview,
      required this.posterPath,
      required this.backdropPath});

  int id;
  String title;
  String overview;
  String? posterPath;
  String? backdropPath;
  String tagline = "";
  dynamic videos;
  dynamic reviews;
  dynamic crew;
  List<Cast> cast = [];
  List<Image> posters = [];
  List<Genre> genres = [];

  String getPoster({String path = "", String size = "w500"}) {
    if (path != "") {
      return "https://image.tmdb.org/t/p/$size/$path";
    }

    if (posterPath != null) {
      return "https://image.tmdb.org/t/p/$size/$posterPath";
    }
    return ("https://via.placeholder.com/500x700");
  }

  String getBackdrop({String size = "w500"}) {
    if (backdropPath != null) {
      return "https://image.tmdb.org/t/p/$size/$backdropPath";
    }
    return ("https://via.placeholder.com/500x700");
  }

  factory Movie.fromJson(Map<dynamic, dynamic> data, {bool details = false}) {
    Movie m = Movie(
        id: data["id"],
        title: data["title"],
        overview: data["overview"],
        posterPath: data["poster_path"],
        backdropPath: data["backdrop_path"]);
    if (details) {
      m.tagline = data["tagline"];
      for (var item in data["genres"]) {
        m.genres.add(Genre.fromJson(item));
      }
      if (data["images"]["posters"].isNotEmpty) {
        for (var item in data["images"]["posters"]) {
          m.posters.add(Image.fromJson(item));
        }
      }
      if (data["credits"]["cast"].isNotEmpty) {
        for (var item in data["credits"]["cast"]) {
          m.cast
              .add(Person.fromJson(data: item, type: PersonType.cast) as Cast);
        }
      }
    }
    return m;
  }
}
