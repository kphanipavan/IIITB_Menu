import 'package:flutter/material.dart';
import "package:iiitb_menu/constants.dart";
import "package:url_launcher/url_launcher.dart";

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About")),
      body: Column(
        children: [
          const Flexible(
            child: Padding(
              padding: EdgeInsets.only(left: 100, right: 100, top: 50),
              child: Image(image: AssetImage("assets/plate.png")),
            ),
          ),
          const Center(
            child: Text(
              "IIIT Bangalore's Unofficial Menu App",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 50,
              ),
            ),
          ),
          const Center(
            child: Text("Proud Ass Web 1.0 App built with Flutter"),
          ),
          const Center(
            child: Text(
                "Menu updates every other Tuesday or when FoodComm does it."),
          ),
          InkWell(
              child:
                  const Image(image: AssetImage("assets/gh.png"), height: 20),
              onTap: () async {
                if (await canLaunchUrl(ghURI)) {
                  launchUrl(ghURI);
                }
              }),
        ],
      ),
    );
  }
}
