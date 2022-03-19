import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/routes/routes.dart';
import 'package:parkingappmobile/view/notification/notification_page.dart';
import 'package:parkingappmobile/view_model/providers/main_providers/main_providers.dart';
import 'package:parkingappmobile/view_model/service/service_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  print("message ID: " + message.messageId!);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

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
    // TODO: implement initState
    messaging = FirebaseMessaging.instance;
    _registerOnFireBase();
    getMessage();
    super.initState();
  }

  void getMessage() async {
    final prefes = await SharedPreferences.getInstance();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification notification = message.notification!;
      AndroidNotification? android = message.notification!.android;
      if (message.notification != null) {
        List<String>? noti = await prefes.getStringList("notification");
        if (noti == null) {
          noti = <String>[];
        }
        noti.add(message.notification!.title! +
            "|" +
            message.notification!.body! +
            "|" +
            message.sentTime.toString());

        await prefes.setStringList("notification", noti);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      List<String>? noti = await prefes.getStringList("notification");
      if (noti == null) {
        noti = <String>[];
      }
      noti.add(message.notification!.title! +
          "|" +
          message.notification!.body! +
          "|" +
          message.sentTime.toString());
      await prefes.setStringList("notification", noti);
    });
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
