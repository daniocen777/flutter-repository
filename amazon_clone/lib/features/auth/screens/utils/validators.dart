String? validateName(String? name) {
  if (name!.isNotEmpty) {
    return null;
  } else {
    return 'Debes escribir el producto';
  }
}
