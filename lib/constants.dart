//ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import "package:iiitb_menu/models/busModels.dart";

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
    "https://raw.githubusercontent.com/kphanipavan/IIITB_Menu/refs/heads/menu_scraper/out.txt";

const String dataLink =
    "https://raw.githubusercontent.com/kphanipavan/IIITB_Menu/refs/heads/menu_scraper/out.json";

enum DataStatus { Loaded, Loading, NotFound, NotFoundNOUpdate }

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

const Location uniworld = Location("Uniworld", "UNW");
const Location college = Location("College", "CLG");

const BusRoute u2c = BusRoute(uniworld, college);
const BusRoute c2u = BusRoute(college, uniworld);

const List<Map<String, dynamic>> busTimimgs = [
  {
    "time": "07.00AM",
    "count": 1,
    "routes": [u2c]
  },
  {
    "time": "07.30AM",
    "count": 1,
    "routes": [u2c]
  },
  {
    "time": "08.00AM",
    "count": 1,
    "routes": [u2c]
  },
  {
    "time": "08.30AM",
    "count": 1,
    "routes": [u2c]
  },
  {
    "time": "09.00AM",
    "count": 1,
    "routes": [u2c]
  },
  {
    "time": "09.30AM",
    "count": 1,
    "routes": [u2c]
  },
  {
    "time": "10.30AM",
    "count": 1,
    "routes": [u2c]
  },
  {
    "time": "11.30AM",
    "count": 1,
    "routes": [u2c]
  },
  {
    "time": "12.30PM",
    "count": 1,
    "routes": [c2u, u2c]
  },
  {
    "time": "01.30PM",
    "count": 1,
    "routes": [c2u, u2c]
  },
  {
    "time": "02.30PM",
    "count": 1,
    "routes": [c2u, u2c]
  },
  {
    "time": "03.30PM",
    "count": 1,
    "routes": [u2c]
  },
  {
    "time": "04.00PM",
    "count": 1,
    "routes": [c2u]
  },
  {
    "time": "04.30PM",
    "count": 1,
    "routes": [u2c]
  },
  {
    "time": "05.00PM",
    "count": 1,
    "routes": [c2u]
  },
  {
    "time": "05.30PM",
    "count": 1,
    "routes": [u2c]
  },
  {
    "time": "06.00PM",
    "count": 1,
    "routes": [c2u]
  },
  {
    "time": "06.30PM",
    "count": 1,
    "routes": [u2c]
  },
  {
    "time": "07.00PM",
    "count": 1,
    "routes": [c2u]
  },
  {
    "time": "07.30PM",
    "count": 1,
    "routes": [u2c]
  },
  {
    "time": "08.00PM",
    "count": 1,
    "routes": [c2u]
  },
  {
    "time": "09.00PM",
    "count": 1,
    "routes": [u2c]
  },
  {
    "time": "09.30PM",
    "count": 1,
    "routes": [c2u]
  },
  {
    "time": "10.30PM",
    "count": 1,
    "routes": [c2u]
  },
  {
    "time": "11.30PM",
    "count": 1,
    "routes": [c2u]
  },
];

const BoxShadow kBusCardBlur = BoxShadow(
  color: Colors.black54,
  blurRadius: 3,
  blurStyle: BlurStyle.outer,
);
