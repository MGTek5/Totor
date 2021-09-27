enum VideoSite { youtube, vimeo }
enum VideoType { featurette, trailer, bloopers, undefined }

VideoType getType(String t) {
  switch (t) {
    case "Featurette":
      return VideoType.featurette;
    case "Trailer":
      return VideoType.trailer;
    default:
      return VideoType.undefined;
  }
}

class Video {
  VideoSite site;
  String key;
  VideoType type;
  String id;
  bool official;

  Video(
      {required this.site,
      required this.key,
      required this.type,
      required this.id,
      required this.official});

  factory Video.fromJson(dynamic data) {
    if (data["site"] == "YouTube") {
      return Video(
          site: VideoSite.youtube,
          key: data["key"],
          type: getType(data["type"]),
          id: data["id"],
          official: data["official"]);
    }

    throw "Could not find Video with id ${data["id"]}";
  }
}
