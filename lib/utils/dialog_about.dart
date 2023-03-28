import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/img.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/utils/tools.dart';
import 'package:aastu_ecsf/widget/my_text.dart';
import 'package:package_info/package_info.dart';

class DialogAboutRoute extends StatefulWidget {
  DialogAboutRoute();

  @override
  DialogAboutRouteState createState() => new DialogAboutRouteState();
}

class DialogAboutRouteState extends State<DialogAboutRoute> {
  String version = "";

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        version = packageInfo.version;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 200,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          color: Colors.white,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: MyColors.grey_20,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: Image.asset(Img.get('logo_small_round.png'),
                          color: MyColors.primary, width: 60, height: 60),
                    ),
                    Container(height: 15),
                    Text("MaterialX Flutter",
                        style: MyText.title(context)!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w500)),
                    Text("Version " + version,
                        style: MyText.body1(context)!
                            .copyWith(color: Colors.grey)),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Text(
                        "The best flutter app implementation of material UI components. This app implemented based on Google Design Guidelines.",
                        style: MyText.body1(context)!
                            .copyWith(color: MyColors.grey_60),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 40,
                      child: TextButton(
                        style:
                            TextButton.styleFrom(primary: Colors.transparent),
                        child: Text("OUR PORTFOLIO",
                            style: TextStyle(color: MyColors.accentDark)),
                        onPressed: () {
                          Tools.directUrl(
                              "http://portfolio.dream-space.web.id/");
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: MyColors.primary, elevation: 0),
                        child: Text("PURCHASE SOURCE CODE",
                            style: MyText.body2(context)!
                                .copyWith(color: Colors.white)),
                        onPressed: () {
                          Tools.directUrl(
                              "https://codecanyon.net/item/materialx-flutter-flutter-material-design-ui-components-10/26232732");
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
