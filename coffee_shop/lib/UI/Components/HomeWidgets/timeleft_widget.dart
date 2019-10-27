import 'package:coffee_shop/Business/Database/order_DB.dart';
import 'package:coffee_shop/Business/string_service.dart';
import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/Models/order.dart';
import 'package:flutter/material.dart';
import 'package:quiver/async.dart';

class TimeLeftWidget extends StatefulWidget 
{
    final Order orderToCome;
    TimeLeftWidget(this.orderToCome);

    @override
    _TimeLeftWidgetState createState() => _TimeLeftWidgetState();
}

class _TimeLeftWidgetState extends State<TimeLeftWidget> with SingleTickerProviderStateMixin 
{
    AnimationController _controller;
    int _current = 0;
    Order orderToCome;
    CountdownTimer countDownTimer;
    bool orderReady = false;

    @override
    void initState() 
    {   
        super.initState();
        _controller = AnimationController(vsync: this);
        orderToCome = widget.orderToCome;
        startTimer();
    }

    @override
    void dispose() 
    {
        countDownTimer.cancel();
        super.dispose();
        _controller.dispose();
    }

    Widget build(BuildContext context) 
    {
        return Text
        (
            _minutesToTimeFormat(_current),
            style: TextStyle
            (
                color: Colors.orange
            ),
        );
    }

    void startTimer() 
    {
        DateTime now = DateTime.now();
        Duration difference = orderToCome.toDateTime().difference(now);

        countDownTimer = new CountdownTimer
        (
            difference,
            new Duration(seconds: 1),
        );   

        var sub = countDownTimer.listen(null);
        sub.onData((duration) 
        {
            if(duration.remaining.inSeconds <= 0) OrderDB.deleteOrder(orderToCome.docID);
            
            setState(() { _current = duration.remaining.inSeconds; });
        });

        sub.onDone(() 
        {
            orderReady = true;
            sub.cancel();
        });
    }
    
    String _minutesToTimeFormat(int seconds)
    {       
        if(orderReady) return LanguageModel.orderIsReady[LanguageModel.currentLanguage];
        int hour = (seconds/3600).floor();
        int days = (hour/24).floor();       
        int remainingMinutes = (seconds/60).floor()-(hour*60);
        int remainingSeconds = seconds - (remainingMinutes*60) - (hour*3600);
        hour -= days*24;
        String timeFormat;

        timeFormat = LanguageModel.timeRemaining[LanguageModel.currentLanguage]
            + ": " +
            (days > 0 ? days.toString() + LanguageModel.dayLetter[LanguageModel.currentLanguage] : "") 
            + " " + 
            StringService.toDateFormatNumber(hour)
            + ":" + 
            StringService.toDateFormatNumber(remainingMinutes)
            + ":" + 
            StringService.toDateFormatNumber(remainingSeconds);

        return timeFormat;
    }
}