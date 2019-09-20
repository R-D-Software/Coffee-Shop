import 'package:coffee_shop/Models/CartItem.dart';
import 'package:coffee_shop/Models/shop_item.dart';

class DummyData
{
    static final List<ShopItem> items =
    [

        new ShopItem(name: "Cat Poop Coffee", price: 250, imageUrl: "https://firebasestorage.googleapis.com/v0/b/renao-7c69c.appspot.com/o/kav.jpg?alt=media&token=4b1a5f24-976b-471c-a2a6-a84ff77583fe"),
        new ShopItem(name: "Cappuccino", price: 300, imageUrl: "https://firebasestorage.googleapis.com/v0/b/renao-7c69c.appspot.com/o/kav.jpg?alt=media&token=4b1a5f24-976b-471c-a2a6-a84ff77583fe"),
        new ShopItem(name: "Frappe", price: 150, imageUrl: "https://firebasestorage.googleapis.com/v0/b/renao-7c69c.appspot.com/o/kav.jpg?alt=media&token=4b1a5f24-976b-471c-a2a6-a84ff77583fe"),
        new ShopItem(name: "Espresso", price: 105, imageUrl: "https://firebasestorage.googleapis.com/v0/b/renao-7c69c.appspot.com/o/kav.jpg?alt=media&token=4b1a5f24-976b-471c-a2a6-a84ff77583fe"),
        new ShopItem(name: "Latte", price: 400, imageUrl: "https://firebasestorage.googleapis.com/v0/b/renao-7c69c.appspot.com/o/kav.jpg?alt=media&token=4b1a5f24-976b-471c-a2a6-a84ff77583fe"),
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