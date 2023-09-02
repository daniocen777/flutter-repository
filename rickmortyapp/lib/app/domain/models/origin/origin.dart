import 'package:freezed_annotation/freezed_annotation.dart';

import '../typedefs.dart';

part 'origin.freezed.dart';
part 'origin.g.dart';

@freezed
class Origin with _$Origin {
  factory Origin({
    required String name,
    String? url,
  }) = _Origin;

  factory Origin.fromJson(Json json) => _$OriginFromJson(json);
}
