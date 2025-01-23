import "package:flutter/material.dart";
import "package:iiitb_menu/widgets/busCard.dart";
import "package:iiitb_menu/constants.dart";
import "package:intl/intl.dart";

class BusTimingsPage extends StatelessWidget {
  const BusTimingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat timeFromat = DateFormat("h.ma");
    int leftBusses = -1;
    int currentBusIndex = -1;
    // DateTime currentTime = DateTime.now();
    DateTime currentTime = timeFromat.parse("09.45PM");
    int currentTimeInt = currentTime.hour * 60 + currentTime.minute;
    for (int i = 0; i < busTimimgs.length; i++) {
      Map curSch = busTimimgs[i];
      DateTime curBusTime = timeFromat.parse(curSch["time"]);
      int curBusTimeInt = curBusTime.hour * 60 + curBusTime.minute;
      if (currentTimeInt < curBusTimeInt) {
        leftBusses = i;
        currentBusIndex = i;
        break;
      }
    }
    if (leftBusses < 0) {
      leftBusses = busTimimgs.length;
      // currentBusIndex = busTimimgs.length - 1;
    }
    print("$leftBusses  $currentBusIndex, $currentTimeInt");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Guesture Bus Timings (BETA)"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
              child: (leftBusses != 0)
                  ? const Header("Past Busses")
                  : Container()),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, index) {
                Map curSch = busTimimgs[index];
                DateTime curTime = timeFromat.parse(curSch["time"]);
                int curTimeInt = curTime.hour * 60 + curTime.minute;
                return LeftBusCard(
                    count: curSch["count"],
                    loc: curSch["from"],
                    time: curSch["time"]);
              },
              childCount: leftBusses,
            ),
          ),
          SliverToBoxAdapter(
            child: currentBusIndex >= 0
                ? NextBusCard(
                    count: busTimimgs[currentBusIndex]["count"],
                    loc: busTimimgs[currentBusIndex]["from"],
                    time: busTimimgs[currentBusIndex]["time"],
                  )
                : Container(),
          ),
          SliverToBoxAdapter(
            child: (currentBusIndex >= 0)
                ? const Header("Later Busses:")
                : const Header("No Busses Left for Today"),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, index) {
                Map curSch = busTimimgs[index + leftBusses + 1];
                DateTime curTime = timeFromat.parse(curSch["time"]);
                int curTimeInt = curTime.hour * 60 + curTime.minute;
                return LaterBusCard(
                    count: curSch["count"],
                    loc: curSch["from"],
                    time: curSch["time"]);
              },
              childCount: busTimimgs.length - leftBusses - 1,
            ),
          ),
        ],
      ),
    );
  }
}
