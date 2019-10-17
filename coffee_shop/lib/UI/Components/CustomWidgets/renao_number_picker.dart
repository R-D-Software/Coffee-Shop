import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RenaoNumberPicker extends StatefulWidget 
{
    final int initialValue;
    final List<int> numbers;
    final Color textColor;
    final double listViewWidth;
    int currentValue;
    Function setValue;
    Function afterBuildCallback;

    RenaoNumberPicker
    (
        {
            @required this.initialValue,
            @required this.numbers,
            this.textColor,
            this.setValue,
            this.afterBuildCallback,
            this.listViewWidth
        }
    );

    @override
    _RenaoNumberPickerState createState() => _RenaoNumberPickerState();
}

class _RenaoNumberPickerState extends State<RenaoNumberPicker> with SingleTickerProviderStateMixin 
{
    AnimationController _controller;
    int _currentValue = 0;

    @override
    void initState() 
    {
        super.initState();
        _controller = AnimationController(vsync: this);
        _currentValue = widget.initialValue;
        widget.setValue(_currentValue);
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
        
        if(widget.afterBuildCallback != null)
        {
            WidgetsBinding.instance.addPostFrameCallback(widget.afterBuildCallback);
        }

        return NumberPicker.integer
        (
            initialList: widget.numbers,
            listViewWidth: widget.listViewWidth,
            initialValue: widget.initialValue,
            itemExtent: 60,
            textColor: widget.textColor,
            onChanged: (newValue) => setState(() => onValueChange(newValue))
        );
    }

    void onValueChange(int newVal)
    {
        _currentValue = newVal;
        widget.setValue(_currentValue);
    }
}

/// Created by Marcin Szałek

///NumberPicker is a widget designed to pick a number between #minValue and #maxValue
class NumberPicker extends StatelessWidget {
  ///height of every list element for normal number picker
  ///width of every list element for horizontal number picker
  static const double kDefaultItemExtent = 50.0;

  ///width of list view for normal number picker
  ///height of list view for horizontal number picker
  static const double kDefaultListViewCrossAxisSize = 100.0;

  ///constructor for integer number picker
  NumberPicker.integer({
    Key key,
    this.initialList,
    @required int initialValue,
    @required this.onChanged,
    this.itemExtent = kDefaultItemExtent,
    this.listViewWidth = kDefaultListViewCrossAxisSize,
    this.step = 1,
    this.scrollDirection = Axis.vertical,
    this.infiniteLoop = false,
    this.zeroPad = false,
    this.highlightSelectedValue = true,
    this.decoration,
    this.textColor,
  })  : assert(initialValue != null),
        assert(step > 0),
        assert(scrollDirection != null),
        selectedIntValue = initialValue,
        selectedDecimalValue = -1,
        decimalPlaces = 0,
        intScrollController = new ScrollController
        (
            initialScrollOffset: 0,
        ),
        listViewHeight = 3 * itemExtent,
        integerItemCount = initialList.length,
        super(key: key);

  ///called when selected value changes
  final ValueChanged<num> onChanged;

  //initial list
  final List<int> initialList;

  final Color textColor;

  ///inidcates how many decimal places to show
  /// e.g. 0=>[1,2,3...], 1=>[1.0, 1.1, 1.2...]  2=>[1.00, 1.01, 1.02...]
  final int decimalPlaces;

  ///height of every list element in pixels
  final double itemExtent;

  ///height of list view in pixels
  final double listViewHeight;

  ///width of list view in pixels
  final double listViewWidth;

  ///ScrollController used for integer list
  final ScrollController intScrollController;

  ///Currently selected integer value
  final int selectedIntValue;

  ///Currently selected decimal value
  final int selectedDecimalValue;

  ///If currently selected value should be highlighted
  final bool highlightSelectedValue;

  ///Decoration to apply to central box where the selected value is placed
  final Decoration decoration;

  ///Step between elements. Only for integer datePicker
  ///Examples:
  /// if step is 100 the following elements may be 100, 200, 300...
  /// if min=0, max=6, step=3, then items will be 0, 3 and 6
  /// if min=0, max=5, step=3, then items will be 0 and 3.
  final int step;

  /// Direction of scrolling
  final Axis scrollDirection;

  ///Repeat values infinitely
  final bool infiniteLoop;

  ///Pads displayed integer values up to the length of maxValue
  final bool zeroPad;

