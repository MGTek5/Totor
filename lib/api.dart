import 'dart:convert';
import 'package:dio/dio.dart';

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
  String posterPath;
  String backdropPath;

  factory Movie.fromJson(Map<dynamic, dynamic> data) {
    return Movie(
        id: data["id"],
        title: data["title"],
        overview: data["overview"],
        posterPath: data["poster_path"],
        backdropPath: data["backdrop_path"]);
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

  Future<List<Movie>> getTrendingMovies() async {
    try {
      Response response = await dio.get("/movie/popular");
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
}

TMDB instance = TMDB(apiKey: "2005b3a7fc676c3bd69383469a281eff");
