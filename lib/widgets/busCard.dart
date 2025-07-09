import "package:flutter/material.dart";
import "package:iiitb_menu/constants.dart";
import "package:iiitb_menu/models/busModels.dart";

class PastBusCard extends StatelessWidget {
  const PastBusCard({
    Key? key,
    required this.time,
    required this.count,
    required this.loc,
  }) : super(key: key);
  final String time;
  final int count;
  final List<BusRoute> loc;
  @override
  Widget build(BuildContext context) {
    List<String> buses = [];
    for (BusRoute b in loc) {
      final String arst = "${b.from.shortName}→${b.to.shortName}";
      buses.add(arst);
    }
    final String busString = buses.join(", ");
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      // color: const Color(0x30ff0000),
      child: Row(
        children: [
          Text(time, style: const TextStyle(fontSize: 20)),
          Text(": $busString", style: const TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}

// use icons.directions_walk, icons.directions_run and symbols.sprint_rounded for icon states
class NextBusCard extends StatelessWidget {
  const NextBusCard({
    Key? key,
    required this.time,
    required this.count,
    required this.loc,
  }) : super(key: key);
  final String time;
  final int count;
  final List<BusRoute> loc;
  @override
  Widget build(BuildContext context) {
    List<String> buses = [];
    late final busString;
    if (loc.isNotEmpty) {
      for (BusRoute b in loc) {
        final String arst = "\n${b.from.fullName}→${b.to.shortName}";
        buses.add(arst);
      }
      busString = buses.join(", ");
    } else {
      busString = "\nNo Busses";
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Header("Next Bus"),
        Container(
          decoration: const BoxDecoration(
            color: Color(0xa3ffac12),
            boxShadow: [kBusCardBlur],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          // color: const Color(0xa3ffac12),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "At $time$busString",
                style: const TextStyle(fontSize: 50),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LaterBusCard extends StatelessWidget {
  const LaterBusCard({
    Key? key,
    required this.time,
    required this.count,
    required this.loc,
  }) : super(key: key);
  final String time;
  final int count;
  final List<BusRoute> loc;
  @override
  Widget build(BuildContext context) {
    List<String> buses = [];
    for (BusRoute b in loc) {
      final String arst = "${b.from.shortName}→${b.to.shortName}";
      buses.add(arst);
    }
    final String busString = buses.join(", ");
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      // color: const Color(0x3000ff00),
      child: Row(
        children: [
          Text(time, style: const TextStyle(fontSize: 20)),
          Text(" $busString", style: const TextStyle(fontSize: 20)),
          // Text("  x${this.count}"),
          // Icon(Symbols.sprint_rounded),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header(this.text, {Key? key}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 30),
      ),
    );
  }
}
