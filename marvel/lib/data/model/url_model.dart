import '../../core/util/enums_type.dart';

class Url {
  final UrlType? type;
  final String? url;

  Url({
    this.type,
    this.url,
  });

  factory Url.fromJson(Map<String, dynamic> json) => Url(
        type: urlTypeValues.map[json["type"]]!,
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "type": urlTypeValues.reverse[type],
        "url": url,
      };
}

enum UrlType { COMICLINK, DETAIL, WIKI }

final urlTypeValues = EnumValues({
  "comiclink": UrlType.COMICLINK,
  "detail": UrlType.DETAIL,
  "wiki": UrlType.WIKI
});
