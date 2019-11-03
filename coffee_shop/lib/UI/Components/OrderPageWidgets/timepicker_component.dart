import 'package:coffee_shop/Business/Database/order_DB.dart';
import 'package:coffee_shop/Models/shops.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_number_picker.dart';
import 'package:coffee_shop/UI/Components/stroked_text.dart';
import 'package:flutter/material.dart';

class TimePickerComponent extends StatefulWidget 
{
    int pickedHour;
    int pickedMinute;
    final Shop currentShop;
    final DateTime date;
    final Map<String,dynamic> notSelectableDates;
    final int minutesAfterOrder;
    bool stop = false;

    void stopClock()
    {
        stop = true;
    }

    TimePickerComponent({this.notSelectableDates, this.currentShop, this.date, this.minutesAfterOrder});

    @override
    _TimePickerComponentState createState() => _TimePickerComponentState();
}

class _TimePickerComponentState extends State<TimePickerComponent> with SingleTickerProviderStateMixin 
{
    AnimationController _controller;
    List<int> pickableMinutes = new List<int>();
    List<int> pickableHours = new List<int>();
    bool initStateb = true;
    int addMinute = 0;
    bool cannotOrder = false;
    RenaoNumberPicker hourPicker;
    DateTime startDate;
    DateTime closesDate;
    bool buildMinutes = false;

    @override
    void initState() 
    {
        super.initState(); 
        _initData();    
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
        if(cannotOrder)
        {
            return _buildCannotOrderBody(context);
        }
        else
        {
            return _buildBody(context);
        }
    }

    Widget _buildBody(BuildContext context)
    {
        return Card
        (
            color: Colors.brown,
            child: Container
            (
                height: 175,
                child: Stack
                (
                    children: <Widget>
                    [
                        Center
                        (
                            child: SizedBox
                            (
                                height: 50,
                                width: MediaQuery.of(context).size.width*0.90,
                                child: Container
                                (
                                    decoration: BoxDecoration
                                    (
                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                        border: Border.all
                                        (
                                            color: Colors.white, width: 4
                                        ),
                                    )
                                )
                            )
                        ),
                        Row
                        (
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>
                            [
                                RenaoNumberPicker
                                (
                                    numbers: pickableHours,
                                    initialValue: widget.pickedHour,
                                    listViewWidth: MediaQuery.of(context).size.width*0.45,
                                    textColor: Colors.white,
                                    afterBuildCallback: _generateAvailableMinutesList,
                                    setValue: (int val)
                                    {
                                        if(val != 0)
                                        {
                                            widget.pickedHour = val;
                                        }
                                    },
                                ),
                                Text(":", style: TextStyle(color: Colors.white),),
                                _minutePicker(pickableMinutes, addMinute)               
                            ],
                        ),
                    ],
                ),
            )
        );
    }

    Widget _buildCannotOrderBody(BuildContext context)
    {
        return Center
        (
            child: StrokedText(text: "You cannot order now :("),
        );
    }    

    void _initData()
    {
        int minutesAfterOrder = widget.minutesAfterOrder;
        DateTime now = DateTime.now();
        int startHour = widget.currentShop.opensHour;
        int endHour = widget.currentShop.closesHour;
        int startMinutes = widget.currentShop.opensMinute;
        int endMinute = widget.currentShop.closesMinute;
        startDate = widget.date.add(Duration(hours: startHour, minutes: startMinutes));
        closesDate = widget.date.add(Duration(hours: endHour, minutes: endMinute));
        pickableHours = new List<int>();
        //now = DateTime.parse("2019-10-25 05:00:00"); //FOR DEBUGGING

        if(now.isBefore(startDate.add(Duration(seconds:10)))) // there is no <= with isBefore -> add 10 seconds to startDate
        {
            if(now.difference(startDate).inMinutes.abs() <= minutesAfterOrder)
            {
                startDate = now.add(Duration(minutes: (minutesAfterOrder)));               
            }
        }
        else
        {
            if(now.difference(closesDate).inMinutes.abs() >= (minutesAfterOrder-2))
            {               
                startDate = now.add(Duration(minutes: (minutesAfterOrder)));                
            }
            else
            {
                cannotOrder = true;
            }
        }

        addMinute = startDate.minute;
        widget.pickedHour = startDate.hour;
        widget.pickedMinute = startDate.minute;

        for(int i = startDate.hour; i < closesDate.hour+1; i++)
        {
            pickableHours.add(i);
        }
    }

    void _generateAvailableMinutesList(Duration s) async
    {
        List<int> notPickableList = await OrderDB.getNotPickableMinutes(widget.pickedHour, widget.notSelectableDates, widget.currentShop);
        pickableMinutes = new List<int>();

        for(int i = 0; i < 60; i++)
        {
            if(!notPickableList.contains(i))
                pickableMinutes.add(i);
        }
        if(!widget.stop)
            setState(() {buildMinutes = true;});
    }

    Widget _minutePicker(List<int> pickableList, int addMinutes) 
    {
        if(widget.pickedHour <= startDate.hour)
        {         
            for(int i = 0; i < addMinutes; i++)
            {
                if(pickableMinutes.contains(i))
                {
                    pickableMinutes.remove(i);
                }
            }
        }
        else if(widget.pickedHour == closesDate.hour)
        {
            for(int i = closesDate.minute+1; i <= 60; i++)
            {
                if(pickableMinutes.contains(i))
                {
                    pickableMinutes.remove(i);
                }
            }
        }
        if(!buildMinutes)
        {
            return Container();
        }

        return RenaoNumberPicker
        (
            initialValue: pickableList.first,
            numbers: pickableMinutes,
            textColor: Colors.white,
            listViewWidth: MediaQuery.of(context).size.width*0.45,
            setValue: (int val)
            {
                if(val != 0)
                {
                    widget.pickedMinute = val;
                }
            },
        );
    }
}