// ignore_for_file: unnecessary_this, file_names

import 'package:flutter/material.dart';
import 'package:iiitb_menu/constants.dart';
import 'package:iiitb_menu/models/globalModel.dart';
import 'package:iiitb_menu/widgets/itemCard.dart';
import 'package:provider/provider.dart';
// import "package:auto_size_text/auto_size_text.dart";

class MenuListView extends StatelessWidget {
  const MenuListView({super.key, required this.menuType});
  final String menuType;

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalModel>(
      builder: (BuildContext context, GlobalModel data, Widget? child) {
        DataStatus dataStatus = data.menuAvailable;
        if (dataStatus == DataStatus.Loading) {
          return const Center(
              child: Text("Updating...", style: TextStyle(fontSize: 40)));
        } else if (dataStatus == DataStatus.NotFoundNOUpdate) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("No menu found online for this session. ",
                    style:
                        TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
                Text("Please check back later",
                    style:
                        TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
              ],
            ),
          );
        }
        String menuIndex = data.mainData["dates"][data.date];
        Map timings =
            data.mainData["menu"][menuIndex]["${this.menuType}Timings"];
        return ListView(
          children: [
            Center(
              child: Text(
                  "Starts: ${timings['start']}, Ends: ${timings['end']}",
                  style: const TextStyle(fontSize: 15)),
            ),
            ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: data.mainData["items"][this.menuType].length,
                itemBuilder: (BuildContext context, int index) {
                  String itemType =
                      data.mainData["items"][this.menuType][index];
                  String itemName = data.mainData["menu"][menuIndex]
                      [this.menuType][itemType]["name"];
                  String itemVeggness = data.mainData["menu"][menuIndex]
                      [this.menuType][itemType]["eggy"];
                  return ItemCard(
                    itemName: itemName,
                    itemType: itemType,
                    vegClass: itemVeggness,
                  );
                }),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox(
                height: 80,
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                // Expanded(
                //   child: AutoSizeText(
                //     "Lookup an Item in Google Image Search ->",
                //     textAlign: TextAlign.right,
                //     maxLines: 1,
                //     minFontSize: 16,
                //   ),
                // ),
                //     SizedBox(width: 75),
                //   ],
                // ),
              ),
            ),
          ],
        );
      },
    );
  }
}
