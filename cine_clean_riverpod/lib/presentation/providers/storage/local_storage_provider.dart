import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infrastructure/datasources/local/movie_local_storage_datasource.dart';
import '../../../infrastructure/repositories/local/movie_local_storage_repository_impl.dart';

final localStorageRepositoryProvider = Provider((ref) {
  return MovieLocalStorageRepositoryImpl(
      datasource: MovieLocalStorageDatasource());
});
