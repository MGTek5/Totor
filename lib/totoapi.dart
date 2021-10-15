import 'package:dio/dio.dart';

class TotorApi {
  Dio dio = Dio();

  TotorApi() {
    dio.options.baseUrl = "https://totor.nirah.tech";
  }
  Future<dynamic> login(String email, String password) async {
    try {
      Response res = await dio
          .post("/auth/login", data: {"email": email, "password": password});
      if (res.statusCode != 200) {
        throw "Wrong response status. Got ${res.statusCode} but expected 200";
      }
      return res.data["user"];
    } catch (e) {
      return Future.error("Something went wrong: $e");
    }
  }

  Future<dynamic> register(
      String email, String password, String username, String profilePic) async {
    try {
      Response res = await dio.post("/auth/register", data: {
        "email": email,
        "password": password,
        "profilePic": profilePic
      });
      if (res.statusCode != 200) {
        throw "Wrong response status, got ${res.statusCode} but expected 200";
      }
      return res.data;
    } catch (e) {
      return Future.error("Something went wrong: $e");
    }
  }

  Future<dynamic> createReview(
      String movieId, String userId, double rating, String commentary) async {
    try {
      Response res = await dio.post("/movies", data: {
        "movieId": movieId,
        "userId": userId,
        "rating": rating,
        "commentary": commentary
      });
      if (res.statusCode != 200) {
        throw "Wrong response status got ${res.statusCode} but expected 200";
      }
      return res.data;
    } catch (e) {
      return Future.error("Something went wrong: $e");
    }
  }

  Future<dynamic> getReviews(String movieId) async {
    try {
      Response res = await dio.get("/movies/$movieId");
      if (res.statusCode != 200) {
        throw "Wrong response status got ${res.statusCode} but expected 200";
      }
      return res.data;
    } catch (e) {
      return Future.error("Something went wrong: $e");
    }
  }
}

TotorApi instance = TotorApi();
