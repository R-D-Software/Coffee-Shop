import 'package:coffee_shop/Models/coffee_Item.dart';
import 'package:coffee_shop/Models/shop_item.dart';
import 'package:flutter/material.dart';

class TemperatureChooser extends StatefulWidget {
  ShopItem _item;
  int sugar;
  double maxHeight;
  Function _setTemparatureValueOnParentScreen;

  TemperatureChooser(this._item, this._setTemparatureValueOnParentScreen, this.maxHeight);

  @override
  _TemperatureChooserState createState() => _TemperatureChooserState();
}

class _TemperatureChooserState extends State<TemperatureChooser> {
  Temperature temperature;
  int _value;
  @override
  Widget build(BuildContext context) {
    if (_value <= 25) {
      temperature = Temperature.iceCold();
    } else if (_value > 25 && _value <= 50) {
      temperature = Temperature.cold();
    } else if (_value > 50 && _value <= 75) {
      temperature = Temperature.warm();
    } else {
      temperature = Temperature.hot();
    }
    return buildSlider(temperature.color, temperature.temperature);
  }

  @override
  void initState() {
    super.initState();
    if (widget._item is CoffeeItem) {
      CoffeeItem coffeeItem = widget._item as CoffeeItem;
      temperature = coffeeItem.temperature;
      if (temperature.temperature == Temperature.iceCold().temperature) {
        _value = 0;
      } else if (temperature.temperature == Temperature.cold().temperature) {
        _value = 37;
      } else if (temperature.temperature == Temperature.warm().temperature) {
        _value = 63;
      } else {
        _value = 100;
      }
    } else {
      temperature = Temperature.hot();
      _value = 100;
    }
  }

  Container buildSlider(Color activeColor, String label) {
    return Container(
        height: widget.maxHeight,
      //margin: EdgeInsets.only(bottom: 10),
      child: Slider(
        value: _value.toDouble(),
        min: 0.0,
        max: 100.0,
        divisions: 100,
        activeColor: activeColor,
        inactiveColor: Theme.of(context).primaryColor,
        label: label,
        onChanged: (double newValue) {
          setState(() {
            _value = newValue.round();
          });
        },
        onChangeEnd: widget._setTemparatureValueOnParentScreen(temperature),
      ),
    );
  }
}
