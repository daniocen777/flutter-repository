import 'dart:convert';

import 'package:redux/redux.dart';
import 'package:flutter_ecommerce/models/app_state.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';

/* ------------ User Actions ------------ */
ThunkAction<AppState> getUserAction = (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();
  final String storeUser = prefs.getString("user");
  final user = (storeUser != null) ? json.decode(storeUser) : null;
  store.dispatch(GetUserAction(user));
};

class GetUserAction {
  final dynamic _user;

  dynamic get user => this._user;

  GetUserAction(this._user);
}
