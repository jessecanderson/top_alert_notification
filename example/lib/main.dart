import 'package:flutter/material.dart';
import 'package:top_alert_notification/top_alert_notification.dart';
// import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  final String url = "www.google.com";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Spacer(),
          Center(
            child: ElevatedButton(
              child: Text("Press Me"),
              onPressed: () => {
                TopAlertNotification(
                  context,
                  Text(
                    "Please take a short feedback survey",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  closeOnX: true,
                  onTap: printTest,
                  color: const Color(0xFFF79912),
                ).showTopAlert()
              },
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  void printTest() async {
    // if (await canLaunch(url)) {
    //   await launch(url);
    // }
  }
}
