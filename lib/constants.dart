//ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

const String breakfast = "Breakfast";
const String lunch = "Lunch";
const String snak = "Snacks";
const String dinner = "Dinner";
const String VEG = "VEG";
const String NONVEG = "NON";
const String EGG = "EGG";
const String EMPTY = "Mt";
const String storageKey = "FullMenu";
const String appURL = "kphanipavan.github.io/IIITB_Menu";
const Center noMenuWidget = Center(
    child: Text("Menu not available for this session",
        style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic)));

const String hashLink =
    "https://raw.githubusercontent.com/kphanipavan/IIITB_Menu/menu_scraper/out.txt";

const String dataLink =
    "https://raw.githubusercontent.com/kphanipavan/IIITB_Menu/menu_scraper/out.json";

enum DataStatus { Loaded, Loading, NotFound }

Widget newNoMenuWidget = Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text("Menu not available for this session",
          style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
      RichText(
        text: const TextSpan(
          children: [
            TextSpan(text: "Click "),
            WidgetSpan(child: Icon(Icons.update_rounded)),
            TextSpan(text: " to check for updates.")
          ],
          style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
        ),
      ),
    ],
  ),
);

Uri ghURI = Uri.parse("https://github.com/kphanipavan/IIITB_Menu");
Uri excelSheetURI = Uri.parse(
    "https://iiitbac-my.sharepoint.com/:x:/g/personal/foodcommittee_iiitb_ac_in/ESrcRZMPYFpOgk2VEPd0zd8BDfsMkTUXWM4hRi-2QNF44g?e=fjFkFy");

const String guesture = "Guesture";
const String college = "College";

const List<Map<String, dynamic>> busTimimgs = [
  {"time": "07.30AM", "count": 2, "from": guesture},
  {"time": "07.45AM", "count": 1, "from": guesture},
  {"time": "08.20AM", "count": 2, "from": guesture},
  {"time": "08.45AM", "count": 1, "from": guesture},
  {"time": "09.15AM", "count": 1, "from": guesture},
  {"time": "09.30AM", "count": 1, "from": guesture},
  {"time": "10.30AM", "count": 1, "from": guesture},
  {"time": "11.00AM", "count": 1, "from": guesture},
  {"time": "11.30AM", "count": 1, "from": college},
  {"time": "01.15PM", "count": 1, "from": college},
  {"time": "02.15PM", "count": 1, "from": college},
  {"time": "03.15PM", "count": 1, "from": college},
  {"time": "03.45PM", "count": 1, "from": college},
  {"time": "04.15PM", "count": 1, "from": college},
  {"time": "05.30PM", "count": 1, "from": college},
  {"time": "06.15PM", "count": 1, "from": college},
  {"time": "07.15PM", "count": 1, "from": college},
  {"time": "08.15PM", "count": 1, "from": college},
  {"time": "09.15PM", "count": 1, "from": college},
  {"time": "10.15PM", "count": 1, "from": college},
];
