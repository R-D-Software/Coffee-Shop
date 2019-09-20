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
}