import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    if (event is AddProductEvent) {
      yield* _addProductEvent(event);
    }
  }

  Stream<ProductState> _getList(GetListEvent event) async* {
    final List<Product> productsList = await this._productService.getProducts();
    yield this.state.copyWith(products: productsList);
  }

  Stream<ProductState> _addProductEvent(AddProductEvent event) async* {
    yield state.copyWith(loading: true);
    Future.delayed(const Duration(milliseconds: 2000));
    await _productService.addProduct(event.product!);
    /* final index =
        state.products.indexWhere((item) => item.name == event.product!.name);
    if (index == -1) {
      final List<Product> listProducts =
          List<Product>.from(this.state.products);
      listProducts.add(event.product!);
    } */
    add(GetListEvent());
    yield state.copyWith(loading: false);
  }

  /* static ProductBloc of(BuildContext context) {
    return BlocProvider.of<ProductBloc>(context);
  } */
}
