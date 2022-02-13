import 'package:agu_store_flutter/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/product_ui.dart';
import '../services/product_db_connector.dart';

class ProductsOverviewScreen extends StatelessWidget {
  String categoryTitle;
  ProductsOverviewScreen(this.categoryTitle, {Key? key}) : super(key: key);

  final dbCategories = ProductDBConnector();

  @override
  Widget build(BuildContext context) {
    //24 is for notification bar on Android
    var screenSize = MediaQuery.of(context).size;
    final double itemHeight = (screenSize.height - kToolbarHeight) / 2;
    final double itemWidth = screenSize.width / 2;
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
        backgroundColor: kMainTheme,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          fontFamily: kFontFamily2,
        ),
      ),
      body: StreamBuilder(
        stream: dbCategories.getCategoryProducts(categoryTitle),
        builder: (
          BuildContext ctx,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          if (snapshot.hasError) {
            return const Text("Something went wrong :/");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading...");
          }
          final productsDocRef = snapshot.requireData;
          return GridView.builder(
            padding: const EdgeInsets.all(10.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: (itemWidth / itemHeight),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: productsDocRef.size,
            itemBuilder: (ctx, i) => ProductCard(
              productsDocRef.docs[i]['id'],
              productsDocRef.docs[i]['title'],
              productsDocRef.docs[i]['price'],
              productsDocRef.docs[i]['description'],
              productsDocRef.docs[i]['img'],
            ),
          );
        },
      ),
    );
  }
}
