import 'package:flutter/widgets.dart';
import 'package:tip_calculator/pages/tip_page.dart';
import 'package:tip_calculator/routes/routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes =>
    {Routes.tip: (_) => const TipPage()};
