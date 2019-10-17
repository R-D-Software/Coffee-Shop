import 'package:coffee_shop/UI/Components/CustomWidgets/renao_number_picker.dart';
import 'package:flutter/material.dart';

class TimePickerComponent extends StatefulWidget 
{
    int pickedHour = 8;
    int pickedMinute = 1;
    final Map<String,dynamic> notSelectableDates;

    TimePickerComponent(this.notSelectableDates);

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
        int startTime = 6;
        int endTime = 14;

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
                                _minutePicker(pickableMinutes)               
                            ],
                        ),
                    ],
                ),
            )
        );
    }

    void _generateAvailableMinutesList(Duration s)
    {
        List<int> notPickableList = _getNotPickableMinutes(widget.pickedHour);
        pickableMinutes = new List<int>();

        for(int i = 1; i < 60; i++)
        {
            if(!notPickableList.contains(i))
                pickableMinutes.add(i);
        }
        setState(() {});
    }

    List<int> _getNotPickableMinutes(int currentHour)
    {
        List<int> notPickableMinutes = new List<int>();
        String key = (currentHour < 10 ? "0" + currentHour.toString() : currentHour.toString());
        
        if(widget.notSelectableDates != null)
        {
            if(widget.notSelectableDates.containsKey(key))
            {
                for(String minute in widget.notSelectableDates[key].keys)
                {
                    if(widget.notSelectableDates[key][minute] > 0)
                    {
                        notPickableMinutes.add(int.parse(minute));
                    }
                }
            }
        }
        
        return notPickableMinutes;
    }

    Widget _minutePicker(List<int> pickableList) 
    {
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