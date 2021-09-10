import 'package:http/http.dart' as http;

class Movie {
  Movie(
      {required this.id,
      required this.title,
      required this.posterPath,
      required this.backdropPath});

  int id;
  String title;
  String? overview;
  String posterPath;
  String backdropPath;

  factory Movie.fromJson(Map<dynamic, dynamic> data) {
    return Movie(
        id: data["id"],
        title: data["title"],
        posterPath: data["poster_path"],
        backdropPath: data["backdrop_path"]);
  }
}

class TMDB {
  TMDB({required this.apiKey}) {
    base = Uri.parse("https://api.themoviedb.org/3");
    base.replace(queryParameters: {"api_key":apiKey});
  };
  String apiKey;
  late Uri base;

  Future<List<Movie>> getTrendingMovies() async {
    var response = await http.get();
  }
}
