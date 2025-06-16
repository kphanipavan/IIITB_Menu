import "package:flutter/material.dart";
import "package:iiitb_menu/constants.dart";

class DocScreen extends StatelessWidget {
  const DocScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return Scaffold(
      appBar: AppBar(title: const Text("Campus Doc's Schedule (BETA)")),
      // body: Container(child: Text("${now.weekday}")),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                    child: Text("${docMap[index + 1]?[0].startTime}"));
              },
              childCount: docMap.length,
            ),
          ),
        ],
      ),
    );
  }
}
