import 'dart:convert';

import 'package:corona_tracker/Models/CountryData.dart';
import 'package:corona_tracker/Pages/searchCountry.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CountryWidgets extends StatefulWidget {
  @override
  _CountryWidgetsState createState() => _CountryWidgetsState();
}

class _CountryWidgetsState extends State<CountryWidgets> {
  final String allCountryURL =
      "https://corona.lmao.ninja/v3/covid-19/countries";

  Future<List<CountryData>> getWorldList() async {
    final response = await http.get(Uri.parse(allCountryURL));
    final jsonData = jsonDecode(response.body);

    List<CountryData> countryList = [];
    for (var index in jsonData) {
      CountryData data = CountryData(
          flag: index['countryInfo']['flag'],
          countryName: index['country'],
          continent: index['continent'],
          death: index['deaths'],
          active: index['active'],
          population: index['population']);
      countryList.add(data);
    }
    
    return countryList;
  }

  List newList = [];

  getWorldData() async {
    final response = await http.get(Uri.parse(allCountryURL));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      this.newList = (jsonData as List);
      
    } else {
      print("No Input");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWorldData();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context, delegate: Search(worldData: newList));
              },
              icon: Icon(Icons.search))
        ],
        title: Text("World Covid-19 Report"),
      ),
      body: Container(
        child: FutureBuilder(
          future: getWorldList(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    Text("Loading......"),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      child: Card(
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          height: 150,
                          child: Row(
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    FittedBox(
                                      child: Text(
                                        snapshot.data[index].countryName,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Image.network(
                                      snapshot.data[index].flag,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FittedBox(
                                      child: Text(
                                        "Continent : " +
                                            snapshot.data[index].continent,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    FittedBox(
                                      child: Text(
                                        "Population : " +
                                            snapshot.data[index].population
                                                .toString(),
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    FittedBox(
                                      child: Text(
                                          "Active : " +
                                              snapshot.data[index].active
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    FittedBox(
                                      child: Text(
                                          "Deaths : " +
                                              snapshot.data[index].death
                                                  .toString(),
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
