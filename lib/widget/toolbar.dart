import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/widget/my_toast.dart';

import 'my_text.dart';

class CommonAppBar {
  static Widget getPrimaryAppbar(BuildContext context, String title) {
    return AppBar(
        backgroundColor: MyColors.primary,
        brightness: Brightness.dark,
        titleSpacing: 0,
        title: Text(
          title,
        ),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showToastClicked(context, "Search");
            },
          ),
        ]);
  }

  static Widget getPrimaryAppbarLight(BuildContext context, String title) {
    return AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.dark,
        iconTheme: IconThemeData(color: MyColors.grey_60),
        titleSpacing: 0,
        title: Text(title,
            style: MyText.title(context)!.copyWith(color: MyColors.grey_60)),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showToastClicked(context, "Search");
            },
          ),
        ]);
  }

  static Widget getPrimarySettingAppbar(BuildContext context, String title,
      {bool light = false}) {
    return AppBar(
        backgroundColor: light ? Colors.white : MyColors.primary,
        brightness: Brightness.dark,
        titleSpacing: 0,
        iconTheme:
            IconThemeData(color: light ? MyColors.grey_60 : Colors.white),
        title: Text(title,
            style: MyText.title(context)!
                .copyWith(color: light ? MyColors.grey_60 : Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showToastClicked(context, "Search");
            },
          ),
          PopupMenuButton<String>(
            onSelected: (String value) {
              showToastClicked(context, value);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: "Settings",
                child: Text("Settings"),
              ),
            ],
          )
        ]);
  }

  static Widget getPrimaryBackAppbar(BuildContext context, String title) {
    return AppBar(
        backgroundColor: MyColors.primary,
        brightness: Brightness.dark,
        title: Text(
          title,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showToastClicked(context, "Search");
            },
          ),
        ]);
  }

  static void showToastClicked(BuildContext context, String action) {
    print(action);
    MyToast.show(action + " clicked", context);
  }
}
