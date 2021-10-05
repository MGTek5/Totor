import 'package:dio/dio.dart';
import 'package:totor/models/movie.dart';

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
        "append_to_response": "credits,images,reviews,recommendations,videos",
        "include_image_language": "en,null"
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
