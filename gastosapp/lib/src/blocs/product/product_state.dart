part of 'product_bloc.dart';

class ProductState extends Equatable {
  final List<Product> products;
  final bool? loading;

  ProductState({required this.products, this.loading});

  static initialState() => ProductState(products: [], loading: false);

  ProductState copyWith({List<Product>? products, bool? loading}) {
    return ProductState(
      products: products ?? this.products,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object> get props => [products, loading!];
}
