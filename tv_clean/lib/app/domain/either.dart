class Either<Left, Right> {
  final Left? _left;
  final Right? _right;
  final bool isLeft;

  // Constrictor privado (usar los factory)
  Either._(this._left, this._right, this.isLeft);

  // Factory papra crear las instancias según sea el caso
  factory Either.left(Left failure) {
    return Either._(failure, null, true);
  }

  factory Either.right(Right value) {
    return Either._(null, value, false);
  }

  // Función para reemplazar el switch
  T when<T>(T Function(Left) left, T Function(Right) right) {
    if (isLeft) {
      return left(_left as Left);
    } else {
      return right(_right as Right);
    }
  }
}
