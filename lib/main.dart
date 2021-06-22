import 'package:corona_tracker/DataSource.dart';

import 'package:flutter/material.dart';

import 'Routes/Routes.dart' as route;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        
        fontFamily: 'Circular',
        primaryColor: primaryBlack,
      ),
      initialRoute: route.homepage,
      onGenerateRoute: route.controller,
    );
  }
}
