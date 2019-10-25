import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService with ChangeNotifier
{
    static final FlutterLocalNotificationsPlugin _notifications = new FlutterLocalNotificationsPlugin();

    static Future makeNotification(String title, String body, DateTime orderDate) async 
    {
        var andSettings = new AndroidInitializationSettings('app_icon');
        var scheduledNotificationDateTime = orderDate.subtract(new Duration(minutes: 5));

        var androidPlatformChannelSpecifics = new AndroidNotificationDetails
        (
            'notif',
            'name',
            'description',
            color: Colors.brown,
            groupKey: "orderNotif",
            priority: Priority.High
        );

        var initSettingsIOS = new IOSInitializationSettings(onDidReceiveLocalNotification: (a,s,d,f,){});
        var initSettings = new InitializationSettings(andSettings, initSettingsIOS);
        _notifications.initialize(initSettings, onSelectNotification: (s){});
        var iOSPlatformChannelSpecifics = IOSNotificationDetails();

        NotificationDetails platformChannelSpecifics = NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
        await _notifications.schedule(
            0,
            title,
            body,
            scheduledNotificationDateTime,
            platformChannelSpecifics,
            androidAllowWhileIdle: true
        );  
    }
}