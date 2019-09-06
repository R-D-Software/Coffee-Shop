import 'package:coffee_shop/Models/shop_item.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_box_decoration.dart';
import 'package:coffee_shop/UI/Components/ItemViewComponents/sugar_chooser.dart';
import 'package:coffee_shop/UI/Components/ItemViewComponents/temperature_chooser.dart';
import 'package:coffee_shop/UI/Components/stroked_text.dart';
import 'package:flutter/material.dart';

class ItemViewScreen extends StatelessWidget 
{
    ShopItem _item = new ShopItem(name: "Great Coffee", price: 400, imagePath: "assets/images/kav.jpg");
    AppBar _appBar = AppBar();
    Container _addButton;
    double height = 0;

    @override
    Widget build(BuildContext context) 
    {
        MediaQueryData mData = MediaQuery.of(context);       
        
        if(mData.orientation == Orientation.portrait)
        {
            height = mData.size.height;
        }
        else
        {
            height = mData.size.width;
        }

        _addButton = _getAddButton(context);

        return Scaffold
        (
            appBar: _appBar,
            body: SingleChildScrollView
            (
                scrollDirection: Axis.vertical,
                child: Container
                (
                    decoration: RenaoBoxDecoration.builder(context),
                    height: height - _appBar.preferredSize.height,
                    child: Column
                    (
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>
                        [
                            Row
                            (
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>
                                [
                                    Icon(Icons.keyboard_arrow_left),
                                    StrokedText
                                    (
                                        text: _item.name,
                                        color: Colors.white,
                                        size: 25,
                                    ),
                                    Icon(Icons.keyboard_arrow_right),
                                ],
                            ),
                            Stack
                            (
                                alignment: Alignment.topCenter,
                                children: <Widget>
                                [
                                    Container
                                    (
                                        margin: EdgeInsets.only(top: 20, bottom: 25),
                                        width: height*0.35,
                                        height: height*0.35,
                                        decoration: new BoxDecoration
                                        (
                                            boxShadow:  
                                            [
                                                new BoxShadow
                                                (
                                                    color: Colors.red,
                                                    spreadRadius: 2,
                                                    offset: new Offset(-5.0, 10.0),
                                                )
                                            ],
                                            border: Border.all(color: Theme.of(context).primaryColor, width: 14),
                                            shape: BoxShape.circle,
                                            image: new DecorationImage
                                            (
                                                fit: BoxFit.fill,
                                                image: new NetworkImage("https://i.imgur.com/BoN9kdC.png")
                                            )
                                        )
                                    ),
                                    Container
                                    (
                                        child: Icon
                                        (
                                            Icons.star,
                                            size: 50,
                                            color: Colors.white,
                                        ),
                                        margin: EdgeInsets.only(top: 2),
                                    )
                                ],
                            ),


                            Container
                            (
                                margin: EdgeInsets.only(bottom: 0),
                                child: StrokedText
                                (
                                    text: "Sugar",
                                    color: Colors.white,
                                    size: 25,
                                ),
                            ),

                            SugarChooser(),

                            Container
                            (
                                margin: EdgeInsets.only(bottom: 10),
                                child: StrokedText
                                (
                                    text: "Temperature",
                                    color: Colors.white,
                                    size: 25,
                                ),
                            ),

                            TemperatureChooser(),

                            _addButton,
                        ],
                    ),
                    width: double.infinity,
                ),
            ),
        );
    }

    Container _getAddButton(BuildContext context)
    {
        return Container
        (
            alignment: Alignment.bottomCenter,
            child: ButtonTheme
            (
                buttonColor: Color.fromRGBO(231,82,100, 1),
                minWidth: MediaQuery.of(context).size.width-20,
                height: height * 0.065, 
                child: RaisedButton
                (	
                    shape: RoundedRectangleBorder
                    (
                        side: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    elevation: 5,
                    onPressed: () {},
                    child: Text
                    (
                        "ADD",
                        style: TextStyle
                        (
                            fontSize: 25,
                            color: Colors.white
                        ),
                    ),
                ),
            ),
        );
    }
}