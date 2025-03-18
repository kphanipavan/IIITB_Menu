// ignore_for_file: unnecessary_this, file_names, library_prefixes

import "dart:convert";
import "package:iiitb_menu/constants.dart";
import "package:iiitb_menu/models/initialPageIndexFunction.dart";
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
  bool searchEnable = false;

  GlobalModel() {
    // print("In constructor");
    int iniPage = getInitialPageIndex();
    switch (iniPage) {
      case 0:
        this.menuTime = breakfast;
        break;
      case 1:
        this.menuTime = lunch;
        break;
      case 2:
        this.menuTime = snak;
        break;
      case 3:
        this.menuTime = dinner;
        break;
      default:
    }
    notifyListeners();
    GlobalModel.loadData2().then((value) {
      mainData = value;
      if (this.mainData["dates"].keys.contains(this.date)) {
        this.menuAvailable = DataStatus.Loaded;
      } else {
        this.menuAvailable = DataStatus.NotFound;
        updateLocal().then((value) {
          mainData = value;
        }); // if some data is available but current data is not, check for update.
      }
      notifyListeners();
    });
  }

  updateCall() async {
    this.menuAvailable = DataStatus.Loading;
    notifyListeners();
    this.mainData = await GlobalModel.updateLocal();
    if (this.mainData["dates"].keys.contains(this.date)) {
      this.menuAvailable = DataStatus.Loaded;
    } else {
      this.menuAvailable = DataStatus.NotFound;
    }
    notifyListeners();
  }

  static Future<String> getLatestHash() async {
    try {
      Response hashRequest = await get(Uri.parse(hashLink));
      if (hashRequest.statusCode == 200) {
        return hashRequest.body.replaceAll("\n", "");
      } else {
        return "";
      }
    } on (ClientException, SocketException, HttpException) catch (_) {
      // print("Unable to download hash");
      // print(_);
      return "";
    }
  }

  static Future<String> getLatestData() async {
    try {
      Response dataRequest = await get(Uri.parse(dataLink));
      return dataRequest.body;
    } on SocketException catch (_) {
      // print("Unable to download any data");
      // print(_);
      return "";
    }
  }

  static Future<Map> updateLocal() async {
    // Set main data and return the data to be used in constructor
    String remoteHash = await GlobalModel.getLatestHash();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? rawData = prefs.getString(storageKey);
    rawData ??= "";
    String rawHash = md5.convert(utf8.encode(rawData)).toString();
    if (remoteHash != rawHash) {
      // print("Local data is out of date, updating local");
      // print("Old Hash: $rawHash");
      // print("New Hash: $remoteHash");
      // Donwload new data and save it.
      rawData = await getLatestData();
      Map returnData = jsonDecode(rawData);
      prefs.setString(storageKey, rawData);
      return returnData;
    } else {
      // return the same data
      // print("Local data is up to date");
      return jsonDecode(rawData);
    }
  }

  static Future<Map> loadData2() async {
    /* New flow for fetching data:
          Get cached data into a var
          if theres nothing:
              get data
              generate hash and store both the data and hash
          else:
              return the current data

      Move the download and get hash part to new method - done

      create a new method for updating the current data.
      This checks for update and saves new data to sharedprefs if necessary,
        */
    late Map returnData;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? rawData;
    rawData = prefs.getString(storageKey);
    if (rawData != null) {
      // print("Some data found");
      returnData = jsonDecode(rawData);
      return returnData;
    } else {
      // print("Data Not Found");
      return GlobalModel.updateLocal();
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
      // print("Data Not Found");
      returnData = {};
      rawHash = "";
    }
    String remoteHash = await GlobalModel.getLatestHash();
    // print("Remote Hash: $remoteHash");
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
      prefs.setString(storageKey, rawData);
    }
    return returnData;
  }

  String get date {
    return DateFormat("dd-MM-yyyy").format(this.currentDate);
  }

  String get prettyDate {
    return DateFormat("EEE, MMM d").format(this.currentDate);
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

  void enableSearch() {
    this.searchEnable = true;
    notifyListeners();
  }

  void toggleSearch() {
    this.searchEnable = !this.searchEnable;
    notifyListeners();
  }

  void disableSearch() {
    this.searchEnable = false;
    notifyListeners();
  }

  bool get search {
    return this.searchEnable;
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
