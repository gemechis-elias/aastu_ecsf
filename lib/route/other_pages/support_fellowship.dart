import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/img.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/widget/my_text.dart';

class SupportFellowshipRoute extends StatefulWidget {
  const SupportFellowshipRoute({super.key});

  @override
  SupportFellowshipRouteState createState() => SupportFellowshipRouteState();
}

class SupportFellowshipRouteState extends State<SupportFellowshipRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1f1f1f),
      appBar: AppBar(
          elevation: 0,
          // brightness: Brightness.dark,
          backgroundColor: const Color(0xff121212),
          title: const Text("SUPPORT FELLOWSHIP"),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ]),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                    width: double.infinity,
                    color: const Color(0xff121212),
                    height: 50),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  color: const Color(0xff212121),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  elevation: 2,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: MyColors.grey_10,
                          child: CircleAvatar(
                            radius: 28,
                            backgroundImage: AssetImage(Img.get("logo.jpg")),
                          ),
                        ),
                        Container(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("AASTU ECSF",
                                  style: MyText.medium(context).copyWith(
                                      color: const Color(0xff0d8df3),
                                      fontWeight: FontWeight.bold)),
                              Container(height: 2),
                              Text(
                                  "Addis Ababa Science and Technology University, Christian Student Fellowship",
                                  style: MyText.body1(context)!.copyWith(
                                      color: MyColors.grey_40, fontSize: 12)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(width: 5),
                      Text("Payment Options",
                          style: MyText.subhead(context)!.copyWith(
                              color: MyColors.grey_60,
                              fontWeight: FontWeight.bold)),
                      const Spacer(),
                      Text("Banks",
                          style: MyText.subhead(context)!.copyWith(
                              color: MyColors.primary,
                              fontWeight: FontWeight.bold)),
                      Container(width: 5),
                    ],
                  ),
                  Container(height: 10),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    color: const Color(0xff808080),
                    elevation: 2,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Commercial Bank",
                                    style: MyText.medium(context).copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                Container(height: 40),
                                Text("Account Number",
                                    style: MyText.body1(context)!
                                        .copyWith(color: Colors.white)),
                                Container(height: 5),
                                Text("1000510257492",
                                    style: MyText.subhead(context)!.copyWith(
                                        color: const Color.fromARGB(
                                            255, 0, 0, 0))),
                                Container(height: 20),
                                Text("Account Name",
                                    style: MyText.body1(context)!
                                        .copyWith(color: Colors.white)),
                                Container(height: 5),
                                Text("Amanuel Ketema and/or Selihom Demeke",
                                    style: MyText.subhead(context)!.copyWith(
                                        color: const Color.fromARGB(
                                            255, 0, 0, 0))),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Image.asset('assets/images/b_cbe.png',
                                      width: 60, height: 60),
                                ),
                                Container(height: 25),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(height: 5),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    color: const Color(0xff808080),
                    elevation: 2,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Birhan bank",
                                    style: MyText.medium(context).copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                Container(height: 40),
                                Text("Account Number",
                                    style: MyText.body1(context)!
                                        .copyWith(color: Colors.white)),
                                Container(height: 5),
                                Text("1011553107702",
                                    style: MyText.subhead(context)!.copyWith(
                                        color: const Color.fromARGB(
                                            255, 0, 0, 0))),
                                Container(height: 20),
                                Text("Account Name",
                                    style: MyText.body1(context)!
                                        .copyWith(color: Colors.white)),
                                Container(height: 5),
                                Text("Amanuel Ketema and/or Selihom Demeke",
                                    style: MyText.subhead(context)!.copyWith(
                                        color: const Color.fromARGB(
                                            255, 0, 0, 0))),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Image.asset(
                                      'assets/images/b_birhan.png',
                                      width: 60,
                                      height: 60),
                                ),
                                Container(height: 25),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(height: 5),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    color: const Color(0xff808080),
                    elevation: 2,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Abyssinia bank",
                                    style: MyText.medium(context).copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                Container(height: 40),
                                Text("Account Number",
                                    style: MyText.body1(context)!
                                        .copyWith(color: Colors.white)),
                                Container(height: 5),
                                Text("85737511",
                                    style: MyText.subhead(context)!.copyWith(
                                        color: const Color.fromARGB(
                                            255, 0, 0, 0))),
                                Container(height: 20),
                                Text("Account Name",
                                    style: MyText.body1(context)!
                                        .copyWith(color: Colors.white)),
                                Container(height: 5),
                                Text("Amanuel Ketema and/or Selihom Demeke",
                                    style: MyText.subhead(context)!.copyWith(
                                        color: const Color.fromARGB(
                                            255, 0, 0, 0))),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Image.asset(
                                      'assets/images/b_abisiniya.png',
                                      width: 60,
                                      height: 60),
                                ),
                                Container(height: 25),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(height: 5),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    color: const Color(0xff808080),
                    elevation: 2,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Awash bank",
                                    style: MyText.medium(context).copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                Container(height: 40),
                                Text("Account Number",
                                    style: MyText.body1(context)!
                                        .copyWith(color: Colors.white)),
                                Container(height: 5),
                                Text("01320659484500",
                                    style: MyText.subhead(context)!.copyWith(
                                        color: const Color.fromARGB(
                                            255, 0, 0, 0))),
                                Container(height: 20),
                                Text("Account Name",
                                    style: MyText.body1(context)!
                                        .copyWith(color: Colors.white)),
                                Container(height: 5),
                                Text("Amanuel Ketema and/or Selihom Demeke",
                                    style: MyText.subhead(context)!.copyWith(
                                        color: const Color.fromARGB(
                                            255, 0, 0, 0))),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Image.asset(
                                      'assets/images/b_awash.png',
                                      width: 60,
                                      height: 60),
                                ),
                                Container(height: 25),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(height: 5),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    color: const Color(0xff808080),
                    elevation: 2,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Dashen bank",
                                    style: MyText.medium(context).copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                Container(height: 40),
                                Text("Account Number",
                                    style: MyText.body1(context)!
                                        .copyWith(color: Colors.white)),
                                Container(height: 5),
                                Text("5400293784011",
                                    style: MyText.subhead(context)!.copyWith(
                                        color: const Color.fromARGB(
                                            255, 0, 0, 0))),
                                Container(height: 20),
                                Text("Account Name",
                                    style: MyText.body1(context)!
                                        .copyWith(color: Colors.white)),
                                Container(height: 5),
                                Text("Amanuel Ketema and/or Selihom Demeke",
                                    style: MyText.subhead(context)!.copyWith(
                                        color: const Color.fromARGB(
                                            255, 0, 0, 0))),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Image.asset(
                                      'assets/images/b_dashin.png',
                                      width: 60,
                                      height: 60),
                                ),
                                Container(height: 25),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(height: 5),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
