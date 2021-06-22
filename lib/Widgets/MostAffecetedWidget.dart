import 'package:flutter/material.dart';

import 'package:corona_tracker/Models/MostAffectedCountries.dart';

class MostAffecetedWidget extends StatelessWidget {
  String? flag;
  String? countryName;
  String? death;
  MostAffecetedWidget({
    required this.flag,
    required this.countryName,
    required this.death,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              Image.network(
                flag!,
                height: 40,
              ),
              SizedBox(
                width: 10,
              ),
              Text(countryName!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(
                width: 10,
              ),
              Text("Deaths:${death!}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.red)),
            ],
          )),
    );
  }
}
