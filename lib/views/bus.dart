import "package:flutter/material.dart";
import "package:iiitb_menu/widgets/busCard.dart";
import "package:iiitb_menu/constants.dart";
import "package:intl/intl.dart";
import "dart:math" as math;

class BusTimingsPage extends StatelessWidget {
  const BusTimingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat timeFromat = DateFormat("h.ma");
    int leftBusses = -1;
    int currentBusIndex = -1;
    DateTime currentTime = DateTime.now();
    // DateTime currentTime = timeFromat.parse("09.45PM");
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
    // print("$leftBusses  $currentBusIndex, $currentTimeInt");
    return Scaffold(
      appBar: AppBar(
        title: const Text("College Bus Timings (BETA)"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child:
                (leftBusses != 0) ? const Header("Past Busses") : Container(),
          ),
          DecoratedSliver(
            decoration: const BoxDecoration(
              boxShadow: [kBusCardBlur],
              color: Color(0x30ff0000),
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, index) {
                  final int itemIndex = index % 2;
                  if (itemIndex.isEven) {
                    Map curSch = busTimimgs[(index / 2).floor()];
                    return PastBusCard(
                        count: curSch["count"],
                        loc: curSch["routes"],
                        time: curSch["time"]);
                  } else {
                    return const Divider(height: 1, color: Color(0x30ff0000));
                  }
                },
                childCount: math.max(0, 2 * leftBusses - 1),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: currentBusIndex >= 0
                ? NextBusCard(
                    count: busTimimgs[currentBusIndex]["count"],
                    loc: busTimimgs[currentBusIndex]["routes"],
                    time: busTimimgs[currentBusIndex]["time"],
                  )
                : Container(),
          ),
          SliverToBoxAdapter(
            child: (currentBusIndex >= 0)
                ? const Header("Later Busses")
                : const Header("No Busses Left for Today"),
          ),
          DecoratedSliver(
            decoration: const BoxDecoration(
              color: Color(0x3000ff00),
              boxShadow: [kBusCardBlur],
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, index) {
                  final int itemIndex = index % 2;
                  if (itemIndex.isEven) {
                    Map curSch =
                        busTimimgs[(index / 2).floor() + leftBusses + 1];
                    // DateTime curTime = timeFromat.parse(curSch["time"]);
                    // int curTimeInt = curTime.hour * 60 + curTime.minute;
                    return LaterBusCard(
                        count: curSch["count"],
                        loc: curSch["routes"],
                        time: curSch["time"]);
                  } else {
                    return const Divider(height: 1, color: Color(0x30005a00));
                  }
                },
                childCount: (2 * (busTimimgs.length - leftBusses - 1)) - 1,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}
