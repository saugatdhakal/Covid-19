import 'package:flutter/material.dart';
import 'package:corona_tracker/Pages/FAQ.dart';
const String faq = "faq";

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case faq:
      return MaterialPageRoute(builder: (_) => Faq());
    default:
      return _errorRoute();
  }
}
Route<dynamic> _errorRoute() {
  return MaterialPageRoute(builder: (_) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Error Route"),
      ),
      body: Center(
        child: Text("Error on Route"),
      ),
    );
  });
}