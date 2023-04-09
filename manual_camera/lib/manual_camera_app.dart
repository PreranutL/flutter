import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manual_camera/page/home_page.dart';
import 'package:provider/single_child_widget.dart';
import 'constants/routes.dart';

class ManualCameraApp extends StatefulWidget {
  ManualCameraApp({super.key});

  @override
  _ManualCameraAppState createState() {
    return _ManualCameraAppState();
  }
}

class _ManualCameraAppState extends State<ManualCameraApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final providers = <SingleChildWidget>[];

    return MaterialApp(
      title: 'Manual Camera',
      color: Theme.of(context).backgroundColor,
      routes: Routes.routes,
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
