import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class RouteData {
  RouteData(
      {required this.icon,
      required this.title,
      required this.selectedColor,
      required this.routeName});

  Icon icon;
  Widget title;
  Color selectedColor;
  String routeName;
}

List<RouteData> data = [
  RouteData(
      icon: const Icon(Icons.list),
      title: const Text("Discover"),
      selectedColor: Colors.deepOrange,
      routeName: "/"),
  RouteData(
      icon: const Icon(Icons.search),
      title: const Text("Search"),
      selectedColor: Colors.yellow,
      routeName: "/search"),
  RouteData(
      icon: const Icon(Icons.person),
      title: const Text("Profile"),
      selectedColor: Colors.teal,
      routeName: "/profile"),
];

List<ListTile> getDrawerNav(BuildContext context) {
  List<ListTile> res = [];

  for (RouteData element in data) {
    res.add(ListTile(
      leading: element.icon,
      title: element.title,
      selected: getRouteIndex(context: context) == data.indexOf(element),
      onTap: () {
        navigateTo(context: context, index: data.indexOf(element));
      },
    ));
  }

  return res;
}

List<SalomonBottomBarItem> getNavList() {
  List<SalomonBottomBarItem> res = [];

  for (RouteData element in data) {
    res.add(SalomonBottomBarItem(
        icon: element.icon,
        title: element.title,
        selectedColor: element.selectedColor));
  }

  return res;
}

navigateTo({required context, required int index}) {
  if (data[index].routeName != ModalRoute.of(context)!.settings.name) {
    Navigator.pushNamed(context, data[index].routeName);
  }
}

int getRouteIndex({required context}) {
  ModalRoute<Object?>? currentRoute = ModalRoute.of(context);

  for (int i = 0; i < data.length; i++) {
    if (data[i].routeName == currentRoute!.settings.name) {
      return i;
    }
  }

  throw "Could not find route";
}
