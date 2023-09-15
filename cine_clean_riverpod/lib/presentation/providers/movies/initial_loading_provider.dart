import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

/* 
  Provider => Para valores inmutables (que no van a cambiar)
  StateProvider => Para mantener un estado (pendiente del cambio)
  StateNotifierProvider => Para estados más elaborados (customizado)
 */

final initialLoadingProvider = Provider<bool>((ref) {
  // Cuando haya cargando las listas
  final step1 = ref.watch(nowPlayingMoviesProvider).isEmpty;
  final step2 = ref.watch(popularMoviesProvider).isEmpty;
  final step3 = ref.watch(topRatedMoviesProvider).isEmpty;
  final step4 = ref.watch(upcomingMoviesProvider).isEmpty;
  final step5 = ref.watch(moviesSlideshowProvider).isEmpty;

  if (step1 || step5 || step4 || step2 || step3) return true;
  return false;
});
