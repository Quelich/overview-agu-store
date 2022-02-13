import 'package:agu_store_flutter/utils/constants.dart';
import 'package:flutter/material.dart';
import '../screens/products_overview.dart';
import 'dart:developer' as dev;

//TODO Parse category title -> remove '_' title[0] is uppercase
class CategoryCard extends StatelessWidget {
  final String id;
  final String title;
  final String img;

  CategoryCard(
    this.id,
    this.title,
    this.img,
  );

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: Container(
          height: kCategoriesHeight,
          width: kCategoriesWidth,
          child: GestureDetector(
            onTap: () {
              dev.log("Request to get category #$title data");
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductsOverviewScreen(title)),
              );
            },
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                img,
              ),
              fit: BoxFit.fill,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(
            title,
            style: const TextStyle(
              fontFamily: kFontFamily2,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
