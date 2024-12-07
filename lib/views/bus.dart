import "package:flutter/material.dart";
import "package:iiitb_menu/widgets/busCard.dart";
import "package:iiitb_menu/constants.dart";

class BusTimingsPage extends StatelessWidget {
  const BusTimingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guesture Bus Timings"),
      ),
      body: ListView.builder(
        itemCount: busTimimgs.length,
        itemBuilder: (BuildContext context, int index) {
          Map curSch = busTimimgs[index];
          return LeftBusCard(
              count: curSch["count"],
              loc: curSch["from"],
              time: curSch["time"]);
        },
      ),
    );
  }
}
