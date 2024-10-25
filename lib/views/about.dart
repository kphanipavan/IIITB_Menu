import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About")),
      body: const Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 100, right: 100, top: 50),
            child: Image(image: AssetImage("assets/plate.png")),
          ),
          Center(
            child: Text(
              "IIIT Bangalore's Unofficial Menu App",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 50,
              ),
            ),
          ),
          Center(
            child: Text("Proud Ass Web 1.0 App built with Flutter"),
          ),
          Center(
            child: Text(
                "Menu updates every other Tuesday or when FoodComm does it."),
          )
        ],
      ),
    );
  }
}
