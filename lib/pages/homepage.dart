import 'dart:async';

import 'package:agu_store_flutter/screens/products_overview.dart';
import 'package:flutter/material.dart';
import 'package:agu_store_flutter/utils/constants.dart';
import '../screens/category_overview.dart';
import '../services/product_db_connector.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'dart:developer' as dev;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: getHomePageBody(),
    );
  }

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      dev.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  final dbCategories = ProductDBConnector();

  Widget getHomePageBody() {
    var size = MediaQuery.of(context).size;
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Stack(
          children: [
            Container(
              width: size.width,
              height: kHomeImgHeight,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(kHomeImg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  IconButton(
                    onPressed: () {
                      dev.log("request to search");

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Connection Status: ${_connectionStatus.toString()}'),
                        ),
                      );
                    },
                    icon: const Icon(kSearchButtonIcon),
                    iconSize: kTopAppBarIconsSize,
                    color: kTopAppBarIconsColor,
                    hoverColor: Colors.black,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            dev.log(
                                "Request to get agu_special collection data");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProductsOverviewScreen("agu_special")),
                            );
                          },
                          child: const Text(
                            "Discover $kHomePageImgCategory",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: kHomePageImgTitleSize,
                                color: kHomePageImgTitleColor,
                                fontFamily: kFontFamily1,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Icon(
                          kForwardSign,
                          color: kHomePageImgTitleColor,
                          size: kHomePageImgTitleSize,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Categories",
                style: TextStyle(
                    fontSize: kCategoriesFontSize,
                    fontFamily: kFontFamily2,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      dev.log("User wants to see all categories");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryOverviewScreen()),
                      );
                    },
                    child: const Text(
                      "See all",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: kCategoriesFontSize,
                        fontFamily: kFontFamily2,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    kForwardSign,
                    color: Colors.grey,
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        //TODO each category should return the corresponding products
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(kCategories.length, (index) {
              return SizedBox(
                width: kCategoriesWidth,
                height: kCategoriesHeight,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(kCategories[index]['imgUrl']),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black.withOpacity(0.0),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                        child: Text(
                          kCategories[index]['title'],
                          style: const TextStyle(
                            color: kCategoriesFontColor,
                            fontSize: kCategoriesFontSize,
                            fontFamily: kFontFamily2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Featured",
                style: TextStyle(
                    fontSize: kCategoriesFontSize,
                    fontFamily: kFontFamily2,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      dev.log("User wants to see all featured products");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProductsOverviewScreen("featured")),
                      );
                    },
                    child: const Text(
                      "See all",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: kCategoriesFontSize,
                        fontFamily: kFontFamily2,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    kForwardSign,
                    color: Colors.grey,
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(kFeatured.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: kFeaturedWidth,
                      height: kFeaturedHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(kFeatured[index]['imgUrl']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: kFeaturedWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            kFeatured[index]['title'],
                            style: const TextStyle(
                                fontFamily: kFontFamily2,
                                fontWeight: FontWeight.bold,
                                color: kFeaturedFontColor,
                                height: 1.5,
                                fontSize: kProductCardTitleSize),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: [
                              Text(
                                kFeatured[index]['price'],
                                style: const TextStyle(
                                  fontFamily: kFontFamily2,
                                  fontWeight: FontWeight.bold,
                                  color: kBottomAppbarIconsAccentColor,
                                  height: 1.5,
                                  fontSize: kProductCardTitleSize - 1,
                                ),
                              ),
                              const Text(
                                " TL",
                                style: TextStyle(
                                  fontFamily: kFontFamily2,
                                  fontWeight: FontWeight.bold,
                                  color: kBottomAppbarIconsAccentColor,
                                  height: 1.5,
                                  fontSize: kProductCardTitleSize - 3,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
