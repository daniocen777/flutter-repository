import 'package:flutter_ecommerce/models/app_state.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/redux/actions.dart';

AppState appReducer(state, action) {
  return AppState(
      user: userReducer(state.user, action),
      products: productsReducer(state.products, action),
      cartProducts: cartProducts(state.cartProducts, action));
}

userReducer(user, action) {
  if (action is GetUserAction) {
    // retorna user de la acción
    return action.user;
  } else if (action is LogoutUserAction) {
    // retorna user de la acción
    return action.user;
  }

  return user;
}

List<Product> productsReducer(List<Product> products, dynamic action) {
  if (action is GetProductsAction) {
    // retorna user de la acción
    return action.products;
  }

  return products;
}

List<Product> cartProducts(List<Product> cartProducts, dynamic action) {
  if (action is ToggleCartProductAction) {
    return action.cartProducts;
  }
  return cartProducts;
}
