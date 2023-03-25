import 'package:rick_morty_clean/features/rick_and_morty/domain/entities/info.dart';
import 'package:rick_morty_clean/features/rick_and_morty/domain/entities/result.dart';

class Character {
  Character({
    required this.info,
    required this.results,
  });

  Info info;
  List<Result> results;

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        info: Info.fromJson(json["info"]),
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "info": info.toJson(),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}
