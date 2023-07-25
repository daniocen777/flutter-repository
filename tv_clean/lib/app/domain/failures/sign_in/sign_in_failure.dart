// Freezed para programación funcional

import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_failure.freezed.dart';

@freezed
class SignInFailure with _$SignInFailure {
  // Generar clases que extiendan de SignInFailure
  factory SignInFailure.network() = SignInFailureNetwork;
  factory SignInFailure.notVerified() = SignInFailureNotVerified;
  factory SignInFailure.notFound() = SignInFailureNotFound;
  factory SignInFailure.unauthorized() = SignInFailureUnauthorized;
  factory SignInFailure.unknown() = SignInFailureUnknown;
}

/* class Network extends SignInFailure {}

class NotFound extends SignInFailure {}

class Unauthorized extends SignInFailure {}

class Unknown extends SignInFailure {} */
