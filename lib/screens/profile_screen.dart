import 'package:agu_store_flutter/providers/email_signin_provider.dart';
import 'package:agu_store_flutter/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;
import 'package:provider/provider.dart';

import 'account_details_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userEmail = user?.email;
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 2),
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Column(
                    children: [
                      Text(
                        userEmail! + "  Logged in",
                        maxLines: 3,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: kFontFamily2,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 30.0,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 15.0,
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: kAccountPageOptions.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Account Details button
                              if (index == 0) {
                                dev.log("Pressed " +
                                    kAccountPageOptions[index].toString());
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const AccountDetailsScreen()),
                                );
                              }

                              // Log out Button
                              if (index == kAccountPageOptions.length - 1) {
                                final provider =
                                    Provider.of<EmailSignInProvider>(context,
                                        listen: false);
                                provider.signOut();
                                dev.log("Pressed " +
                                    kAccountPageOptions[index].toString());
                              }
                            },
                            child: Text(
                              kAccountPageOptions[index],
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontFamily: kFontFamily2,
                              ),
                            ),
                          ),
                          Icon(
                            kForwardSign,
                            color: Colors.black.withOpacity(0.5),
                            size: 22,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
