import 'package:coffee_shop/Models/CartItem.dart';
import 'package:coffee_shop/Models/shop_item.dart';

class DummyData
{
    static final List<ShopItem> shopItems =
    [
        new ShopItem(id: 1, name: "Cat Poop Coffee", price: 250, imagePath: "assets/images/kav.jpg"),
        new ShopItem(id: 2,name: "Cappuccino", price: 300, imagePath: "assets/images/kav.jpg"),
        new ShopItem(id: 3,name: "Frappe", price: 150, imagePath: "assets/images/kav.jpg"),
        new ShopItem(id: 4,name: "Espresso", price: 105, imagePath: "assets/images/kav.jpg"),
        new ShopItem(id: 5,name: "Latte", price: 400, imagePath: "assets/images/kav.jpg"),
    ];

    static final List<ShopItem> empty = [];

    static final List<CoffeeItem> cartItems =
    [
        CoffeeItem(shopItem: shopItems[0], temperature: Temperature.cold(), itemCount: 2, sugar: 1),
        CoffeeItem(shopItem: shopItems[1], temperature: Temperature.warm(), itemCount: 1, sugar: 2),
        CoffeeItem(shopItem: shopItems[2], temperature: Temperature.iceCold(), itemCount: 3, sugar: 4),
        CoffeeItem(shopItem: shopItems[3], temperature: Temperature.hot(), itemCount: 4, sugar: 3),
        CoffeeItem(shopItem: shopItems[4], temperature: Temperature.warm(), itemCount: 5, sugar: 0),
    ];
}