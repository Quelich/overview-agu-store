import 'package:agu_store_flutter/screens/product_details_screen.dart';
import 'package:agu_store_flutter/utils/constants.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class ProductCard extends StatelessWidget {
  final String id;
  final String title;
  final String price;
  final String description;
  final String imageUrl;

  ProductCard(
    this.id,
    this.title,
    this.price,
    this.description,
    this.imageUrl,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductDetailsScreen(id, title, description, price, imageUrl)),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 3,
            child: SizedBox(
              height: kFeaturedHeight,
              child: Container(
                width: kFeaturedWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: SizedBox(
              width: kFeaturedWidth,
              height: kFeaturedHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 2,
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontFamily: kFontFamily2,
                          fontWeight: FontWeight.bold,
                          color: kFeaturedFontColor,
                          height: 1.5,
                          fontSize: kProductCardTitleSize),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: Text(
                            price.toString(),
                            style: const TextStyle(
                              fontFamily: kFontFamily2,
                              fontWeight: FontWeight.bold,
                              color: kBottomAppbarIconsAccentColor,
                              height: 1.5,
                              fontSize: kProductCardTitleSize - 1,
                            ),
                          ),
                        ),
                        const Flexible(
                          flex: 2,
                          child: Text(
                            " TL",
                            style: TextStyle(
                              fontFamily: kFontFamily2,
                              fontWeight: FontWeight.bold,
                              color: kBottomAppbarIconsAccentColor,
                              height: 1.5,
                              fontSize: kProductCardTitleSize - 3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
