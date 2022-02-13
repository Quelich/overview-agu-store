import 'package:agu_store_flutter/providers/cart_provider.dart';
import 'package:agu_store_flutter/utils/constants.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;
import '../helpers/db_helper.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final String price;
  final String imageUrl;

  //TODO add thumbnail images for the product for scrollable images

  ProductDetailsScreen(
    this.id,
    this.title,
    this.description,
    this.price,
    this.imageUrl,
  );

  TextEditingController textdate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainTheme,
        centerTitle: true,
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: kFontFamily2,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.share,
            ),
            onPressed: () {
              Share.share('Product Cost is $price\n, $imageUrl');
            },
          )
        ],
        //actions <Widget>[IconButton(onPressed: (){},icon: Icon(Icons.share),),]
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              child: Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                const Text(
                  "Product Details",
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.black,
                    fontFamily: kFontFamily2,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 32,
                    color: Colors.black,
                    fontFamily: kFontFamily2,
                  ),
                ),
                Text(
                  "Price: $price TL",
                  style: const TextStyle(
                    fontSize: 28,
                    color: Colors.black,
                    fontFamily: kFontFamily2,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                dev.log("Request to add {item #$id  -  $title} to Cart");
                //cart.addItem(id, price, title, imageUrl);
                DBHelper.insert('cart_items', {
                  'id': id,
                  'title': title,
                  'price': price,
                  'imageUrl': imageUrl
                });
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$title Added Your Card')));
              },
              style: ElevatedButton.styleFrom(
                primary: kMainTheme,
                fixedSize: const Size(340, 50),
                shape: const StadiumBorder(),
              ),
              child: const Text(
                "Add to Cart",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: kFontFamily2,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
