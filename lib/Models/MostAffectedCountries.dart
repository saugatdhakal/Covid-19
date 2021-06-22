import 'dart:convert';

class MostAffectedCountry {
  String flag;
  String countryName;
  int death;
  MostAffectedCountry({
    required this.flag,
    required this.countryName,
    required this.death,
  });

  Map<String, dynamic> toMap() {
    return {
      'flag': flag,
      'country': countryName,
      'deaths': death,
    };
  }

  factory MostAffectedCountry.fromMap(Map<String, dynamic> map) {
    return MostAffectedCountry(
      flag: map['countryInfo']['flag'],
      countryName: map['country'],
      death: map['deaths'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MostAffectedCountry.fromJson(String source) => MostAffectedCountry.fromMap(json.decode(source));
}
