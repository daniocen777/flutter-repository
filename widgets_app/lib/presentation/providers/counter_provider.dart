import 'package:flutter_riverpod/flutter_riverpod.dart';

// Pieza de info del estado de nuestra app (5 => estado inicial)
final counterProvider = StateProvider((ref) => 5);