import 'package:coffee_shop/Models/coffee_Item.dart';
import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  final List<CoffeeItem> shopItems;

  Cart(
    this.shopItems,
  ) : super([shopItems]);

  int get sum {
    int sum = 0;
    for (CoffeeItem item in shopItems) {
      sum = sum + item.price;
    }
    return sum;
  }

  deleteItem(CoffeeItem item) {
    shopItems.remove(item);
  }
}
