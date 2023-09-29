import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infrastructure/datasources/news_datasource.dart';
import '../../../infrastructure/repositories/news_repository_impl.dart';

/* 
  Provider => Para valores inmutables (que no van a cambiar)
  StateProvider => Para mantener un estado (pendiente del cambio)
  StateNotifierProvider => Para estados más elaborados (customizado)
 */

final newsRepositoryProvider =
    Provider((ref) => NewsRepositoryImpl(NewsAPIDatasource()));
