import 'package:dio/dio.dart';

class TotorApi {
  Dio dio = Dio();

  TotorApi() {
    dio.options.baseUrl = "https://totor.nirah.tech";
  }
  Future<dynamic> login(String email, String password) async {
    try {
      Response res = await dio.post("/auth/login", data: {email, password});
      if (res.statusCode != 200) {
        throw "Wrong response status. Got ${res.statusCode} but expected 200";
      }
      return res.data["user"];
    } catch (e) {
      return Future.error("Something went wrong: $e");
    }
  }
}

TotorApi instance = TotorApi();
