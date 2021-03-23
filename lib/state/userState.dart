import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:shop_app/state/AuthUser.dart';

class AuthUserModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  Map<AuthUser, dynamic> _authUser = {};

  /// An unmodifiable view of the items in the cart.
  UnmodifiableMapView<AuthUser, dynamic> get authUser =>
      UnmodifiableMapView(_authUser);

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void setUser(Map<AuthUser, dynamic> user) {
    _authUser = user;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeUser() {
    _authUser = {};
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void addToCart() {
    //Add Something in the cart
  }

  void removeFromCart() {
    //Remove certain item from the cart
  }
  void clearTheCart() {
    //creat the Cart
  }
}
