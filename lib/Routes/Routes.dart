import 'package:corona_tracker/HomePage.dart';
import 'package:corona_tracker/Pages/FAQ.dart';
import 'package:corona_tracker/Widgets/CountryWidgets.dart';
import 'package:corona_tracker/Widgets/InformationWidgets.dart';
import 'package:flutter/material.dart';
import 'package:corona_tracker/Pages/FAQ.dart';

const String infoPage = "infoPage";
const String homepage = "homepage";
const String faq = "faq";
const String countryWidget = "countryWeidget";

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case homepage:
      return MaterialPageRoute(builder: (_) => HomePage());
    case infoPage:
      return MaterialPageRoute(builder: (_) => InformationWidgets());
    // if (settings.name is String) {
    //   return MaterialPageRoute(builder: (_) => InformationWidgets());
    case faq:
      return MaterialPageRoute(builder: (_) => Faq());
    case countryWidget:
      return MaterialPageRoute(builder: (_) => CountryWidgets());  
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
