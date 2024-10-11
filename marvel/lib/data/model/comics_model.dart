import 'comic_item_model.dart';

class Comics {
  final int? available;
  final String? collectionUri;
  final List<ComicsItem>? items;
  final int? returned;

  Comics({
    this.available,
    this.collectionUri,
    this.items,
    this.returned,
  });

  factory Comics.fromJson(Map<String, dynamic> json) => Comics(
        available: json["available"],
        collectionUri: json["collectionURI"],
        items: json["items"] == null
            ? []
            : List<ComicsItem>.from(
                json["items"]!.map((x) => ComicsItem.fromJson(x))),
        returned: json["returned"],
      );

  Map<String, dynamic> toJson() => {
        "available": available,
        "collectionURI": collectionUri,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "returned": returned,
      };
}
