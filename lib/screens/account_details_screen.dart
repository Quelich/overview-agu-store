import 'package:agu_store_flutter/services/phone_val_api.dart';
import 'package:agu_store_flutter/utils/constants.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:overlay_support/overlay_support.dart';

class AccountDetailsScreen extends StatefulWidget {
  const AccountDetailsScreen({Key? key}) : super(key: key);

  @override
  _AccountDetailsScreenState createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final phoneController = TextEditingController();

  String? avatarImg;

  @override
  void initState() {

    super.initState();

    firstnameController.addListener(() {
      setState(() {});
    });
    lastnameController.addListener(() {
      setState(() {});
    });
    phoneController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Account Details"),
        backgroundColor: kMainTheme,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                Card(
                  margin: const EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: firstnameController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(
                            labelText: "Firstname",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: lastnameController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(
                            labelText: "Lastname",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: "Phone",
                            prefixIcon: Icon(Icons.phone),
                            hintText: "+901234567890",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () async {
                    dev.log("Performing user data submit to firestore!");
                    dev.log("firstname:" + firstnameController.text);
                    dev.log("lastname:" + lastnameController.text);
                    dev.log("phone:" + phoneController.text);
                    final response = await PhoneValidationApi()
                        .validatePhone(phoneController.text);
                    dev.log("phone validation: $response");
                    showSimpleNotification(
                      response == true
                          ? const Text("Your phone number is validated")
                          : const Text("Your phone number is not validated"),
                      background: kMainTheme,
                      autoDismiss: false,
                      trailing: Builder(builder: (context) {
                        return TextButton(
                          onPressed: () {
                            OverlaySupportEntry.of(context)?.dismiss();
                          },
                          child: const Text(
                            'Dismiss',
                            style: TextStyle(
                              color: Colors.yellow,
                            ),
                          ),
                        );
                      }),
                    );
                    //TODO send user data to firestore
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    primary: kMainTheme,
                    fixedSize: const Size(
                      340,
                      50,
                    ),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: kFontFamily2,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
