import 'package:flutter/cupertino.dart';

class Menu {
  int id = 0;
  late String title;
  IconData? icon;
  String type = "PARENT";
  bool expand = false;
  List subs = <Menu>[];
  StatefulWidget? route;
  bool newPage = false;

  Menu(int id, IconData icon, String title, [bool newPage = false]) {
    this.id = id;
    this.title = title;
    this.icon = icon;
    this.type = "PARENT";
    this.newPage = newPage;
  }

  Menu.sub(int id, String title, StatefulWidget route, [bool newPage = false]) {
    this.id = id;
    this.title = title;
    this.icon = null;
    this.type = "CHILD";
    this.route = route;
    this.newPage = newPage;
  }

  Menu.divider(){
    this.type = "DIVIDER";
  }

  Menu.spacer(){
    this.type = "SPACER";
  }
}
