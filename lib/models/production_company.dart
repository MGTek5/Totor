class ProductionCompany {
  String _name;
  String? _logoPath;
  int _id;
  String? _originCountry;

  ProductionCompany(
      {required String name,
      required String? logoPath,
      required int id,
      required String? originCountry})
      : _id = id,
        _logoPath = logoPath,
        _name = name,
        _originCountry = originCountry;

  get id => _id;
  get name => _name;
  get originCountry => _originCountry;

  String getLogo({String size = "w500"}) {
    if (_logoPath != null) {
      return "https://image.tmdb.org/t/p/$size/$_logoPath";
    }
    return ("https://via.placeholder.com/500x700");
  }

  factory ProductionCompany.fromJson(dynamic data) {
    return ProductionCompany(
        name: data["name"],
        logoPath: data["logo_path"],
        id: data["id"],
        originCountry: data["originCountry"]);
  }
}
