import 'package:auto_size_text/auto_size_text.dart';
import 'package:coffee_shop/Business/Database/boxes_DB.dart';
import 'package:coffee_shop/Business/Database/order_DB.dart';
import 'package:coffee_shop/Business/Database/shop_item_DB.dart';
import 'package:coffee_shop/Business/Database/shops_DB.dart';
import 'package:coffee_shop/Business/MapNavigator/google_navigator.dart';
import 'package:coffee_shop/Business/string_service.dart';
import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/Models/order.dart';
import 'package:coffee_shop/Models/post_box.dart';
import 'package:coffee_shop/Models/shop_item.dart';
import 'package:coffee_shop/Models/shops.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_box_decoration.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_dialog.dart';
import 'package:coffee_shop/UI/Components/stroked_text.dart';
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String route = '/main/home/orderdetails';

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  double height = 0;

  Order order;

  @override
  Widget build(BuildContext context) {
    _initializeData(context);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[_buildOrderDateHeader(context, order.toDateTime())],
      ),
      body: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: StreamBuilder(
            stream: OrderDB.getOrder(order.orderID),
            builder: (context, orderSnap) {
              if (orderSnap.connectionState == ConnectionState.waiting) {
                return Container();
              } else {
                return _makeOrderDetailsBody(
                    context, Order.fromDocument(orderSnap.data));
              }
            },
          ),
          decoration: RenaoBoxDecoration.builder(context)),
    );
  }

  Widget _makeOrderDetailsBody(BuildContext context, Order updatedOrder) {
    Widget boxWidget = Container();

    if (updatedOrder.box == "-1") {
      boxWidget = _makeBoxText(updatedOrder.box, context);
    } else {
      boxWidget = _makeBoxOpener(updatedOrder, context);
    }

    return Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _makeShopImage(updatedOrder.shopID, context),
            SizedBox(),
            boxWidget,
            SizedBox(),
            Text(
              LanguageModel.items[LanguageModel.currentLanguage],
              style: TextStyle(fontSize: 25, color: Colors.brown),
            ),
            _makeItemsList(
                updatedOrder.items.map((f) => f.parentID).toList(), context),
          ],
        ),
      ),
    );
  }

  void _initializeData(BuildContext context) {
    final Map<String, dynamic> routeArgs =
        ModalRoute.of(context).settings.arguments;
    order = routeArgs['order'];
    height = 0;
  }

  Widget _makeShopImage(String shopID, BuildContext context) {
    return StreamBuilder(
      stream: ShopsDB.getShopByID(shopID).asStream(),
      builder: (context, shopSnap) {
        if (shopSnap.connectionState == ConnectionState.waiting) {
          return Container();
        } else {
          return _makeShopPicture(context, shopSnap.data as Shop);
        }
      },
    );
  }

  Widget _makeShopPicture(BuildContext context, Shop currentShop) {
    height += MediaQuery.of(context).size.width * 0.80;
    return Container(
      height: MediaQuery.of(context).size.width * 0.80,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40))),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: new BorderRadius.circular(40.0),
              child: Image.network(
                currentShop.imageURL,
                height: MediaQuery.of(context).size.width * 0.80,
                width: MediaQuery.of(context).size.width * 0.80,
              ),
            ),
            _buildPlaceHeader(context, currentShop),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceHeader(BuildContext context, Shop currentShop) {
    return GestureDetector(
      onTap: () {
        GoogleNavigator.navigate(currentShop.latitude, currentShop.longitude);
      },
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            color: Colors.grey.withOpacity(0.8),
          ),
          height: 40,
          width: MediaQuery.of(context).size.width * 0.80,
          alignment: Alignment.center,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: AutoSizeText(
                    currentShop.toString().toUpperCase(),
                    style: TextStyle(color: Colors.white),
                    maxFontSize: 20,
                    minFontSize: 10,
                    maxLines: 1,
                  ),
                ),
                Icon(
                  Icons.navigation,
                  color: Colors.blue,
                ),
              ],
            ),
          )),
    );
  }

  Widget _makeBoxText(String box, BuildContext context) {
    height += MediaQuery.of(context).size.height * 0.8;
    if (box == "-1") {
      return Container(
        height: MediaQuery.of(context).size.height * 0.08,
        child: StrokedText(
            text: LanguageModel.boxNotAssigned[LanguageModel.currentLanguage]),
      );
    } else {
      return Container(
        height: MediaQuery.of(context).size.height * 0.08,
        child: StrokedText(text: LanguageModel.boxAssignedAt(box)),
      );
    }
  }

  Widget _buildOrderDateHeader(BuildContext context, DateTime orderDate) {
    return Padding(
      padding: EdgeInsets.only(right: 8),
      child: Center(
        child: Text(
          orderDate.year.toString() +
              "." +
              StringService.toDateFormatNumber(orderDate.month) +
              "." +
              StringService.toDateFormatNumber(orderDate.day) +
              " " +
              StringService.toDateFormatNumber(orderDate.hour) +
              ":" +
              StringService.toDateFormatNumber(orderDate.minute) +
              " " +
              _getDayFromWeekDay(orderDate.weekday),
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      ),
    );
  }

  String _getDayFromWeekDay(int day) {
    return LanguageModel.dayName(day - 1);
  }

  Widget _makeItemsList(List<String> items, BuildContext context) {
    List<Widget> itemWidgets = [];

    for (String item in items) {
      itemWidgets.add(StreamBuilder(
        stream: ShopItemDB.getShopItemByID(item),
        builder: (context, itemSnap) {
          if (itemSnap.connectionState == ConnectionState.waiting) {
            return Container();
          } else {
            return _itemListElement((itemSnap.data as ShopItem), context);
          }
        },
      ));
    }

    return Container(
      height: items.length * 59.0,
      child: Column(
        children: itemWidgets,
      ),
    );
  }

  Widget _itemListElement(ShopItem item, BuildContext context) {
    return Card(
      color: Theme.of(context).accentColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.network(
            item.imageUrl,
            height: 50,
          ),
          SizedBox(
            width: 10,
          ),
          StrokedText(
            text: item.name,
          ),
        ],
      ),
    );
  }

  Widget _makeBoxOpener(Order updateOrder, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4),
      child: Container(
        alignment: Alignment.bottomCenter,
        child: ButtonTheme(
          buttonColor: Color.fromRGBO(231, 82, 100, 1),
          minWidth: MediaQuery.of(context).size.width - 20,
          height: 40,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            elevation: 0,
            onPressed: () async {
              if (updateOrder.box != "-1") {
                PostBox pb = await BoxesDB.getBoxByIDFuture(updateOrder.box);
                print(pb.open);

                if (updateOrder.userID == pb.ownerUserID) {
                  OpenBoxStatus answer = await BoxesDB.tryToOpen(
                      updateOrder.box, updateOrder.orderID, context);

                  if (answer == OpenBoxStatus.USER_YES) {
                    Navigator.of(context).pop();
                  } else if (answer == OpenBoxStatus.ERROR_HAPPENED) {
                    RenaoDialog.showCantOpenDialog(context);
                  } else if (answer == OpenBoxStatus.BOX_IS_OPEN) {
                    RenaoDialog.showBoxIsOpen(context);
                  }
                }
              }
            },
            child: Text(
              LanguageModel.openTheBox[LanguageModel.currentLanguage],
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
