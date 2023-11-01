// To parse this JSON data, do
//
//     final articleResponse = articleResponseFromJson(jsonString);

import 'article_model.dart';

class ArticleResponse {
  final String? status;
  final int? totalResults;
  final List<ArticleModel>? articles;

  ArticleResponse({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory ArticleResponse.fromJson(Map<String, dynamic> json) =>
      ArticleResponse(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: json["articles"] == null
            ? []
            : List<ArticleModel>.from(
                json["articles"]!.map((x) => ArticleModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": articles == null
            ? []
            : List<dynamic>.from(articles!.map((x) => x.toJson())),
      };
}
