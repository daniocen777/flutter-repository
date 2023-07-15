
import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../http/http.dart';

class AuthenticationApi {
  AuthenticationApi(this._http);
  final Http _http;

  // Manejar errores
  Either<SignInFailure, String> _handleFailure(HttpFailure failure) {
    if (failure.statusCode != null) {
      switch (failure.statusCode!) {
        case 401:
          return Either.left(SignInFailure.unauthorized);

        case 404:
          return Either.left(SignInFailure.notFound);
        default:
          return Either.left(SignInFailure.unknown);
      }
    }
    if (failure.exception is NetworkException) {
      return Either.left(SignInFailure.network);
    }
    return Either.left(SignInFailure.unknown);
  }

  Future<Either<SignInFailure, String>> createRequestToken() async {
    // La clase ya hace el trabajo de colocar url base y queryParams
    final result = await _http.request('/authentication/token/new',
        onSuccess: (responseBody) {
      // response.body => respuesta en String
      final json = responseBody as Map;
      return json['request_token'] as String;
    });

    return result.when(
      (failure) => _handleFailure(failure),
      (requestToken) => Either.right(requestToken),
    );
  }

  Future<Either<SignInFailure, String>> createSessionWithLogin(
      {required String username,
      required String password,
      required String requestToken}) async {
    final result = await _http.request(
        '/authentication/token/validate_with_login',
        method: HttpMethod.post,
        body: {
          'username': username,
          'password': password,
          'request_token': requestToken
        }, onSuccess: (responseBody) {
      // response.body => respuesta en String
      final json = responseBody as Map;
      return json['request_token'] as String;
    });

    return result.when((failure) => _handleFailure(failure),
        (newRequestToken) => Either.right(newRequestToken));
  }

  Future<Either<SignInFailure, String>> createSession(
      String requestToken) async {
    final result = await _http.request('/authentication/session/new',
        method: HttpMethod.post,
        body: {'request_token': requestToken}, onSuccess: (responseBody) {
      final json = responseBody as Map;
      return json['session_id'] as String;
    });

    return result.when((failure) => _handleFailure(failure),
        (sessionId) => Either.right(sessionId));
  }
}
