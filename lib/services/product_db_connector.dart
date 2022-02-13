import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as dev;

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductDBConnector
{
  static const _collectionLabel = 'categories';
  // Get an individual category's products
  Stream<QuerySnapshot>? getCategoryProducts(String categoryTitle)
  {
    if(categoryTitle.isEmpty) {
      return null;
    }
    categoryTitle = categoryTitle.toLowerCase();
    Stream<QuerySnapshot> products = FirebaseFirestore.instance.collection("/categories/$categoryTitle/products").snapshots();
    dev.log("$categoryTitle products data has been retrieved successfully!");
    return products;
  }

  // Get categories from the database
  Stream<QuerySnapshot>? getCategories()
  {
    Stream<QuerySnapshot> categories = FirebaseFirestore.instance.collection("categories").snapshots();
    dev.log("Category data has been retrieved successfully!");
    return categories;
  }

  
  
}