import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gastosapp/src/models/product.dart';
import 'package:gastosapp/src/services/product_service.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final _productService = ProductService();

  ProductBloc() : super(ProductState.initialState()) {
    add(GetListEvent());
  }

  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    if (event is GetListEvent) {
      yield* _getList(event);
    }
  }

  Stream<ProductState> _getList(GetListEvent event) async* {
    final List<Product> productsList = await this._productService.getProducts();
    yield this.state.copyWith(products: productsList);
  }
}
