part of 'cart_bloc.dart';

@immutable
abstract class CartState extends Equatable {
  CartState([List props = const []]) : super(props);
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final Cart cart;

  CartLoaded(this.cart) : super([cart]);
}
