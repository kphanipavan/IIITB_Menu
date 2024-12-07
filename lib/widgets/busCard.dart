import "package:flutter/material.dart";
import "package:material_symbols_icons/symbols.dart";

class LeftBusCard extends StatelessWidget {
  const LeftBusCard({
    Key? key,
    required this.time,
    required this.count,
    required this.loc,
  }) : super(key: key);
  final String time;
  final int count;
  final String loc;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(this.time),
        Text("  From ${this.loc}"),
        Text("  x${this.count}"),
        Icon(Symbols.sprint_rounded),
      ],
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
  final String loc;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [Text("Current Bus:")]),
      ],
    );
  }
}

class LaterBusCard extends StatelessWidget {
  const LaterBusCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
