import 'package:agu_store_flutter/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/auth_screen.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return const ProfileScreen();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Something Went Wrong!"),
            );
          } else {
            return const AuthScreen();
          }
        },
      ),
    );
  }
}
