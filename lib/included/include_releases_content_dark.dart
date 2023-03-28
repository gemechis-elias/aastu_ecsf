import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/img.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/widget/my_text.dart';

class IncludeReleasesContentDark {
  static Widget get(BuildContext context) {
    Widget widget;
    widget = SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[
              Container(width: 3),
              Text("New Releases",
                  style: MyText.headline(context)!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w500)),
              Expanded(
                child: Container(),
              ),
              ButtonTheme(
                minWidth: 10,
                child: TextButton(
                  style: TextButton.styleFrom(primary: Colors.transparent),
                  child: Text("MORE",
                      style: MyText.subhead(context)!.copyWith(
                          color: MyColors.grey_20,
                          fontWeight: FontWeight.w500)),
                  onPressed: () {},
                ),
              ),
            ]),
            Container(height: 5),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Card(
                    color: MyColors.grey_90,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          Img.get('image_8.jpg'),
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(height: 15),
                        Row(
                          children: <Widget>[
                            Container(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Mauris sagittis non elit",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white)),
                                  Text("Kodaline",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: MyColors.grey_40)),
                                ],
                              ),
                            ),
                            Icon(Icons.more_vert,
                                color: Colors.white, size: 25),
                            Container(width: 10),
                          ],
                        ),
                        Container(height: 15),
                      ],
                    ),
                  ),
                ),
                Container(width: 2),
                Expanded(
                  flex: 1,
                  child: Card(
                    color: MyColors.grey_90,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          Img.get('image_9.jpg'),
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(height: 15),
                        Row(
                          children: <Widget>[
                            Container(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Aliquam",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white)),
                                  Text("One Republic",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: MyColors.grey_40)),
                                ],
                              ),
                            ),
                            Icon(Icons.more_vert,
                                color: Colors.white, size: 25),
                            Container(width: 10),
                          ],
                        ),
                        Container(height: 15),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(height: 5),
            Row(children: <Widget>[
              Container(width: 3),
              Text("Recommended",
                  style: MyText.headline(context)!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w500)),
              Expanded(
                child: Container(),
              ),
              ButtonTheme(
                minWidth: 10,
                child: TextButton(
                  style: TextButton.styleFrom(primary: Colors.transparent),
                  child: Text("MORE",
                      style: MyText.subhead(context)!.copyWith(
                          color: MyColors.grey_20,
                          fontWeight: FontWeight.w500)),
                  onPressed: () {},
                ),
              ),
            ]),
            Container(height: 5),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Card(
                    color: MyColors.grey_90,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          Img.get('image_15.jpg'),
                          height: 140,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            child: Text("Curabitur tempus",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white))),
                      ],
                    ),
                  ),
                ),
                Container(width: 2),
                Expanded(
                  flex: 1,
                  child: Card(
                    color: MyColors.grey_90,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          Img.get('image_14.jpg'),
                          height: 140,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            child: Text("Quisque",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white))),
                      ],
                    ),
                  ),
                ),
                Container(width: 2),
                Expanded(
                  flex: 1,
                  child: Card(
                    color: MyColors.grey_90,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          Img.get('image_12.jpg'),
                          height: 140,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            child: Text("Aliquam ac elit",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(height: 5),
            Row(children: <Widget>[
              Container(width: 3),
              Text("Top Rated",
                  style: MyText.headline(context)!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w500)),
              Expanded(
                child: Container(),
              ),
              ButtonTheme(
                minWidth: 10,
                child: TextButton(
                  style: TextButton.styleFrom(primary: Colors.transparent),
                  child: Text("MORE",
                      style: MyText.subhead(context)!.copyWith(
                          color: MyColors.grey_20,
                          fontWeight: FontWeight.w500)),
                  onPressed: () {},
                ),
              ),
            ]),
            Container(height: 5),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Card(
                    color: MyColors.grey_90,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          Img.get('image_2.jpg'),
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(height: 15),
                        Row(
                          children: <Widget>[
                            Container(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Suspendisse ornare",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white)),
                                  Text("Adipiscing",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: MyColors.grey_40)),
                                ],
                              ),
                            ),
                            Icon(Icons.more_vert,
                                color: Colors.white, size: 25),
                            Container(width: 10),
                          ],
                        ),
                        Container(height: 15),
                      ],
                    ),
                  ),
                ),
                Container(width: 2),
                Expanded(
                  flex: 1,
                  child: Card(
                    color: MyColors.grey_90,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          Img.get('image_5.jpg'),
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(height: 15),
                        Row(
                          children: <Widget>[
                            Container(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Placerat vel ipsum",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white)),
                                  Text("amet rutrum",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: MyColors.grey_40)),
                                ],
                              ),
                            ),
                            Icon(Icons.more_vert,
                                color: Colors.white, size: 25),
                            Container(width: 10),
                          ],
                        ),
                        Container(height: 15),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(height: 15),
          ],
        ),
      ),
    );
    return widget;
  }
}
