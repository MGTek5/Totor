import 'package:dio/dio.dart';
import 'package:totor/models/rate.dart';

const String imgbbKey = "90a78c97ebd887802c54c25e89977770";

class TotorApi {
  Dio dio = Dio();

  TotorApi() {
    dio.options.baseUrl = "https://totor.nirah.tech";
    dio.options.validateStatus = (status) => status! <= 500;
  }
  Future<dynamic> login(String email, String password) async {
    try {
      Response res = await dio
          .post("/auth/login", data: {"email": email, "password": password});
      if (res.statusCode != 200) {
        throw "Wrong response status. Got ${res.statusCode} but expected 200";
      }
      return res.data["user"];
    } on DioError catch (e) {
      throw ("Something went wrong: $e");
    }
  }

  Future<String> uploadImage(String data) async {
    try {
      Response res = await Dio().post("https://api.imgbb.com/1/upload",
          queryParameters: {"key": imgbbKey},
          data: FormData.fromMap({"image": data}));

      return res.data["data"]["url"];
    } catch (e) {
      throw "Could not upload or get image url ";
    }
  }

  Future<dynamic> register(
      String email, String password, String username, String profilePic) async {
    try {
      Response res = await dio.post("/auth/register", data: {
        "email": email,
        "password": password,
        "profilePic": profilePic,
        "username": username
      });
      if (res.statusCode != 200) {
        throw "Wrong response status, got ${res.statusCode} but expected 200";
      }
      return res.data;
    } catch (e) {
      throw ("Something went wrong: $e");
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
      throw "Something went wrong: $e";
    }
  }

  Future<List<Rate>> getReviews(String movieId) async {
    List<Rate> res = [];
    try {
      Response response = await dio.get("/movies/$movieId");
      if (response.statusCode != 200) {
        throw "Wrong responseponse status got ${response.statusCode} but expected 200";
      }
      for (var e in response.data) {
        res.add(Rate.fromJson(e));
      }
      return res;
    } catch (e) {
      return Future.error("Something went wrong: $e");
    }
  }
}

TotorApi instance = TotorApi();
