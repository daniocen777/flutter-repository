import 'dart:convert';

YouTubeVideo youTubeVideoFromJson(String str) =>
    YouTubeVideo.fromJson(json.decode(str));

class YouTubeVideo {
  YouTubeVideo({
    this.videoId,
    this.title,
    this.description,
    this.banner,
  });

  String videoId;
  String title;
  String description;
  String banner;

  factory YouTubeVideo.fromJson(Map<String, dynamic> json,
      {bool fromPlayList = false}) {
    final snippet = json["snippet"];
    final thumbnails =
        snippet["thumbnails"]["standard"] ?? snippet["thumbnails"]["high"];
    String videoId;

    if (!fromPlayList) {
      videoId = json["contentDetails"]["upload"]["videoId"];
    } else {
      videoId = snippet["resourceId"]["videoId"];
    }

    return YouTubeVideo(
      videoId: videoId,
      title: snippet["title"],
      description: snippet["description"],
      banner: thumbnails["url"],
    );
  }
}
