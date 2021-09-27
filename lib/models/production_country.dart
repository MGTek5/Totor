class ProductionCountry {
  String iso;
  String name;

  ProductionCountry({required this.iso, required this.name});

  factory ProductionCountry.fromJson(dynamic data) {
    return ProductionCountry(iso: data["iso_3166_1"], name: data["name"]);
  }
}
