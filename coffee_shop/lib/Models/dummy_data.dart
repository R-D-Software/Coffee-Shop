import 'package:coffee_shop/Models/shop_item.dart';

class DummyData
{
    static final List<ShopItem> items = 
    [
        new ShopItem(name: "Cat Poop Coffee", price: 250, imagePath: "assets/images/kav.jpg"),
        new ShopItem(name: "Cappuccino", price: 300, imagePath: "assets/images/kav.jpg"),
        new ShopItem(name: "Frappe", price: 150, imagePath: "assets/images/kav.jpg"),
        new ShopItem(name: "Espresso", price: 105, imagePath: "assets/images/kav.jpg"),
        new ShopItem(name: "Latte", price: 400, imagePath: "assets/images/kav.jpg"),
    ];

    static final List<ShopItem> empty = [];
}