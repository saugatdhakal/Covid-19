import 'package:flutter/foundation.dart';

class CoronaFile {
  final int cases;
  final int active;
  final int recovered;
  final int deaths;

  CoronaFile(
    this.cases,
    this.active,
    this.recovered,
    this.deaths,
  );

  factory CoronaFile.fromJson(Map<String, dynamic> json) {
    return CoronaFile(
      json['cases'] ,
      json['active'] ,
      json['recovered'] ,
      json['deaths'],
    );
  }
}
