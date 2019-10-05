import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coffee_shop/Business/Database/cart_item_DB.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'cart.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  @override
  CartState get initialState => CartInitial();

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is GetCoffeeItems) {
      yield CartLoading();
      final Cart cart = await CartItemDB.fetchCartItems();
      yield CartLoaded(cart);
    }
  }
}
