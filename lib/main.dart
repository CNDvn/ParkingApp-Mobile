import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/routes/routes.dart';
import 'package:parkingappmobile/view_model/providers/main_providers/main_providers.dart';
import 'package:provider/provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
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

  _registerOnFireBase() {
    messaging.subscribeToTopic("all");
    messaging.getToken().then((value) => print(value));
  }

  @override
  void initState() {
    // TODO: implement initState
    messaging = FirebaseMessaging.instance;
    _registerOnFireBase();
    // getMessage();
    super.initState();
  }

  void getMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      AndroidNotification? android = message.notification!.android;

      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      // if (message.notification != null) {
      //   print('Message also contained a notification: ${message.notification}');
      //   showDialog(
      //       context: context,
      //       builder: (BuildContext context) {
      //         return AlertDialog(
      //           title: Text("Notification"),
      //           content: Text(message.notification!.body!),
      //           actions: [
      //             TextButton(
      //               child: Text("Ok"),
      //               onPressed: () {
      //                 Navigator.of(context).pop();
      //               },
      //             )
      //           ],
      //         );
      //       });
      // }
      // setState(() {
      //   widget.message = message.notification!.body;
      // });
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
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
