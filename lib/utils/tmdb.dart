import 'package:dio/dio.dart';
import 'package:totor/models/movie.dart';
import 'package:totor/models/person.dart';

class TMDB {
  TMDB({required this.apiKey}) {
    dio = Dio();
    dio.options.baseUrl = "https://api.themoviedb.org/3";
    dio.options.queryParameters = {"api_key": apiKey};
    dio.options.validateStatus = (status) => status! <= 500;
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
        throw "Status KO receiving movies";
      }
    } catch (e) {
      throw "Something went wrong";
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
        throw "Status KO searching movies";
      }
    } catch (e) {
      throw "Something went wrong";
    }
  }

  Future<Movie> getMovie({required int id}) async {
    try {
      Response response = await dio.get("/movie/$id", queryParameters: {
        "append_to_response": "credits,images,reviews,recommendations,videos",
        "include_image_language": "en,null"
      });
      if (response.statusCode == 200) {
        return Movie.fromJson(response.data, details: true);
      } else {
        throw "Request for movie $id failed";
      }
    } catch (e) {
      throw "Something went wrong while retrieving movie: $e";
    }
  }

  Future<List<Movie>> getMoviesWithGenre(
      {required int id, int page = 1}) async {
    try {
      List<Movie> res = [];
      Response response = await dio.get("/discover/movie",
          queryParameters: {"with_genres": "$id", "page": page});

      if (response.statusCode == 200) {
        dynamic data = response.data;
        for (var item in data["results"]) {
          res.add(Movie.fromJson(item));
        }
        return res;
      } else {
        throw "Status KO searching movies";
      }
    } catch (e) {
      throw "Could not discover movies with specified genre";
    }
  }

  Future<Person> getPerson({required int id}) async {
    try {
      Response response = await dio.get("/person/$id",
          queryParameters: {"append_to_response": "movie_credits"});
      if (response.statusCode == 200) {
        return Person.fromJson(
            data: response.data,
            type: response.data["known_for_department"] == "Acting"
                ? PersonType.cast
                : PersonType.crew,
            details: true);
      } else {
        return Future.error("Request for person $id failed");
      }
    } catch (e) {
      return Future.error("Something went wrong while retrieving person: $e");
    }
  }
}

TMDB instance = TMDB(apiKey: "2005b3a7fc676c3bd69383469a281eff");
