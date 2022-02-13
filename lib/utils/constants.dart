import 'package:flutter/material.dart';

// APP
const String kAppTitle = 'AGU STORE';
const String kFontFamily1 = 'Open Sans';
const String kFontFamily2 = 'Exo 2';
const Color kMainTheme = Color(0xffff0000);
const int kMainThemeColorHex = 0xffff1d1d;

// HOMEPAGE
const double kHomeImgHeight = 500;
const double kHomePageImgTitleSize = 22.0;
const Color kHomePageImgTitleColor = Color(0xffffffff);
const IconData kForwardSign = Icons.arrow_forward_ios_outlined;
// This category is supposed to be customizable
const String kHomePageImgCategory = "AGU Collection";

// HOMEPAGE -> CATEGORIES
const double kCategoriesFontSize = 20;
const Color kCategoriesFontColor = Color(0xffffffff);
const double kCategoriesWidth = 180;
const double kCategoriesHeight = 220;

// HOMEPAGE -> FEATURED as ProductCard
const Color kFeaturedFontColor = Color(0xff000000);
const double kFeaturedWidth = 180;
const double kFeaturedHeight = 240;
const double kProductCardTitleSize = 16;

// CARTPAGE
const Color kCartPageBackground = Color(0xffffffff);
const Color kCartPagePromotionColor = Color(kMainThemeColorHex);
const double kCartPageWidth = 140;
const double kCartPageHeight = 180;
const IconData kRemoveSign = Icons.remove_outlined;
const IconData kAddSign = Icons.add_outlined;
// ACCOUNT PAGE
const kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

const kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: kFontFamily1,
);

final kBoxDecorationStyle = BoxDecoration(
  color: const Color(0xFFFFFFFf),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: const [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
const kFacebookLogo = "https://github.com/MarcusNg/flutter_login_ui/blob/master/assets/logos/facebook.jpg?raw=true";
const kGoogleLogo = "https://github.com/MarcusNg/flutter_login_ui/blob/master/assets/logos/google.jpg?raw=true";
// ROOT APP
const Color kRootAppBackground = Color(0xffffffff);

// TOP BAR
const Color kTopAppBarBackgroundColor = Color(0xffffffff);
const Color kTopAppBarIconsColor = Color(0xffffffff);
const IconData kSearchButtonIcon = Icons.search_outlined;
const IconData kAuthButton = Icons.login_outlined;
const double kTopAppBarIconsSize = 35;

// BOTTOM BAR
const double kBottomBarIconsSize = 35;
const Color kBottomAppbarBackgroundColor = Color(0xffffffff);
const Color kBottomAppbarIconsColor = Color(0xff000000);
const Color kBottomAppbarIconsAccentColor = Color(kMainThemeColorHex);
const IconData kHomePageIcon = Icons.home_outlined;
const IconData kShoppingCartIcon = Icons.shopping_cart_outlined;
const IconData kAccountIcon = Icons.account_circle_outlined;
const IconData kSettingsIcon = Icons.settings_outlined;

// CATEGORIES
const List<Map<String, dynamic>> kCategories = [
  {
    'title': 'Men',
    'imgUrl': 'https://images.unsplash.com/photo-1529809773508-cd894c3de760?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bWVuJTIwY2xvdGhpbmd8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
  },
  {
    'title': 'Women',
    'imgUrl': 'https://media.istockphoto.com/photos/the-perfect-dress-for-me-picture-id660490044?b=1&k=20&m=660490044&s=170667a&w=0&h=JadgZcpyNQJymDjgztzC5CCg2UsCGoS9XYEv04TSHNw=',
  },
  {
    'title': 'Souvenir',
    'imgUrl': 'https://images.unsplash.com/photo-1593607563703-358c52f28688?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8c291dmVuaXJ8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
  },
  {
    'title': 'Book',
    'imgUrl': 'https://images.unsplash.com/photo-1548092176-dff0757b8ee6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjMyfHxib29rfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
  },
  {
    'title': 'Furniture',
    'imgUrl': 'https://images.unsplash.com/photo-1618220179428-22790b461013?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fGZ1cm5pdHVyZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60',
  },
];

// HOMEPAGE
//TODO select kHomeImg randomly from a database
const String kHomeImg = 'https://images.unsplash.com/flagged/photo-1561338484-01bbb4026c7a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80';
const String kSplashScreen = 'data:image/png;base64,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';

// BOTTOM BAR ITEMS
const List kItemsTab = [
  {"icon": kHomePageIcon, "size": kBottomBarIconsSize},
  {"icon": kShoppingCartIcon, "size": kBottomBarIconsSize},
  {"icon": kAccountIcon, "size": kBottomBarIconsSize},
  {"icon": kSettingsIcon, "size": kBottomBarIconsSize},
];


// FEATURED PRODUCTS
const List<Map<String, dynamic>> kFeatured = [
  {
    'title': 'Summer Loose Korean T-shirt',
    'price': '30',
    'imgUrl': 'https://images.unsplash.com/photo-1581044777550-4cfa60707c03?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
  },
  {
    'title': 'Bat Sleeve Student T-shirt Summer',
    'price': '35',
    'imgUrl': 'https://images.unsplash.com/photo-1545291730-faff8ca1d4b0?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mjd8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
  },
  {
    'title': 'Summer New Korean Version',
    'price': '25',
    'imgUrl': 'https://images.unsplash.com/photo-1562572159-4efc207f5aff?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=60',
  },
  {
    'title': 'Loose-fitting Outside Shirt',
    'price': '30',
      'imgUrl': 'https://images.unsplash.com/photo-1503185912284-5271ff81b9a8?ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60',
  },
  {
    'title': 'Cotton Short-sleeved T-shirt',
    'price': '20',
    'imgUrl': 'https://images.unsplash.com/photo-1541257710737-06d667133a53?ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60',
  }
];

// PRODUCTS IN THE CART
const List kCart = [
  {
    "img":
    "https://images.unsplash.com/photo-1495385794356-15371f348c31?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
    "name": "Snoopy T-shirt",
    "ref": "04559812",
    "price": "40 TL",
    "size": "S"
  },
  {
    "img":
    "https://images.unsplash.com/photo-1545291730-faff8ca1d4b0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
    "name": "American",
    "ref": "04459811",
    "price": "30 TL",
    "size": "M"
  },
];

// USER PROFILE
const String kUserProfile = 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1170&q=80';

// ACCOUNT PAGE OPTIONS
const List kAccountPageOptions = [
  'Account Details',
  'Addresses',
  'Orders',
  'My Lists',
  'Credit/Debit Cards',
  'AGU Store Wallet',
  'Delivery Information',
  'Payment Information',
  'Log out',
];

// SETTINGS PAGE OPTIONS
const List kSettingsPageOptions = [
  'Notification Settings',
  'Language',
  'Give Us Feedback',
  'Privacy Settings',
  'About Us',
];
const String kSettingsMsg = "https://images.unsplash.com/photo-1495106245177-55dc6f43e83f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzF8fGhhcHB5JTIwYmFubmVyfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60";
const String kAccountMsg = "https://images.pexels.com/photos/7564223/pexels-photo-7564223.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260";
