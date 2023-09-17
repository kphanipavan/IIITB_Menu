import 'package:flutter/material.dart';
import 'package:iiitb_menu/models/globalModel.dart';
import 'package:iiitb_menu/views/homePage.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
        return const MaterialApp(
          title: "IIITB Menu",
          home: HomePage(),
        );
      },
    );
  }
}
