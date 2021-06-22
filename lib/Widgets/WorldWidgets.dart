

import 'package:corona_tracker/Models/coronaFile.dart';
import 'package:flutter/material.dart';



class WorldWidget extends StatelessWidget {
  CoronaFile? worldDatas;


  WorldWidget(
    this.worldDatas,
  );

  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 2),
        children: [
          WorldStatusWidgets(Colors.red[100]!, Colors.red, "CONFIRMED",
              worldDatas!.cases.toString()),
          WorldStatusWidgets(Colors.indigo[100]!, Colors.indigo, "ACTIVE",
              worldDatas!.active.toString()),
          WorldStatusWidgets(Colors.black38, Colors.white70, "RECOVERED",
              worldDatas!.recovered.toString()),
          WorldStatusWidgets(Colors.blueGrey[200]!, Colors.blueGrey, "DEATHS",
              worldDatas!.deaths.toString()),
        ],
      ),
    );
  }
}

class WorldStatusWidgets extends StatelessWidget {
  late final Color panelColors;
  final Color textColor;
  final String title;
  final String count;

  WorldStatusWidgets(
    this.panelColors,
    this.textColor,
    this.title,
    this.count,
  );
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(5),
      color: panelColors,
      child: Container(
        margin: EdgeInsets.all(10),
        height: 80,
        width: deviceWidth / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
            Text(
              count,
              style: TextStyle(
                  color: textColor, fontWeight: FontWeight.bold, fontSize: 17),
            )
          ],
        ),
      ),
    );
  }
}
