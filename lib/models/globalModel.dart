// ignore_for_file: unnecessary_this, file_names

import "dart:convert";
import "dart:io";
import "package:iiitb_menu/constants.dart";
// import "package:path_provider/path_provider.dart";
// import 'dart:io';
import "package:flutter/material.dart";
import "package:crypto/crypto.dart";
import "package:http/http.dart";
import "package:intl/intl.dart";
import "package:shared_preferences/shared_preferences.dart";

class GlobalModel extends ChangeNotifier {
  late Map<dynamic, dynamic> mainData;
  DateTime currentDate = DateTime.now();
  String menuTime = breakfast;
  bool menuAvailable = false;

  GlobalModel() {
    print("In constructor");
    GlobalModel.loadData().then((value) {
      mainData = value;
      if (this.mainData["dates"].keys.contains(this.date)) {
        this.menuAvailable = true;
      }
      // print(mainData);
      notifyListeners();
    });
  }

  static Future<String> getLatestHash() async {
    const String hashLink = "http://10.0.2.2:8000/out.txt";
    try {
      Response ret = await get(Uri.parse(hashLink));
      if (ret.statusCode == 200) {
        return ret.body.replaceAll("\n", "");
      } else {
        return "";
      }
    } on SocketException catch (exce) {
      print("Unable to download hash");
      print(exce);
      return "";
    }
  }

  static Future<String> getLatestData() async {
    const String dataLink = "http://10.0.2.2:8000/out.json";
    try {
      Response ret = await get(Uri.parse(dataLink));
      return ret.body;
    } on SocketException catch (exce) {
      print("Unable to download any data");
      print(exce);
      return "";
    }
  }

  static Future<Map> loadData() async {
    late Map returnData;
    // Directory appDir = await getApplicationDocumentsDirectory();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? rawData;
    String rawHash;
    // String fileName = "${appDir.path}/menu.json";
    // print(fileName);
    // File fileLink = File(fileName);
    rawData = prefs.getString(storageKey);
    print(rawData);
    if (rawData != null) {
      print("data found");
      // rawData = localStor.getItem("fullMenu");
      rawHash = md5.convert(utf8.encode(rawData)).toString();
      print("Hash of Raw Data:");
      print(rawHash);
      // print("RawData: ");
      // print(rawData);
      returnData = jsonDecode(rawData);
      // menuAvailable = true;
    } else {
      print("File Not Found");
      returnData = {};
      rawHash = "";
    }
    String remoteHash = await GlobalModel.getLatestHash();
    if (remoteHash == "") {
    } else if (remoteHash == rawHash) {
      // print("Remote hash $remoteHash is same as local hash $rawHash");
    } else {
      // print("Remote hash $remoteHash is NOT the same as local hash $rawHash");
      // print("Getting data from remote");
      rawData = await getLatestData();
      if (rawData == "") {
        return {};
      }
      returnData = jsonDecode(rawData);
      // fileLink.writeAsStringSync(rawData, mode: FileMode.write);
      prefs.setString(storageKey, rawData);
    }

    return returnData;
  }

  String get date {
    return DateFormat("dd-MM-yyyy").format(this.currentDate);
  }

  void incrDate() {
    this.currentDate = this.currentDate.add(const Duration(days: 1));
    this.isMenuAvailable();
    notifyListeners();
  }

  void decrDate() {
    this.currentDate = this.currentDate.add(const Duration(days: -1));
    this.isMenuAvailable();
    notifyListeners();
  }

  void setMenuTime(int time) {
    switch (time) {
      case 0:
        this.menuTime = breakfast;
        notifyListeners();
        break;
      case 1:
        this.menuTime = lunch;
        notifyListeners();
        break;
      case 2:
        this.menuTime = snak;
        notifyListeners();
        break;
      case 3:
        this.menuTime = dinner;
        notifyListeners();
        break;
      default:
    }
  }

  void isMenuAvailable() {
    if (this.mainData["dates"].keys.contains(this.date)) {
      this.menuAvailable = true;
    } else {
      this.menuAvailable = false;
    }
  }

  void setDateToToday() {
    this.currentDate = DateTime.now();
    this.isMenuAvailable();
    notifyListeners();
  }
}
