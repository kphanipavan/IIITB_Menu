// ignore_for_file: file_names

import "package:flutter/material.dart";
import "package:iiitb_menu/constants.dart";
import "package:iiitb_menu/models/globalModel.dart";
import "package:iiitb_menu/models/initialPageIndexFunction.dart";
import "package:iiitb_menu/views/menuListView.dart";
import "package:provider/provider.dart";

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        initialIndex: getInitialPageIndex(),
        length: 4,
        child: Builder(builder: (context) {
          TabController cont = DefaultTabController.of(context);
          cont.addListener(() {
            Provider.of<GlobalModel>(context, listen: false)
                .setMenuTime(cont.index);
          });
          return Consumer<GlobalModel>(
              builder: (BuildContext context, GlobalModel data, Widget? child) {
            return Scaffold(
              drawer: Drawer(
                child: ListView(
                  children: [
                    ListTile(
                        leading: Icon(Icons.menu),
                        title: Text("Menu"),
                        onTap: () {
                          Navigator.pop(context);
                        }),
                    ListTile(
                      leading: Icon(Icons.star),
                      title: Text("Specials"),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text("Settings"),
                    ),
                    ListTile(
                        leading: Icon(Icons.info),
                        title: Text("About App"),
                        onTap: () {
                          Navigator.pushNamed(context, "/info");
                        }),
                  ],
                ),
              ),
              appBar: AppBar(
                title: Text("Daily ${data.menuTime} Menu"),
                bottom: TabBar(
                    controller: cont,
                    // splashFactory: InkSplash.splashFactory,
                    // indicator: const UnderlineTabIndicator(
                    //     insets: EdgeInsets.fromLTRB(10, 3, 10, 3)),
                    onTap: (int index) {
                      data.setMenuTime(index);
                    },
                    tabs: const [
                      Tab(icon: Icon(Icons.breakfast_dining_outlined)),
                      Tab(icon: Icon(Icons.lunch_dining_outlined)),
                      Tab(icon: Icon(Icons.coffee_outlined)),
                      Tab(icon: Icon(Icons.dinner_dining_outlined))
                    ]),
                actions: [
                  InkWell(
                      splashFactory: NoSplash.splashFactory,
                      onTap: () {
                        data.decrDate();
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.keyboard_arrow_left_rounded,
                          size: 30,
                        ),
                      )),
                  InkWell(
                    splashFactory: NoSplash.splashFactory,
                    onTap: () {
                      showDatePicker(
                              context: context,
                              initialDate: data.currentDate,
                              firstDate: data.currentDate
                                  .add(const Duration(days: -30)),
                              lastDate: data.currentDate
                                  .add(const Duration(days: 30)))
                          .then((value) {
                        data.setDateToADay(value ?? data.currentDate);
                      });
                    },
                    onLongPress: () {
                      data.setDateToADay();
                    },
                    child: Center(
                      child: Text(data.date),
                    ),
                  ),
                  InkWell(
                      splashFactory: NoSplash.splashFactory,
                      onTap: () {
                        data.incrDate();
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.keyboard_arrow_right_rounded,
                          size: 30,
                        ),
                      )),
                ],
              ),
              body: TabBarView(
                  controller: cont,
                  children: data.menuAvailable != DataStatus.NotFound
                      ? const [
                          MenuListView(menuType: "bf"),
                          MenuListView(menuType: "ln"),
                          MenuListView(menuType: "sk"),
                          MenuListView(menuType: "dn"),
                        ]
                      : [
                          noMenuWidget,
                          noMenuWidget,
                          noMenuWidget,
                          noMenuWidget,
                        ]),
            );
          });
        }),
      ),
    );
  }
}
