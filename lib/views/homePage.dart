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
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Provider.of<GlobalModel>(context, listen: false)
                      .toggleSearch();
                  if (data.searchEnable) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: const Color(0xFFCCC2DC),
                        content: RichText(
                          text: const TextSpan(
                            text: "Select an Item for ",
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                  text: "G",
                                  style: TextStyle(color: Color(0xFF4285F4))),
                              TextSpan(
                                  text: "o",
                                  style: TextStyle(color: Color(0xFFEA4335))),
                              TextSpan(
                                  text: "o",
                                  style: TextStyle(color: Color(0xFFFBBC05))),
                              TextSpan(
                                  text: "g",
                                  style: TextStyle(color: Color(0xFF4285F4))),
                              TextSpan(
                                  text: "l",
                                  style: TextStyle(color: Color(0xFF34A853))),
                              TextSpan(
                                  text: "e",
                                  style: TextStyle(color: Color(0xFFEA4335))),
                              TextSpan(
                                  text: " Image Search",
                                  style: TextStyle(color: Colors.black))
                            ],
                          ),
                        ),
                        behavior: SnackBarBehavior.fixed,
                        clipBehavior: Clip.hardEdge,
                        duration: const Duration(seconds: 10),
                        action: SnackBarAction(
                          label: "X",
                          onPressed: () {},
                          textColor: Colors.black,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  }
                },
                splashColor: Colors.transparent,
                elevation: 3,
                hoverElevation: 2,
                focusElevation: 0,
                highlightElevation: 0,
                child: Icon(Provider.of<GlobalModel>(context).search
                    ? Icons.search_off_rounded
                    : Icons.image_search_rounded),
              ),
              drawer: Drawer(
                child: ListView(
                  children: [
                    ListTile(
                        leading: const Icon(Icons.arrow_back),
                        title: const Text("Menu"),
                        onTap: () {
                          Navigator.pop(context);
                        }),
                    // ListTile(
                    //   leading: Icon(Icons.star),
                    //   title: Text("Specials"),
                    // ),
                    const Divider(),
                    // ListTile(
                    //   leading: Icon(Icons.settings),
                    //   title: Text("Settings"),
                    // ),
                    ListTile(
                        leading: const Icon(Icons.share_rounded),
                        title: const Text("Share"),
                        // onTap: () {
                        //   var ret = Share.share(
                        //     "Hey, use this to track IIITB's Mess Menu. https://kphanipavan.github.io/IIITB_Menu/",
                        //     // subject: "IIITB Menu App",
                        //   );
                        //   ret.then((value) {
                        //     print(value.status);
                        //   });
                        // },
                        onTap: () => Navigator.pushNamed(context, "/share")),
                    ListTile(
                        leading: const Icon(Icons.bus_alert),
                        title: const Text("Guesture Bus Sch"),
                        onTap: () {
                          Navigator.pushNamed(context, "/bus");
                        }),
                    ListTile(
                        leading: const Icon(Icons.info),
                        title: const Text("About"),
                        onTap: () {
                          Navigator.pushNamed(context, "/info");
                        }),
                  ],
                ),
              ),
              appBar: AppBar(
                title: Text(data.menuTime),
                bottom: TabBar(
                    controller: cont,
                    splashFactory: NoSplash.splashFactory,
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
                      data.updateCall();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Center(
                        child: Icon(data.menuAvailable == DataStatus.Loading
                            ? Icons.downloading_rounded
                            : Icons.update_rounded),
                      ),
                    ),
                  ),
                  InkWell(
                      splashFactory: NoSplash.splashFactory,
                      onTap: () {
                        data.decrDate();
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: Icon(
                            Icons.keyboard_arrow_left_rounded,
                            size: 30,
                          ),
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
                      child: Text(data.prettyDate),
                    ),
                  ),
                  InkWell(
                      splashFactory: NoSplash.splashFactory,
                      onTap: () {
                        data.incrDate();
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: Icon(
                            Icons.keyboard_arrow_right_rounded,
                            size: 30,
                          ),
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
                          newNoMenuWidget,
                          newNoMenuWidget,
                          newNoMenuWidget,
                          newNoMenuWidget,
                        ]),
            );
          });
        }),
      ),
    );
  }
}
