import 'package:flutter/services.dart';

class CapitalizeInputFormater extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Primaera letra siempre en mayúscula
    // remover espacieos en blanco al inicio y final
    final text = newValue.text.trim();
    if (text.isEmpty) {
      return newValue;
    }
    // convertir a mayúscula
    final newText = '${text[0].toUpperCase()}${text.substring(1, text.length)}';
    return newValue.copyWith(
      text: newText,
      composing: TextRange(
          start: 0, end: newText.length), // evita error de tamaño anterior
      selection: TextSelection(
          baseOffset: newText.length, extentOffset: newText.length), // cursor al final
    );
  }
}
