import 'dart:convert';

PlayList playListFromJson(String str) => PlayList.fromJson(json.decode(str));

class PlayList {
  PlayList({
    this.id,
    this.title,
    this.description,
    this.banner,
    this.publishedAt,
    this.itemCount,
  });

  String id;
  String title;
  String description;
  String banner;
  DateTime publishedAt;
  int itemCount;

  factory PlayList.fromJson(Map<String, dynamic> json) {
    final snippet = json["snippet"];
    final thumbnails =
        snippet["thumbnails"]["standard"] ?? snippet["thumbnails"]["high"];

    return PlayList(
      id: json["id"],
      title: snippet["title"],
      description: snippet["description"],
      banner: thumbnails["url"],
      publishedAt: DateTime.parse(snippet["publishedAt"]),
      itemCount: json["contentDetails"]["itemCount"],
    );
  }
}
