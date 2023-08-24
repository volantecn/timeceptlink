import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
///本地通知发送工厂类

class NotificationFactory{

  static final NotificationFactory _singleton = NotificationFactory._internal();

  factory NotificationFactory() {
    return _singleton;
  }

  NotificationFactory._internal();

  static const channelId = '123';

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();



  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
        macOS: null);

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,);

    debugPrint("本地消息初始化完成。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。");
  }


  AndroidNotificationDetails _androidNotificationDetails =
  AndroidNotificationDetails(
    channelId,
    'TimeCeptLink',

    playSound: true,
    priority: Priority.high,
    importance: Importance.high,
  );


  Future<void> showNotifications(String title,String content) async {


    await flutterLocalNotificationsPlugin.show(
      123,
      title,
      content,
      NotificationDetails(android: _androidNotificationDetails),
    );

    //debugPrint("显示消息完成。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。");
  }

}