class ProductionCountry {
  String _iso;
  String _name;

  get iso => _iso;
  get name => _name;
  ProductionCountry({required String iso, required String name})
      : _iso = iso,
        _name = name;

  factory ProductionCountry.fromJson(dynamic data) {
    return ProductionCountry(iso: data["iso_3166_1"], name: data["name"]);
  }
}
