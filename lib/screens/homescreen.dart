import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutternotification/service/localnotifications.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String notificationMsg = "This is a Notification";
  String? mtoken = " ";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermission();
    getToken();

    LocalNotificationService.initialize();

    //terminated status
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      if (event != null) {
        setState(() {
          notificationMsg =
              "${event.notification!.title} ${event.notification!.body} terminated state";
        });
      }
    });

    //foreground notification
    FirebaseMessaging.onMessage.listen((event) {
      setState(() {
        notificationMsg =
            "${event.notification!.title} ${event.notification!.body} from forground";
      });
    });

    //backgrond
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      LocalNotificationService.showNotificationOnForeground(event);
      setState(() {
        notificationMsg =
            "${event.notification!.title} ${event.notification!.body} from background";
      });
    });
  }


  //request get for send notifications
  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  //get token
  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Push Notification",
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text(
          notificationMsg,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
