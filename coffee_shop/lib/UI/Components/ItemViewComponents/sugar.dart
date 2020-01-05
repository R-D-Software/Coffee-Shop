import 'package:coffee_shop/Business/string_service.dart';
import 'package:coffee_shop/Models/coffee_Item.dart';
import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/Models/shop_item.dart';
import 'package:coffee_shop/Models/static_data.dart';
import 'package:coffee_shop/UI/Components/ItemViewComponents/sugar_chooser.dart';
import 'package:coffee_shop/UI/Components/ItemViewComponents/sugar_type.dart';
import 'package:coffee_shop/UI/Components/stroked_text.dart';
import 'package:flutter/material.dart';

class Sugar extends StatefulWidget {
    double height;
    double sideFontSize;
    ShopItem _item;
    Function _setSugar;
    String sugarTypePath;
    int sugarType = 0;
    SugarChooser sugarChooser;
    int sugarCount; 
    Function _setSugarType;

    Sugar(this.height, this.sideFontSize, this._item, this._setSugar, this.sugarCount, this._setSugarType, {this.sugarType = 0});

    @override
    _SugarState createState() => _SugarState();
}

class _SugarState extends State<Sugar>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

    @override
    void initState() 
    {
        super.initState();
        if(widget._item is CoffeeItem)
        {
            widget.sugarTypePath = StringService.getPathForPic((widget._item as CoffeeItem).sugarType);
        }
        else
        {
            widget.sugarTypePath = StaticData.whiteSugarPath;
        }
        
        widget.sugarChooser = SugarChooser(widget._item, widget._setSugar, widget.height * 0.1, widget.sugarTypePath, widget.sugarCount);
        _controller = AnimationController(vsync: this);
    }

    @override
    void dispose() 
    {
        super.dispose();
        _controller.dispose();
    }

    @override
    Widget build(BuildContext context) 
    {
        return Container
        (
            width: double.infinity,
            child: Column
            (               
                children: <Widget>
                [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,    
                        children: <Widget>
                        [					
                            StrokedText(
                                text: LanguageModel.sugar[LanguageModel.currentLanguage],
                                color: Colors.white,
                                size: widget.sideFontSize,
                            ),	
                            SugarType(widget.height*0.055, StaticData.brownSugarPath, _setSugarType),
                            SugarType(widget.height*0.055, StaticData.whiteSugarPath, _setSugarType),
                            SugarType(widget.height*0.055, StaticData.sweetenerPath, _setSugarType),
                        ],
                    ),
                    SizedBox(height: widget.height * 0.01,),
                    widget.sugarChooser,
                ],
            ),
        );
    }

    void _setSugarType(String imPath)
	{		
        int sugarCount = widget.sugarChooser.sugarCount;

        setState(() {
            widget.sugarTypePath = imPath;
            widget.sugarType = StringService.getSugarTypeFromPath(imPath);
            widget.sugarChooser = SugarChooser(widget._item, widget._setSugar, widget.height * 0.1, widget.sugarTypePath, sugarCount);
        });
        widget._setSugarType(widget.sugarType);
	}
}