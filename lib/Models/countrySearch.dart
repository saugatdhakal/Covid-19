class CountrySearch {
  String flag;
  String countryName;
  String continent;
  int death;
  int active;
  int population;
  CountrySearch({
    required this.flag,
    required this.countryName,
    required this.continent,
    required this.death,
    required this.active,
    required this.population,
  });

  Map<String, dynamic> toMap() {
    return {
      'flag': flag,
      'country': countryName,
      'continent': continent,
      'deaths': death,
      'active' : active,
      'population' : population
    };
  }




}