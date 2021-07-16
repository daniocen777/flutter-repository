part of 'product_bloc.dart';

class ProductEvent {}

class GetListEvent extends ProductEvent {}

class AddProductEvent extends ProductEvent {
  final Product? product;

  AddProductEvent({this.product});
}
