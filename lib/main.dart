import 'package:agu_store_flutter/pages/accountpage.dart';
import 'package:agu_store_flutter/pages/cartpage.dart';
import 'package:agu_store_flutter/pages/homepage.dart';
import 'package:agu_store_flutter/pages/settingspage.dart';
import 'package:agu_store_flutter/providers/cart_provider.dart';
import 'package:agu_store_flutter/providers/email_signin_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:agu_store_flutter/utils/constants.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:developer' as dev;

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'This channel is used for important notifications.',
  importance: Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage msg) async {
  await Firebase.initializeApp();
  dev.log("A background message has been received: ${msg.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => EmailSignInProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
      ],
      child: OverlaySupport(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: kFontFamily1,
          ),
          home: const RootPage(),
        ),
      ),
    ),
  );
}

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RootPageState();
}

class RootPageState extends State<RootPage> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kRootAppBackground,
      appBar: getTopAppBar(),
      bottomNavigationBar: getBottomAppBar(),
      body: IndexedStack(
        index: activePageIndex,
        children: [
          HomePage(),
          ChangeNotifierProvider.value(
              value: CartProvider(), child: CartPage()),
          AccountPage(),
          SettingsPage(),
        ],
      ),
    );
  }

  // Reference to the active page index
  int activePageIndex = 0;
  late AppBar? appBar;

  // So, the top app bar can be easily customized by the pages
  PreferredSizeWidget? getTopAppBar() {
    switch (activePageIndex) {
      case 0:
        return appBar = null;
      case 1:
        return AppBar(
          elevation: 0.3,
          backgroundColor: kTopAppBarBackgroundColor,
          title: const Text(
            "CART",
            style: TextStyle(
              color: Colors.black,
              fontFamily: kFontFamily2,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        );
      case 2:
        return AppBar(
          elevation: 0.3,
          backgroundColor: kTopAppBarBackgroundColor,
          title: const Text(
            "ACCOUNT",
            style: TextStyle(
              color: Colors.black,
              fontFamily: kFontFamily2,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        );
      case 3:
        return AppBar(
          elevation: 0.3,
          backgroundColor: kTopAppBarBackgroundColor,
          title: const Text(
            "SETTINGS",
            style: TextStyle(
              color: Colors.black,
              fontFamily: kFontFamily2,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        );
      default:
    }
  }

  Widget getBottomAppBar() {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: kBottomAppbarBackgroundColor,
        border: Border(
          top: BorderSide(
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            kItemsTab.length,
            (index) {
              return IconButton(
                  icon: Icon(
                    kItemsTab[index]['icon'],
                    size: kItemsTab[index]['size'],
                    color: activePageIndex == index
                        ? kBottomAppbarIconsAccentColor
                        : kBottomAppbarIconsColor,
                  ),
                  onPressed: () {
                    setState(() {
                      activePageIndex = index;
                    });
                  });
            },
          ),
        ),
      ),
    );
  }
}
