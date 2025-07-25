import 'package:flutter/material.dart';
import 'package:iiitb_menu/models/globalModel.dart';
import 'package:iiitb_menu/views/homePage.dart';
import 'package:provider/provider.dart';
import "package:iiitb_menu/views/share.dart";
import "package:iiitb_menu/views/about.dart";
import "package:iiitb_menu/views/bus.dart";
// import "package:pwa_install/pwa_install.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // if (PWAInstall().installPromptEnabled) {
  // try {
  // PWAInstall().promptInstall_();
  // } catch (e) {
  // print("Unable to install app:");
  // print(e.toString());
  // }
  // }
  // PWAInstall().setup(installCallback: () {
  // print("Installed!!");
  // });

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GlobalModel>(
      lazy: false,
      create: (context) => GlobalModel(),
      builder: (BuildContext context, child) {
        return MaterialApp(
          title: "IIITB Menu",
          routes: {
            "/": (context) => const HomePage(),
            "/info": (context) => const AboutPage(),
            "/share": (context) => const SharePage(),
            "/bus": (context) => const BusTimingsPage(),
          },
          initialRoute: "/",
          // home: const HomePage(),
          theme: ThemeData(useMaterial3: true),
        );
      },
    );
  }
}
