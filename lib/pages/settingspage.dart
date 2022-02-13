import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/constants.dart';
import 'dart:developer' as dev;
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _secureMode = false;
  bool? _jailbroken;
  bool? _developerMode;
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }
  Future<void> initPlatformState() async {
    bool jailbroken;
    bool developerMode;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      jailbroken = await FlutterJailbreakDetection.jailbroken;
      developerMode = await FlutterJailbreakDetection.developerMode;
    } on PlatformException {
      jailbroken = true;
      developerMode = true;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _jailbroken = jailbroken;
      _developerMode = developerMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: kSettingsPageOptions.length,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        dev.log("Pressed " +
                            kSettingsPageOptions[index].toString());
                      },
                      child: Text(
                        kSettingsPageOptions[index],
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
            const SizedBox(
              height: 15,
            ),
            Text('Secure Mode: ${_secureMode.toString()}\n'),
            ElevatedButton(
              onPressed: () async {
                final secureModeToggle = !_secureMode;

                if (secureModeToggle == true) {
                  await FlutterWindowManager.addFlags(
                      FlutterWindowManager.FLAG_SECURE);
                } else {
                  await FlutterWindowManager.clearFlags(
                      FlutterWindowManager.FLAG_SECURE);
                }

                setState(() {
                  _secureMode = !_secureMode;
                });
              },
              child: const Text("Toggle Secure Mode"),
            ),
            const SizedBox(
              height: 15,
            ),
            Text('Jailbroken: ${_jailbroken == null ? "Unknown" : _jailbroken! ? "YES" : "NO"}'),
            Text('Developer mode: ${_developerMode == null ? "Unknown" : _developerMode! ? "YES" : "NO"}')
          ],
        ),
      ),
    );
  }
}
