import "package:flutter/material.dart";
// import "package:material_symbols_icons/symbols.dart";

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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      color: const Color(0x30ff0000),
      child: Row(
        children: [
          Text(time, style: const TextStyle(fontSize: 20)),
          Text("  From $loc", style: const TextStyle(fontSize: 20)),
          // Text("  x${this.count}"),
          // Icon(Symbols.sprint_rounded),
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
  final String loc;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Header("Next Bus"),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          color: const Color(0xa3ffac12),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "$time\nFrom $loc",
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
  final String loc;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      color: const Color(0x3000ff00),
      child: Row(
        children: [
          Text(time, style: const TextStyle(fontSize: 20)),
          Text("  From $loc", style: const TextStyle(fontSize: 20)),
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
