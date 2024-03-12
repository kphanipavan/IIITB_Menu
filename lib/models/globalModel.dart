// ignore_for_file: unnecessary_this, file_names, library_prefixes

import "dart:convert";
import "package:iiitb_menu/constants.dart";
import 'dart:io';
import "package:flutter/material.dart";
import "package:crypto/crypto.dart";
import "package:http/http.dart";
import "package:intl/intl.dart";
import "package:shared_preferences/shared_preferences.dart";

class GlobalModel extends ChangeNotifier {
  late Map<dynamic, dynamic> mainData;
  DateTime currentDate = DateTime.now();
  String menuTime = breakfast;
  DataStatus menuAvailable = DataStatus.Loading;

  GlobalModel() {
    // print("In constructor");
    GlobalModel.loadData().then((value) {
      mainData = value;
      if (this.mainData["dates"].keys.contains(this.date)) {
        this.menuAvailable = DataStatus.Loaded;
      }
      notifyListeners();
    });
  }

  static Future<String> getLatestHash() async {
    try {
      Response hashRequest = await get(Uri.parse(hashLink));
      if (hashRequest.statusCode == 200) {
        return hashRequest.body.replaceAll("\n", "");
      } else {
        return "";
      }
    } on (ClientException, SocketException, HttpException) catch (exce) {
      print("Unable to download hash");
      print(exce);
      return "";
    }
  }

  static Future<String> getLatestData() async {
    try {
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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? rawData;
    String rawHash;
    rawData = prefs.getString(storageKey);
    // print(rawData);
    if (rawData != null) {
      // print("data found");
      rawHash = md5.convert(utf8.encode(rawData)).toString();
      // print("Hash of Raw Data:");
      // print(rawHash);
      returnData = jsonDecode(rawData);
    } else {
      print("Data Not Found");
      returnData = {};
      rawHash = "";
    }
    String remoteHash = await GlobalModel.getLatestHash();
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
      returnData = jsonDecode(rawData);
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