  ///Amount of items
  final int integerItemCount;

  //
  //----------------------------- PUBLIC ------------------------------
  //

  /// Used to animate integer number picker to new selected value
  void animateInt(int valueToSelect) 
  {
    animateIntToIndex(initialList.indexOf(valueToSelect));
  }

  /// Used to animate integer number picker to new selected index
  void animateIntToIndex(int index) {
    _animate(intScrollController, index * itemExtent);
  }

  /// Used to animate decimal number picker to selected value
  void animateDecimalAndInteger(double valueToSelect) {
    animateInt(valueToSelect.floor());
  }

  //
  //----------------------------- VIEWS -----------------------------
  //

  ///main widget
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    if (infiniteLoop) {
    }
    if (decimalPlaces == 0) {
      return _integerListView(themeData);
    } else {
      return new Row(
        children: <Widget>[
          _integerListView(themeData),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      );
    }
  }

    String _toDateFormatNumber(int number)
    {
        String retval = number.toString();

        if(number<10)
            retval = "0" + number.toString();

        return retval;
    }

  Widget _integerListView(ThemeData themeData) {
    var listItemCount = integerItemCount + 2;
    List<Widget> listWidgets = 
    [
        Container(),
        ...initialList.map((number) => Text
        (
            _toDateFormatNumber(number),
            style: TextStyle
            (
                color: textColor
            ),
        )),
        Container(),
    ];


    return Listener(
      onPointerUp: (ev) {
        ///used to detect that user stopped scrolling
        if (intScrollController.position.activity is HoldScrollActivity) {
          animateInt(selectedIntValue);
        }
      },
      child: new NotificationListener(
        child: new Container(
          height: listViewHeight,
          width: listViewWidth,
          child: Stack(
            children: <Widget>[
              new ListView.builder(
                scrollDirection: scrollDirection,
                controller: intScrollController,
                itemExtent: itemExtent,
                itemCount: listItemCount,
                itemBuilder: (BuildContext context, int index) 
                {
                    return Center(child: listWidgets[index]);
                },
              ),
            ],
          ),
        ),
        onNotification: _onIntegerNotification,
      ),
    );
  }

  //
  // ----------------------------- LOGIC -----------------------------
  //

  int _intValueFromIndex(int index) {
    return initialList[index];
  }

  bool _onIntegerNotification(Notification notification) 
  {
    if (notification is ScrollNotification) 
    {
        int intIndexOfMiddleElement = (notification.metrics.pixels / itemExtent).round();
        if (!infiniteLoop) 
        {
            intIndexOfMiddleElement = intIndexOfMiddleElement.clamp(0, integerItemCount - 1);
        }

        int intValueInTheMiddle = _intValueFromIndex(intIndexOfMiddleElement);

        if (_userStoppedScrolling(notification, intScrollController)) 
        {
            animateIntToIndex(intIndexOfMiddleElement);
            onChanged(intValueInTheMiddle);
        }
    }

    return true;
  }

 
  ///There was a bug, when if there was small integer range, e.g. from 1 to 5,
  ///When user scrolled to the top, whole listview got displayed.
  ///To prevent this we are calculating cacheExtent by our own so it gets smaller if number of items is smaller
  double _calculateCacheExtent(int itemCount) {
    double cacheExtent = 250.0; //default cache extent
    if ((itemCount - 2) * kDefaultItemExtent <= cacheExtent) {
      cacheExtent = ((itemCount - 3) * kDefaultItemExtent);
    }
    return cacheExtent;
  }

  ///When overscroll occurs on iOS,
  ///we can end up with value not in the range between [minValue] and [maxValue]
  ///To avoid going out of range, we change values out of range to border values.
  int _normalizeMiddleValue(int valueInTheMiddle, int min, int max) {
    return math.max(math.min(valueInTheMiddle, max), min);
  }

  ///indicates if user has stopped scrolling so we can center value in the middle
  bool _userStoppedScrolling(
    Notification notification,
    ScrollController scrollController,
  ) {
    return notification is UserScrollNotification &&
        notification.direction == ScrollDirection.idle &&
        scrollController.position.activity is! HoldScrollActivity;
  }

  ///scroll to selected value
  _animate(ScrollController scrollController, double value) {
    scrollController.animateTo(value,
        duration: new Duration(seconds: 1), curve: new ElasticOutCurve());
  }
}

