import 'package:dio/dio.dart';

class Genre {
  int id;
  String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(dynamic data) {
    return Genre(id: data["id"], name: data["name"]);
  }
}

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
  dynamic images;
  dynamic videos;
  dynamic reviews;
  dynamic cast;
  dynamic crew;
  List<Genre> genres = [];

  String getPoster({String size = "w500"}) {
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
      for (var item in data["genres"]) {
        m.genres.add(Genre.fromJson(item));
      }
    }
    return m;
  }
}

class TMDB {
  TMDB({required this.apiKey}) {
    dio = Dio();
    dio.options.baseUrl = "https://api.themoviedb.org/3";
    dio.options.queryParameters = {"api_key": apiKey};
  }
  late Dio dio;
  String apiKey;

  Future<List<Movie>> getTrendingMovies({int page = 1}) async {
    try {
      Response response =
          await dio.get("/movie/popular", queryParameters: {"page": page});
      if (response.statusCode == 200) {
        dynamic data = response.data;
        List<Movie> res = [];
        for (var item in data["results"]) {
          res.add(Movie.fromJson(item));
        }
        return res;
      } else {
        return Future.error("Status KO receiving movies");
      }
    } catch (e) {
      return Future.error("Something went wrong");
    }
  }

  Future<List<Movie>> searchMovie({required String query, int page = 1}) async {
    List<Movie> res = [];
    try {
      Response response = await dio.get("/search/movie",
          queryParameters: {"query": query, "page": page});

      if (response.statusCode == 200) {
        dynamic data = response.data;
        for (var item in data["results"]) {
          res.add(Movie.fromJson(item));
        }
        return res;
      } else {
        return Future.error("Status KO searching movies");
      }
    } catch (e) {
      return Future.error("Something went wrong");
    }
  }

  Future<Movie> getMovie({required int id}) async {
    try {
      Response response = await dio.get("/movie/$id", queryParameters: {
        "append_to_response": "credits,images,reviews,recommendations,videos"
      });
      if (response.statusCode == 200) {
        return Movie.fromJson(response.data, details: true);
      } else {
        return Future.error("Request for movie $id failed");
      }
    } catch (e) {
      return Future.error("Something went wrong while retrieving movie: $e");
    }
  }
}

TMDB instance = TMDB(apiKey: "2005b3a7fc676c3bd69383469a281eff");
