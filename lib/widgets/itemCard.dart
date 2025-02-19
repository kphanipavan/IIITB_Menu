// ignore_for_file: file_names, unnecessary_this

import "package:flutter/material.dart";
import "package:iiitb_menu/constants.dart";
import "package:iiitb_menu/widgets/vegIcons.dart";
import "package:iiitb_menu/models/imageSearch.dart";
import "package:url_launcher/url_launcher.dart";
import "package:provider/provider.dart";
import "package:iiitb_menu/models/globalModel.dart";

class ItemCard extends StatelessWidget {
  const ItemCard(
      {super.key,
      required this.itemName,
      required this.itemType,
      this.vegClass = VEG});
  final String itemName;
  final String itemType;
  final String vegClass;

  @override
  Widget build(BuildContext context) {
    Icon vegClassIcon;
    Color borderColor;
    switch (this.vegClass) {
      case VEG:
        vegClassIcon = vegIcon;
        borderColor = Colors.green.shade600;
        break;
      case EGG:
        vegClassIcon = eggIcon;
        borderColor = Colors.orange.shade700;
        break;
      case NONVEG:
        vegClassIcon = nonVegIcon;
        borderColor = Colors.red.shade600;
        break;
      default:
        vegClassIcon = vegIcon;
        borderColor = Colors.green;
    }
    if (this.itemName == EMPTY) {
      return Container();
    }
    return ElevatedButton(
      onPressed: Provider.of<GlobalModel>(context).search
          ? () {
              Provider.of<GlobalModel>(context, listen: false).disableSearch();
              launchUrl(getGoogleImageEncodedURL(itemName.toLowerCase()));
            }
          : null,
      style: ElevatedButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
        enableFeedback: true,
        disabledBackgroundColor: Colors.transparent,
        disabledForegroundColor: Colors.black,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.zero)),
        padding: const EdgeInsets.all(0),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          border: Border.all(width: 0.5, color: borderColor),
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(this.itemName, style: const TextStyle(fontSize: 25)),
            Text(this.itemType, style: const TextStyle(fontSize: 15)),
          ]),
          vegClassIcon,
        ]),
      ),
    );
  }
}
