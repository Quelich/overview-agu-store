# Overview

<img src="https://raw.githubusercontent.com/Quelich/overview-agu-store/main/img/Screenshot_1644333250.png?token=GHSAT0AAAAAABQ7CPEMXQV5TFZMU5I74FV6YQL7M7Q" alt="drawing"  height="500" width="250"/>
<img src="https://github.com/Quelich/overview-agu-store/blob/main/img/Screenshot_1644333264.png?raw=true" alt="drawing"  height="500" width="250"/>
<img src="https://github.com/Quelich/overview-agu-store/blob/main/img/Screenshot_1644333277.png?raw=true" alt="drawing"  height="500" width="250"/>
<img src="https://github.com/Quelich/overview-agu-store/blob/main/img/Screenshot_1644333282.png?raw=true" alt="drawing"  height="500" width="250"/>
<img src="https://github.com/Quelich/overview-agu-store/blob/main/img/Screenshot_1644333264.png?raw=true" alt="drawing"  height="500" width="250"/>





# Purpose
- This project is essentially developed to draw a standard schema for e-commerce application development for Android platform.
- If you develop an e-commerce app for your business or college, this project could be handy.


# Features
- This project does not have an integrated payment API. So you can freely integrate your own choice of API.
- Create categories for products on Cloud Firestore to be shown on Home page.
- Create orders on Cart page.
- Authenticate your customers on Account page.
- Validate phone numbers via Abstract API. You can also make use of different APIs with respect to this implementation.
# Mobile Security Measures
- Disabled screenshots for particular view of the app to secure personal information.
# Contribute
- You are free to fork this project and develop your own e-commerce app with more beautiful layouts and features :)
- If you detect any problem related to this project. You can ticket an issue freely on Github.
# Learning Outcomes
- Using Dart programming language to develop layouts and organize data in Android platform.
- Using Google Firebase products, Cloud Firestore, Cloud Authentication, to maintain backend easily.
- Implementing Mobile Security measures to demonstrate how a mobile app can be secured.

# API Reference
- [Abstract API](https://www.abstractapi.com/)
# Setup
- Follow the steps accordingly.
## Version
- Make sure your IDE has the latest Flutter, Kotlin, Dart versions.
- Also make sure your Android SDK version is the latest.
## Firebase
- Navigate to [Firebase](https://firebase.google.com/) and create a Firebase project and update your config files including google-services.json
## Firestore
- You can integrate another API to retrieve products or you can retrieve products from Firestore like [this](https://raw.githubusercontent.com/Quelich/overview-agu-store/main/img/firestore-0.png?token=GHSAT0AAAAAABQ7CPEMN2C46NR3BV4CK5P4YQSEEKA)
## Pubspec.yaml
- You have to include the packages in [pubspec.yaml](https://github.com/Quelich/overview-agu-store/blob/main/pubspec.yaml)
## Mobile Security
### .env
- You need to create a [.env](https://raw.githubusercontent.com/Quelich/overview-agu-store/main/img/env-file.png?token=GHSAT0AAAAAABQ7CPEMP5NFFXA53BVZBRBCYQSDZMA) file to secure your api keys.
