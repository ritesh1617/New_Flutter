import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:grievance/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rxdart/rxdart.dart';
import '../theme/string.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

final didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final selectNotificationSubject = BehaviorSubject<String>();

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification(
      {required this.id,
      required this.title,
      required this.body,
      required this.payload});
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final firebaseMessaging = FirebaseMessaging.instance;

  initLocalNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    // final IOSInitializationSettings initializationSettingsIOS =
    // IOSInitializationSettings(
    //     requestAlertPermission: false,
    //     requestBadgePermission: false,
    //     requestSoundPermission: false,
    //     onDidReceiveLocalNotification: (
    //         int id,
    //         String? title,
    //         String? body,
    //         String? payload,
    //         ) async {
    //       didReceiveLocalNotificationSubject.add(
    //         ReceivedNotification(
    //           id: id,
    //           title: title!,
    //           body: body!,
    //           payload: payload!,
    //         ),
    //       );
    //     });

    // var initializationSettings = InitializationSettings(
    //     android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    // flutterLocalNotificationsPlugin.initialize(initializationSettings,
    //     onSelectNotification: (String? payload) async {
    //       if (payload != null) {
    //         debugPrint('notification payload: $payload');
    //       }
    //       //  selectedNotificationPayload = payload;
    //       selectNotificationSubject.add(payload!);
    //     });
    iosPermission();
  }

  @override
  void initState() {
    super.initState();

    initLocalNotification();
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      log("============================= get notification =============================");
      print(message);
      print(message.data);
      print(message.messageType);
      print(message.notification?.title);
      print(message.notification?.body);
      var title;
      var body;
      log("============================= get end =============================");
      //    if (Platform.isAndroid) {
      title = message.notification?.title;
      body = message.notification?.title;
      print("title: $message\n body: $body");
      //   }

      if (notification != null && android != null) {
        if (true) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              const NotificationDetails(
                android: AndroidNotificationDetails(
                  StringConstant.channelID,
                  StringConstant.channelName,
                  channelDescription: StringConstant.channelDesc,
                  // TODO add a proper drawable resource to android, for now using
                  //      one that already exists in example app.
                  icon: Images.logo,
                ),
              ));
        }
        didReceiveLocalNotificationSubject.add(
          ReceivedNotification(
            id: 1,
            title: title!,
            body: body!,
            payload: "payload",
          ),
        );
      } else if (Platform.isIOS) {
        if (true) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              title,
              body,
              NotificationDetails(
                  android: AndroidNotificationDetails(
                StringConstant.channelID,
                StringConstant.channelName,
                channelDescription: StringConstant.channelDesc,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: Images.logo,
              )));
        }
        didReceiveLocalNotificationSubject.add(
          ReceivedNotification(
            id: 1,
            title: title!,
            body: body!,
            payload: "payload",
          ),
        );
      }
    });
    firebaseMessaging.requestPermission(badge: true, alert: true);

    checkLogin();
    Timer(
        const Duration(seconds: 4),
        () => {
              if (isLogin)
                {moveToDashBoard()}
              else
                navigatorKey.currentState!.pushReplacementNamed(
                    RouteName.phoneAuthScreen,
                    arguments: 0)
            });
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;

    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: deviceWidth! - 100,
          child: Image.asset(
            Images.splash_icon,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    isLogin = ((prefs.getBool(Constants.isLogin) != null)
        ? prefs.getBool(Constants.isLogin)
        : false)!;
    isCreateProfile = ((prefs.getBool(Constants.isCreateProfile) != null)
        ? prefs.getBool(Constants.isCreateProfile)
        : false)!;
  }

  void moveToDashBoard() {
    if (isCreateProfile)
      navigatorKey.currentState!.pushReplacementNamed(RouteName.dashboardScreen);
    else
      navigatorKey.currentState!.pushReplacementNamed(RouteName.createProfileScreen,arguments: false);
  }

  void iosPermission() async {
    if (Platform.isIOS) {

      final bool? result = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );

    }
  }
}
