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
const Center noMenuWidget = Center(
    child: Text("Menu not available for this session",
        style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic)));

const String hashLink =
    "https://raw.githubusercontent.com/kphanipavan/IIITB_Menu/menu_scraper/out.txt";

const String dataLink =
    "https://raw.githubusercontent.com/kphanipavan/IIITB_Menu/menu_scraper/out.json";
