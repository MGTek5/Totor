class Image {
  String _filePath;
  int _height;
  int _width;

  Image({required String filePath, required int height, required int width})
      : _filePath = filePath,
        _height = height,
        _width = width;

  get filePath => _filePath;
  get height => _height;
  get width => _width;

  factory Image.fromJson(dynamic data) {
    return Image(
        filePath: data["file_path"],
        height: data["height"],
        width: data["width"]);
  }
}
