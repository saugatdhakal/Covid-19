import 'package:flutter/material.dart';

class Search extends SearchDelegate {
  List worldData;
  Search({
    required this.worldData,
  });
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios_new));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionItem = query.isEmpty
        ? worldData
        : worldData
            .where((element) =>
                element['country'].toString().toLowerCase().startsWith(query))
            .toList();
    return ListView.builder(
        itemCount: suggestionItem.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: Card(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                height: 150,
                child: Row(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          FittedBox(
                            child: Text(
                              suggestionItem[index]['country'],
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Image.network(
                            suggestionItem[index]['countryInfo']['flag'],
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.35,
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
                              "Continent : " + suggestionItem[index]['continent'],
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          FittedBox(
                            child: Text(
                              "Population : " +
                                  suggestionItem[index]['population'].toString(),
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          FittedBox(
                            child: Text(
                                "Active : " +
                                    suggestionItem[index]['active'].toString(),
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          FittedBox(
                            child: Text(
                                "Deaths : " +
                                    suggestionItem[index]['active'].toString(),
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
}
