import 'dart:async';

class Validators {
  final validateTitle =
      StreamTransformer<String, String>.fromHandlers(handleData: (title, sink) {
    if (title.length >= 3) {
      sink.add(title);
    } else {
      sink.addError('Debe ingresar 3 caracteres como mínimo');
    }
  });

  final validateDescription = StreamTransformer<String, String>.fromHandlers(
      handleData: (description, sink) {
    if (description.length >= 6) {
      sink.add(description);
    } else {
      sink.addError('Debe ingresar 6 caracteres como mínimo');
    }
  });
}
