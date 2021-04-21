part of 'product_bloc.dart';

class ProductState extends Equatable {
  final List<Product> products;

  ProductState({required this.products});

  static initialState() => ProductState(products: []);

  ProductState copyWith({List<Product>? products}) {
    return ProductState(products: products ?? this.products);
  }

  @override
  List<Object> get props => [products];
}
