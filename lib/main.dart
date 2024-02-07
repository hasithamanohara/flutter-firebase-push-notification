import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutternotification/firebase_options.dart';
import 'package:flutternotification/screens/homescreen.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print("this is background message");
  print(message.notification!.title);
  print(message.notification!.body);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(const PushNotification());
}

class PushNotification extends StatelessWidget {
  const PushNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}
