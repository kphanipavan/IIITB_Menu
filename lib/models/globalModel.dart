// ignore_for_file: unnecessary_this, file_names, library_prefixes

import "dart:convert";
import "package:iiitb_menu/constants.dart";
// import "package:path_provider/path_provider.dart";
import 'dart:io';
import "package:flutter/material.dart";
import "package:crypto/crypto.dart";
import "package:http/http.dart";
import "package:intl/intl.dart";
import "package:shared_preferences/shared_preferences.dart";
// import "package:dio/dio.dart";
// import "package:iiitb_menu/data.dart" as menuData;

class GlobalModel extends ChangeNotifier {
  late Map<dynamic, dynamic> mainData;
  DateTime currentDate = DateTime.now();
  String menuTime = breakfast;
  DataStatus menuAvailable = DataStatus.Loading;

  GlobalModel() {
    print("In constructor");
    GlobalModel.loadData().then((value) {
      mainData = value;
      if (this.mainData["dates"].keys.contains(this.date)) {
        this.menuAvailable = DataStatus.Loaded;
      }
      // print(mainData);
      notifyListeners();
    });
  }

  static Future<String> getLatestHash() async {
    try {
      Response hashRequest = await get(Uri.parse(hashLink));
      // Response ret = await Dio().request(hashLink,
      //     options: Options(method: 'GET', headers: {
      //       HttpHeaders.acceptHeader: "text/plain",
      //       "Access-Control-Allow-Origin": "*",
      //       "Access-Control-Allow-Methods": "GET",
      //       "Access-Control-Allow-Headers": "*",
      //       "Access-Control-Max-Age": "1000"
      //     }));
      if (hashRequest.statusCode == 200) {
        return hashRequest.body.replaceAll("\n", "");
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
    try {
      // Response ret = await Dio().request(dataLink,
      //     options: Options(method: "GET", headers: {
      //       HttpHeaders.acceptHeader: "text/plain",
      //       "Access-Control-Allow-Origin": "*"
      //     }));
      Response dataRequest = await get(Uri.parse(dataLink));
      return dataRequest.body;
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
      print("Data Not Found");
      returnData = {};
      rawHash = "";
    }
    String remoteHash = await GlobalModel.getLatestHash();
    // String remoteHash = "asd";
    print("Remote Hash: $remoteHash");
    if (remoteHash == "") {
    } else if (remoteHash == rawHash) {
      print("Remote hash $remoteHash is same as local hash $rawHash");
    } else {
      print("Remote hash $remoteHash is NOT the same as local hash $rawHash");
      print("Getting data from remote");
      rawData = await getLatestData();
      if (rawData == "") {
        return {};
      }
      // print(rawData);
      returnData = jsonDecode(rawData);
      // fileLink.writeAsStringSync(rawData, mode: FileMode.write);
      prefs.setString(storageKey, rawData);
    }
    // returnData = jsonDecode(menuData.data);
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
      this.menuAvailable = DataStatus.Loaded;
    } else {
      this.menuAvailable = DataStatus.NotFound;
    }
  }

  void setDateToADay([DateTime? aDay]) {
    this.currentDate = aDay ?? DateTime.now();
    this.isMenuAvailable();
    notifyListeners();
  }
}
