import 'comics_model.dart';
import 'stories_model.dart';
import 'thumbnail_model.dart';
import 'url_model.dart';

class CharacterModel {
  final int? id;
  final String? name;
  final String? description;
  final String? modified;
  final Thumbnail? thumbnail;
  final String? resourceUri;
  final Comics? comics;
  final Comics? series;
  final Stories? stories;
  final Comics? events;
  final List<Url>? urls;

  CharacterModel({
    this.id,
    this.name,
    this.description,
    this.modified,
    this.thumbnail,
    this.resourceUri,
    this.comics,
    this.series,
    this.stories,
    this.events,
    this.urls,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        modified: json["modified"],
        thumbnail: json["thumbnail"] == null
            ? null
            : Thumbnail.fromJson(json["thumbnail"]),
        resourceUri: json["resourceURI"],
        comics: json["comics"] == null ? null : Comics.fromJson(json["comics"]),
        series: json["series"] == null ? null : Comics.fromJson(json["series"]),
        stories:
            json["stories"] == null ? null : Stories.fromJson(json["stories"]),
        events: json["events"] == null ? null : Comics.fromJson(json["events"]),
        urls: json["urls"] == null
            ? []
            : List<Url>.from(json["urls"]!.map((x) => Url.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "modified": modified,
        "thumbnail": thumbnail?.toJson(),
        "resourceURI": resourceUri,
        "comics": comics?.toJson(),
        "series": series?.toJson(),
        "stories": stories?.toJson(),
        "events": events?.toJson(),
        "urls": urls == null
            ? []
            : List<dynamic>.from(urls!.map((x) => x.toJson())),
      };
}
