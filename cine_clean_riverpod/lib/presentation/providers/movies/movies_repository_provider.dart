import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infrastructure/datasources/remote/moviedb_datasource.dart';
import '../../../infrastructure/repositories/remote/movie_repository_impl.dart';
/* 
  Provider => Para valores inmutables (que no van a cambiar)
  StateProvider => Para mantener un estado (pendiente del cambio)
  StateNotifierProvider => Para estados más elaborados (customizado)
 */

// Provider riverpod de lectura (Solo para crear ina instancia)
final movieRepositoryProvider =
    Provider((ref) => MovieRepositoryImpl(MovieDBDatasource()));
