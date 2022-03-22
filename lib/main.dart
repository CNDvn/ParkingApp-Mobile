import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:parkingappmobile/configs/routes/routes.dart';
import 'package:parkingappmobile/view/notification/notification_service.dart';
import 'package:parkingappmobile/view_model/providers/main_providers/main_providers.dart';
import 'package:parkingappmobile/view_model/service/service_storage.dart';
import 'package:provider/provider.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  log("message ID: " + message.messageId!);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);
  String? message;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late FirebaseMessaging messaging;
  final SecureStorage secureStorage = SecureStorage();
  _registerOnFireBase() {
    messaging.subscribeToTopic("all");
    messaging.getToken().then((value) async {
      await secureStorage.writeSecureData("deviceToken", value!);
    });
  }

  @override
  void initState() {
    messaging = FirebaseMessaging.instance;
    _registerOnFireBase();
    getMessage();

    super.initState();
  }

  void getMessage() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('Channel_id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification notification = message.notification!;
      // ignore: unused_local_variable
      AndroidNotification? android = message.notification!.android;
      if (message.notification != null) {
        await NotificationService().flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            platformChannelSpecifics,
            payload: 'item x');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) async {});
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: MainProviders.providers,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Parking App',
          theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "OpenSans"),
          initialRoute: "/",
          routes: Routes.routes),
    );
  }
}
