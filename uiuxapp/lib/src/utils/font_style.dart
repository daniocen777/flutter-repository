import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class FontStyle {
  static final textTheme = GoogleFonts.nunitoTextTheme();

  static final title =
      GoogleFonts.roboto(fontSize: 16.0, fontWeight: FontWeight.w500);

  static final regular =
      GoogleFonts.nunito(fontSize: 16.0, fontWeight: FontWeight.w600);

  static final normal = GoogleFonts.nunito(fontWeight: FontWeight.w300);
}
