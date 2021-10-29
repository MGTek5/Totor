import 'package:totor/models/genre.dart';

class MovieDetailsArguments {
  final int id;

  MovieDetailsArguments(this.id);
}

class ImageFullArguments {
  final String path;

  ImageFullArguments(this.path);
}

class CastDetailArguments {
  final int id;

  CastDetailArguments(this.id);
}

class CompanyDetailArguments {
  final int id;

  CompanyDetailArguments(this.id);
}

class GenreDiscoveryArguments {
  final Genre genre;

  GenreDiscoveryArguments(this.genre);
}
