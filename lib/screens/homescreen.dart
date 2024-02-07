import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String notificationMsg = "This is a Notification";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      if (event != null) {
        setState(() {
          notificationMsg =
              "${event.notification!.title} ${event.notification!.body} this is a terminated push notification";
        });
      }
    });
    FirebaseMessaging.onMessage.listen((event) {
      setState(() {
        notificationMsg =
            "${event.notification!.title} ${event.notification!.body} this is a forground push notification";
      });
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      setState(() {
        notificationMsg =
            "${event.notification!.title} ${event.notification!.body} this is a background push notification";
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
