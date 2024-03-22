import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hydrolink_testing/firebase_options.dart';
import 'package:hydrolink_testing/pages/auth_page.dart';
import 'package:hydrolink_testing/theme/theme.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request permission to receive notifications
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  // Get the Firebase Cloud Messaging device token
  String deviceToken = await messaging.getToken() ?? 'null';
  print(deviceToken);

  final messengerKey = GlobalKey<ScaffoldMessengerState>();

  runApp(MyApp(messengerKey: messengerKey, token: deviceToken));
}

String _tokenGlobal = '';

void showNotification(
  BuildContext context,
  GlobalKey<ScaffoldMessengerState> messengerKey,
  String title,
  String body,
) {
  messengerKey.currentState!.showSnackBar(
    SnackBar(
      content: Text('$title: $body'),
    ),
  );
}

Future<void> backgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

class PushNotificationService {
  FirebaseMessaging _fcm = FirebaseMessaging.instance;

  final _localNotification = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        String title = message.notification!.title ?? 'Title';
        String body = message.notification!.body ?? 'Title';
        print('Message also contained a notification: ${title}');
        print('Message also contained a notification: ${body}');
        _localNotification.show(
          0,
          title,
          body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'channel id',
              'channel name',
              importance: Importance.max,
              priority: Priority.high,
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    // Get the token
    await getToken();
  }

  Future<String?> getToken() async {
    String? token = await _fcm.getToken();
    print('Token: $token');
    _tokenGlobal = token! == null ? 'NoToken' : token;
    return token;
  }
}

class MyApp extends StatelessWidget {
  final PushNotificationService _notificationService =
      PushNotificationService();
  final String token;
  MyApp({Key? key, required this.messengerKey, required this.token})
      : super(key: key);

  final GlobalKey<ScaffoldMessengerState> messengerKey;

  @override
  Widget build(BuildContext context) {
    _notificationService.initialize();
    return MaterialApp(
      home: AuthPage(token: token),
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      scaffoldMessengerKey: messengerKey,
    );
  }
}
