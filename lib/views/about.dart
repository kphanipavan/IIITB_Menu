import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About Page")),
      body: const Column(
        children: [
          Image(image: AssetImage("assets/plate.png")),
          Text(
            "IIIT Bangalore Unofficial Mess Menu",
            style: TextStyle(fontSize: 50),
          )
        ],
      ),
    );
  }
}
