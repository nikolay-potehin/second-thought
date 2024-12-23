import 'dart:io';

import 'package:appcheck/appcheck.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final appCheck = AppCheck();

  List<AppInfo>? installedApps;
  List<AppInfo> iOSApps = [
    AppInfo(appName: "Calendar", packageName: "calshow://"),
    AppInfo(appName: "Facebook", packageName: "fb://"),
    AppInfo(appName: "Whatsapp", packageName: "whatsapp://"),
  ];

  @override
  void initState() {
    getApps();
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> getApps() async {
    if (Platform.isAndroid) {
      const package = "com.google.android.apps.maps";
      installedApps = await appCheck.getInstalledApps();
      debugPrint(installedApps.toString());

      // await appCheck.checkAvailability(package).then(
      //       (app) => debugPrint(app.toString()),
      //     );

      // await appCheck.isAppEnabled(package).then(
      //       (enabled) => enabled ? debugPrint('$package enabled') : debugPrint('$package disabled'),
      //     );

      installedApps?.sort(
        (a, b) => a.appName!.toLowerCase().compareTo(b.appName!.toLowerCase()),
      );
    } else if (Platform.isIOS) {
      // iOS doesn't allow to get installed apps.
      installedApps = iOSApps;

      await appCheck.checkAvailability("calshow://").then(
            (app) => debugPrint(app.toString()),
          );
    }

    setState(() {
      installedApps = installedApps;
    });
  }

  @override
  Widget build(BuildContext context) {
    const columnCount = 3;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Second Thought', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  GestureDetector(
                    onTap: () => print('tap'),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.settings, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            if (installedApps == null)
              const Center(child: Text('No apps were found'))
            else
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: installedApps!.length + 1,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columnCount, crossAxisSpacing: columnCount * 2, mainAxisSpacing: columnCount * 2),
                  itemBuilder: (context, index) {
                    if (index == installedApps!.length) {
                      return card('+');
                    }

                    final appInfo = installedApps![index];
                    return card(appInfo.packageName);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Container card(String item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Text(
          item,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
      ),
    );
  }
}
