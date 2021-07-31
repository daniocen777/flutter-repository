import 'dart:convert';

ApiResponse apiResponseFromJson(String str) =>
    ApiResponse.fromJson(json.decode(str));

String apiResponseToJson(ApiResponse data) => json.encode(data.toJson());

class ApiResponse {
  ApiResponse({
    this.success,
    this.timestamp,
    this.symbols,
    this.base,
    this.rates,
    this.error,
  });

  bool? success;
  int? timestamp;
  Map<String, dynamic>? symbols;
  String? base;
  Map<String, dynamic>? rates;
  Error? error;

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        success: json["success"] == null ? null : json["success"],
        timestamp: json["timestamp"] == null ? null : json["timestamp"],
        symbols: json["symbols"] == null ? null : json["symbols"],
        base: json["base"] == null ? null : json["base"],
        rates: json["rates"] == null ? null : json["rates"],
        error: json["error"] == null ? null : Error.fromJson(json["error"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "timestamp": timestamp == null ? null : timestamp,
        "symbols": rates == null ? null : {"NN": "No Rates"},
        "base": base == null ? null : base,
        "rates": rates == null ? null : {"NN": "No Symbol"},
        "error": error == null ? null : error!.toJson(),
      };
}

class Error {
  Error({
    this.code,
  });

  int? code;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        code: json["code"] == null ? null : json["code"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
      };
}
