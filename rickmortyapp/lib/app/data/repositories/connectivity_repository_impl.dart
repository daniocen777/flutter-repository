import 'package:connectivity_plus/connectivity_plus.dart';

import '../../domain/repositories/connectivity_repository.dart';
import '../datasources/remote/internet_checker.dart';

class ConnectivityRepositoryImpl implements ConnectivityRepository {
  ConnectivityRepositoryImpl(this._connectivity, this._internetChecker);

  final Connectivity _connectivity;
  final InternetChecker _internetChecker;

  @override
  Future<bool> get hasInternet async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return _internetChecker.hasInternet();
  }
}
