import 'package:coffee_shop/Business/Database/order_DB.dart';
import 'package:coffee_shop/Models/shops.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_number_picker.dart';
import 'package:flutter/material.dart';

class TimePickerComponent extends StatefulWidget 
{
    int pickedHour = 6;
    int pickedMinute = 1;
    final Shop currentShop;
    final DateTime date;
    final Map<String,dynamic> notSelectableDates;
    final int minutesAfterOrder;

    TimePickerComponent({this.notSelectableDates, this.currentShop, this.date, this.minutesAfterOrder});

    @override
    _TimePickerComponentState createState() => _TimePickerComponentState();
}

class _TimePickerComponentState extends State<TimePickerComponent> with SingleTickerProviderStateMixin 
{
    AnimationController _controller;
    List<int> pickableMinutes = new List<int>();
    bool initStateb = true;

    @override
    void initState() 
    {
        super.initState();
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
        int minutesAfterOrder = widget.minutesAfterOrder;
        int addMinutes = 0;
        DateTime now = DateTime.now();
        int startTime = widget.currentShop.opens;
        int endTime = widget.currentShop.closes;

        if(now.year == widget.date.year
            && now.month == widget.date.month
            && now.day == widget.date.day)
        {
            if(startTime < now.hour && (now.hour+1) < endTime)
            {
                if((60 - now.minute) <= minutesAfterOrder)
                {
                    startTime = now.hour+1;
                    addMinutes = minutesAfterOrder - (60 - now.minute);
                }
                else
                {
                    startTime = now.hour;
                    addMinutes = minutesAfterOrder;
                }
            }
        }

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
                                    numbers: List.generate((endTime-startTime+1), (int index) 
                                    {
                                        return startTime+index;
                                    }),
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
                                _minutePicker(pickableMinutes, addMinutes)               
                            ],
                        ),
                    ],
                ),
            )
        );
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
        setState(() {});
    }

    Widget _minutePicker(List<int> pickableList, int addMinutes) 
    {
        for(int i = 0; i < addMinutes; i++)
        {
            if(pickableMinutes.contains(i))
            {
                pickableMinutes.remove(i);
            }
        }
        return RenaoNumberPicker
        (
            initialValue: 0,
            numbers: pickableList,
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