import '../../domain/models/user/user.dart';
import '../../domain/repositories/account_repository.dart';
import '../services/local/session_service.dart';
import '../services/remote/account_api.dart';

class AccountRepositoryImpl implements AccountRepository {
  AccountRepositoryImpl(this._accountApi, this._sessionService);

  final AccountApi _accountApi;
  final SessionService _sessionService;

  @override
  Future<User?> getUserData() async {
    final sessionId = await _sessionService.sessionId;
    return _accountApi.getAccount(sessionId ?? '');
  }
}
