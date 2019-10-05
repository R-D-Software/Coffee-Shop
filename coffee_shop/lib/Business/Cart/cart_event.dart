part of 'cart_bloc.dart';

@immutable
abstract class CartEvent extends Equatable {
  CartEvent([List props = const []]) : super(props);
}

class GetCoffeeItems extends CartEvent {
  GetCoffeeItems() : super([]);
}
