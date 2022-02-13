import 'package:agu_store_flutter/helpers/db_helper.dart';
import 'package:agu_store_flutter/providers/cart_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../utils/constants.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:developer' as dev;

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ),
          );
        }
      },
    );
  }

  int getTotalPrice() {
    return Provider.of<CartProvider>(context, listen: false).getTotalPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCartPageBackground,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: FutureBuilder(
          future: Provider.of<CartProvider>(context, listen: false)
              .fetchAndSetItems(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<CartProvider>(
                  builder: (ctx, cartProviderItem, ch) {
                    return Column(
                      children: [
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: cartProviderItem.items.length,
                            itemBuilder: (ctx, index) {
                              final item = cartProviderItem.items[index];
                              return Dismissible(
                                key: Key(item.id),
                                background: Container(color: Colors.red),
                                onDismissed: (direction) {
                                  // Remove the item from the data source.
                                  setState(
                                    () {
                                      dev.log("Performing removing " + item.title);
                                      DBHelper.deleteItem(item.id);
                                    },
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('${item.title} removed')));
                                },
                                child: ListTile(
                                  leading: Container(
                                    height: 200,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          cartProviderItem
                                              .items[index].imageUrl,
                                        ),
                                      ),
                                    ),
                                  ),
                                  subtitle: Text(
                                    cartProviderItem.items[index].price + " \$",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: kFontFamily2,
                                    ),
                                  ),
                                  title: Text(
                                    cartProviderItem.items[index].title,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: kFontFamily2,
                                    ),
                                  ),
                                ),
                              );
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Total Price: ${getTotalPrice()} \$",
                          style: const TextStyle(
                            fontSize: 22,
                            fontFamily: kFontFamily2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  },
                ),
        ),
      ),
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () {
            dev.log("Performing a schedule notification!");
            flutterLocalNotificationsPlugin.show(
              0, //do not change this value
              "AGU STORE",
              "WE GOT YOUR ORDER",
              NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    channelDescription: channel.description,
                    importance: Importance.high,
                    color: Colors.blue,
                    playSound: true,
                    styleInformation: const BigPictureStyleInformation(
                      DrawableResourceAndroidBitmap("@mipmap/ic_launcher"),
                      largeIcon:
                          DrawableResourceAndroidBitmap("@mipmap/ic_launcher"),
                      htmlFormatContent: true,
                      htmlFormatContentTitle: true,
                    ),
                    icon: '@mipmap/ic_launcher'),
              ),
            );
            DBHelper.deleteAllItems();
          },
          child: const Text("Order"),
          style: ElevatedButton.styleFrom(
            primary: kMainTheme,
            fixedSize: const Size(340, 50),
            shape: const StadiumBorder(),
            textStyle: const TextStyle(
              fontFamily: kFontFamily2,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}
