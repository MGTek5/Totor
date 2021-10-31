import 'package:flutter/material.dart';

Map<int, Color> colorsForGenres = {
  28: Colors.red,
  12: Colors.brown.shade400,
  16: Colors.purple,
  35: Colors.indigo,
  80: Colors.blue.shade300,
  99: Colors.grey.shade300,
  18: Colors.grey.shade700,
  10751: Colors.green.shade300,
  14: Colors.pink.shade700,
  36: Colors.brown.shade800,
  27: Colors.redAccent.shade700,
  10402: Colors.blueAccent.shade100,
  9648: Colors.yellow.shade800,
  10749: Colors.pink.shade700,
  878: Colors.blue.shade600,
  10770: Colors.grey,
  53: Colors.orange.shade800,
  10752: Colors.black,
  37: Colors.brown
};

class Genre {
  int id;
  String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(dynamic data) {
    return Genre(id: data["id"], name: data["name"]);
  }

  Color? getColor() {
    return colorsForGenres[id];
  }
}
