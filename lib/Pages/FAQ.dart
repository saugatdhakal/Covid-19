import 'package:corona_tracker/DataSource.dart';
import 'package:flutter/material.dart';

class Faq extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FAQ"),
      ),
      body: ListView.builder(
          itemCount: DataSource.questionAnswers.length,
          itemBuilder: (context, index) {
            return ExpansionTile(
              title: Text(DataSource.questionAnswers[index]["question"],
                  style: TextStyle(fontWeight: FontWeight.bold)),
              children: [Text(DataSource.questionAnswers[index]["answer"])],
            );
          }),
    );
  }
}
