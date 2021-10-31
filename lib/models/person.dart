import 'package:totor/models/movie.dart';

class Cast {
  int _id;
  String _name;
  String? _originalName;
  String _department;
  String? _profilePath;
  String? _biography;
  final List<Movie> _movieCredits = [];
  String? _character;

  get id => _id;
  get name => _name;
  get originaName => _originalName;
  get department => _department;
  get profilePath => _profilePath;
  get biography => _biography;
  get movieCredits => _movieCredits;
  get character => _character;

  Cast(
      {required int id,
      required String name,
      required String? originalName,
      required String department,
      required String? profilePath,
      required String? character})
      : _id = id,
        _name = name,
        _originalName = originalName,
        _department = department,
        _profilePath = profilePath,
        _character = character;

  String getProfilePic({String size = "w500"}) {
    if (_profilePath != null) {
      return "https://image.tmdb.org/t/p/$size/$_profilePath";
    }
    return ("https://via.placeholder.com/500x700");
  }

  factory Cast.fromJson({required dynamic data, bool details = false}) {
    Cast c = Cast(
        id: data["id"],
        character: data["character"],
        name: data["name"],
        originalName: data["original_name"],
        department: data["known_for_department"],
        profilePath: data["profile_path"]);

    if (details) {
      c._biography = data["biography"];
      for (Map<String, dynamic> m in data["movie_credits"]["cast"]) {
        c._movieCredits.add(Movie.fromJson(m));
      }
    }

    return c;
  }
}
