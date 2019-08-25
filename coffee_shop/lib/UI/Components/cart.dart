import 'package:coffee_shop/Models/shop_item.dart';
import 'package:coffee_shop/UI/Components/stroked_text.dart';
import 'package:flutter/material.dart';

import 'cart_item_component.dart';

class Cart extends StatefulWidget 
{
    @override
    _CartState createState() => _CartState();
}

class _CartState extends State<Cart> 
{
    double _maxHeight;
    double _height;
    double _width;
    double _heightBreak;

    @override
    Widget build(BuildContext context) 
    {
        this._height = MediaQuery.of(context).size.height;
        this._width = MediaQuery.of(context).size.width;
        this._maxHeight = _height * 0.135;
        this._heightBreak = _height * 0.08;

        return Column
        (
            children: 
            [
                CustomPaint
                (
                    child: Container
                    (
                        color: Colors.transparent,
                        child: Align
                        (
                            alignment: Alignment.centerLeft,
                            child: Container
                            (
                                margin: EdgeInsets.only(left: 20.0),
                                child: StrokedText(text: "Cart", size: 34)
                            )
                        ),
                        height: _heightBreak
                    ),
                    painter: CurvePainter(_height, _width, context, _maxHeight, _heightBreak),
                ),

                Container
                (
                    margin: EdgeInsets.only(top: 7),
                    height: 120,
                    child: ListView
                    (
                        scrollDirection: Axis.horizontal,
                        children: <Widget>
                        [
                            Container
                            (
                                margin: EdgeInsets.only(right: 7),
                                child: CartItemComponent(new ShopItem(name: "cica", price: 5, imagePath: "assets/images/kav.jpg")),
                                width: 120.0,
                                color: Colors.transparent,
                            ),
                            Container
                            (
                                margin: EdgeInsets.only(right: 7),
                                child: CartItemComponent(new ShopItem(name: "cica", price: 5, imagePath: "assets/images/kav.jpg")),
                                width: 120.0,
                                color: Colors.transparent,
                            ),
                            Container
                            (
                                margin: EdgeInsets.only(right: 7),
                                child: CartItemComponent(new ShopItem(name: "cica", price: 5, imagePath: "assets/images/kav.jpg")),
                                width: 120.0,
                                color: Colors.transparent,
                            ),
                            Container
                            (
                                margin: EdgeInsets.only(right: 7),
                                child: CartItemComponent(new ShopItem(name: "cica", price: 5, imagePath: "assets/images/kav.jpg")),
                                width: 120.0,
                                color: Colors.transparent,
                            ),
                            Container
                            (
                                margin: EdgeInsets.only(right: 7),
                                child: CartItemComponent(new ShopItem(name: "cica", price: 5, imagePath: "assets/images/kav.jpg")),
                                width: 120.0,
                                color: Colors.transparent,
                            ),
                        ],
                    )
                )
            ]
        );
    }
}

class CurvePainter extends CustomPainter
{
    final double height;
    final double width;
    final double maxHeight;
    final double heightBreak;
    final BuildContext context;

    CurvePainter(this.height, this.width, this.context, this.maxHeight, this.heightBreak);

    @override
    void paint(Canvas canvas, Size size) 
    {
        Path path = Path();
        Paint paint = Paint();

        List<Offset> polygon = <Offset>
        [
            new Offset(0, 0),
            new Offset(0, heightBreak),
            new Offset(width*0.72, heightBreak),
            new Offset(width, maxHeight),
            new Offset(width, 0)
        ];

        path.addPolygon(polygon, true);
        path.close();

        LinearGradient grad = LinearGradient
        (
            colors: <Color>
            [
                Colors.brown,
                Theme.of(context).accentColor
            ],
            end: Alignment.bottomRight,
            begin: Alignment.topLeft
        );

        paint.shader = grad.createShader(Rect.fromLTWH(0, 0, width, maxHeight)); 
        //paint.strokeCap =      
        canvas.drawPath(path, paint);
    }

    @override
    bool shouldRepaint(CustomPainter oldDelegate) 
    {
        return oldDelegate != this;
    }
}