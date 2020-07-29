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

  factory YouTubeVideo.fromJson(Map<String, dynamic> json) {
    final snippet = json["snippet"];
    final thumbnails =
        snippet["thumbnails"]["standard"] ?? snippet["thumbnails"]["high"];

    return YouTubeVideo(
      videoId: json["contentDetails"]["upload"]["videoId"],
      title: snippet["title"],
      description: snippet["description"],
      banner: thumbnails["url"],
    );
  }
}
