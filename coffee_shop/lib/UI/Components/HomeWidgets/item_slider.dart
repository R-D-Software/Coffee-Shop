import 'package:coffee_shop/Models/shop_item.dart';
import 'package:coffee_shop/UI/Components/HomeWidgets/header_painter.dart';
import 'package:flutter/material.dart';
import 'item_component.dart';

class ItemSlider extends StatefulWidget 
{
    final String name;
    final IconData icon;
    final List<ShopItem> items;
    final Function onIconClick;

    ItemSlider({@required this.name, this.icon, @required this.items, this.onIconClick});

    @override
    _ItemSliderState createState() => _ItemSliderState();
}

class _ItemSliderState extends State<ItemSlider> 
{
    double _maxHeight;
    double _height;
    double _width;
    double _heightBreak;
    double _itemSize;

    @override
    Widget build(BuildContext context) 
    {
        if(widget.items.isEmpty) return Container();
       
        getPropertyValues();
    
        return Column
        (
            children: 
            [
                HeaderPainter
                (
                    name: widget.name,
                    width: _width,
                    height: _height,
                    maxHeight: _maxHeight,
                    heightBreak: _heightBreak,
                    icon: widget.icon,
                    onIconClick: widget.onIconClick ,
                ),
                Container
                (
                    margin: EdgeInsets.only(top: 7, bottom: 7),
                    height: this._itemSize,
                    child: ListView
                    (
                        scrollDirection: Axis.horizontal,
                        children: _getItems(widget.items)
                    )
                )
            ]
        );
    }
        
    void getPropertyValues() 
    {
        MediaQueryData mQueryData = MediaQuery.of(context);

        this._height = mQueryData.size.height;
        this._width = mQueryData.size.width;
        this._maxHeight = 120;
        this._heightBreak = 57;
        this._itemSize = 180;
    }

    List<Widget> _getItems(List<ShopItem> items)
    {
        return items.map((f) => Container
        (
            margin: EdgeInsets.only(right: 7),
            child: ItemComponent(f, height: this._itemSize, width: this._itemSize),
            width: this._itemSize,
            color: Colors.transparent,
        )).toList();
    }
}