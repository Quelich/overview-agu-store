import 'package:agu_store_flutter/utils/constants.dart';
import 'package:agu_store_flutter/widgets/category_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../main.dart';
import '../services/product_db_connector.dart';
import 'package:flutter/material.dart';

// This will return the products with given category id
// Because there are multiple categories
class CategoryOverviewScreen extends StatelessWidget {
  CategoryOverviewScreen({Key? key}) : super(key: key);
  final dbCategories = ProductDBConnector();

  @override
  Widget build(BuildContext context) {
    //24 is for notification bar on Android
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - 160 - kToolbarHeight) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RootPage()),
                );
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: const Text("Categories"),
        backgroundColor: kMainTheme,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          fontFamily: kFontFamily2,
        ),
      ),
      body: StreamBuilder(
        stream: dbCategories.getCategories(),
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
          final categoriesDocRef = snapshot.requireData;
          return GridView.builder(
            padding: const EdgeInsets.all(10.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: (itemWidth / itemHeight),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: categoriesDocRef.size,
            itemBuilder: (ctx, i) => CategoryCard(
              categoriesDocRef.docs[i]['id'],
              categoriesDocRef.docs[i]['label'],
              categoriesDocRef.docs[i]['img'],
            ),
          );
        },
      ),
    );
  }
}
