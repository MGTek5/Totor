class ProductionCompany {
  String name;
  String? logoPath;
  int id;
  String? originCountry;

  ProductionCompany(
      {required this.name,
      required this.logoPath,
      required this.id,
      required this.originCountry});

  String getLogo({String size = "w500"}) {
    if (logoPath != null) {
      return "https://image.tmdb.org/t/p/$size/$logoPath";
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
