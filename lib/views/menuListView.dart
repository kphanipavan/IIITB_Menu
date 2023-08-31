// ignore_for_file: unnecessary_this, file_names

import 'package:flutter/material.dart';
import 'package:iiitb_menu/models/globalModel.dart';
import 'package:iiitb_menu/widgets/itemCard.dart';
import 'package:provider/provider.dart';

class MenuListView extends StatelessWidget {
  const MenuListView({super.key, required this.menuType});
  final String menuType;

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalModel>(
      builder: (BuildContext context, GlobalModel data, Widget? child) {
        // print(data.date);
        // print(data.mainData["dates"][data.date]);
        String menuIndex = data.mainData["dates"][data.date];
        return ListView.builder(
            itemCount: data.mainData["items"][this.menuType].length,
            itemBuilder: (BuildContext context, int index) {
              String itemType = data.mainData["items"][this.menuType][index];
              String itemName = data.mainData["menu"][menuIndex][this.menuType]
                  [itemType]["name"];
              String itemVeggness = data.mainData["menu"][menuIndex]
                  [this.menuType][itemType]["eggy"];
              return ItemCard(
                itemName: itemName,
                itemType: itemType,
                vegClass: itemVeggness,
              );
            });
      },
    );
  }
}
