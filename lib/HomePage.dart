import 'dart:convert';

import 'package:corona_tracker/Models/coronaFile.dart';
import 'package:corona_tracker/Widgets/MostAffecetedWidget.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:corona_tracker/DataSource.dart';

import 'Models/MostAffectedCountries.dart';
import 'Widgets/WorldWidgets.dart';

import 'Routes/Routes.dart' as route;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

final Widget announcement = Card(
  elevation: 5,
  margin: EdgeInsets.all(10),
  child: Container(
    color: Colors.orange[100],
    padding: EdgeInsets.all(10),
    child: Text(
      DataSource.quote,
      style: TextStyle(
          color: Colors.orange, fontSize: 15.0, fontWeight: FontWeight.w500),
    ),
  ),
);

class _HomePageState extends State<HomePage> {
  CoronaFile? worldData;

  // fetchWorldWideData() async {
  //   // All data is content as Map and should to convert to Json file ...
  //  var response = await http.get(Uri.parse(postsURL));
  //   worldData = jsonDecode(response.body);
  //   // String format is convert to map format or json format...
  // }
  final String postsURL = "https://corona.lmao.ninja/v3/covid-19/all";
  Future<CoronaFile> getPosts() async {
    final response = await http.get(Uri.parse(postsURL));
    final jsonData = jsonDecode(response.body);
    // print(jsonData);
    // List<CoronaFile> users = [];
    // for (var item in jsonData) {
    //   CoronaFile file = CoronaFile(
    //       item['cases'], item['active'], item['recovered'], item['deaths']);
    //   users.add(file);
    // }

    // print(users);
    // print("worldData :-" + worldData.toString());
    return CoronaFile.fromJson(jsonData);
  }

  final String allCountryURL =
      "https://corona.lmao.ninja/v3/covid-19/countries";

  Future<List<MostAffectedCountry>> worldListGetPosts() async {
    var response = await http.get(Uri.parse(allCountryURL));
    var jsonData = jsonDecode(response.body);
    List<MostAffectedCountry> details = [];

    for (var u in jsonData) {
      if (u['country'] == "Nepal" ||
          u['country'] == "USA" ||
          u['country'] == "China" ||
          u['country'] == "India" ||
          u['country'] == "Australia" ||
          u['country'] == "Canada" ||
          u['country'] == "Germany") {
        MostAffectedCountry data = MostAffectedCountry(
            flag: u['countryInfo']['flag'],
            countryName: u['country'],
            death: u['deaths']);
        details.add(data);
      }
    }
    print(details.length);

    return details;
  }

  void loadData() async {
    worldData = await getPosts();

    // mostAffecetedList = worldListGetPosts() as List;
    // print(mostAffecetedList);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadData();
  }

  // final theme = MediaQuery.of(context).platformBrightness == Brightness.dark?
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Corona Tracker"),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, route.infoPage),
              icon: Icon(Icons.help_outline_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            announcement,
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                width: 20,
              ),
              Text(
                "WordWide Panel",
                style: TextStyle(
                    color: MediaQuery.of(context).platformBrightness ==
                            Brightness.dark
                        ? Colors.white
                        : primaryBlack,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
              ),
              RaisedButton(
                color:
                    MediaQuery.of(context).platformBrightness == Brightness.dark
                        ? Colors.indigo[400]
                        : primaryBlack,
                textColor: Colors.white,
                onPressed: () =>
                    Navigator.pushNamed(context, route.countryWidget),
                child: Text(
                  "Countries",
                  style: TextStyle(fontSize: 18),
                ),
              )
            ]),
            worldData == null
                ? CircularProgressIndicator()
                : WorldWidget(worldData) // Map of data sended into Widgets
            ,
            Row(
              children: [
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.050,
                ),
                FittedBox(
                  child: Text(
                    "Seven Selected Countries",
                    style: TextStyle(
                        color: MediaQuery.of(context).platformBrightness ==
                                Brightness.dark
                            ? Colors.white
                            : primaryBlack,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "(Scroll For More)",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                )
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.380,
              child: FutureBuilder(
                  future: worldListGetPosts(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Column(children: [
                        CircularProgressIndicator(),
                        Text("Loading......")
                      ]);
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: 7, //snapshot.data.length,
                        itemBuilder: (context, index) {
                          return MostAffecetedWidget(
                              flag: snapshot.data[index].flag,
                              countryName: snapshot.data[index].countryName,
                              death: snapshot.data[index].death.toString());
                        },
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
