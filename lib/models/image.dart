class Image {
  String filePath;
  int height;
  int width;

  Image({required this.filePath, required this.height, required this.width});

  factory Image.fromJson(dynamic data) {
    return Image(
        filePath: data["file_path"],
        height: data["height"],
        width: data["width"]);
  }
}
