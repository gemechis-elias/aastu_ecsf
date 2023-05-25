import 'package:aastu_ecsf/gallery/gallery_detail.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/img.dart';
import 'package:aastu_ecsf/data/my_strings.dart';
import 'package:aastu_ecsf/data/my_colors.dart';
import 'package:aastu_ecsf/included/include_store_simple.dart';

class SearchCityRoute extends StatefulWidget {
  const SearchCityRoute({super.key});

  @override
  SearchCityRouteState createState() => SearchCityRouteState();
}

class SearchCityRouteState extends State<SearchCityRoute> {
  bool isSwitched1 = true;
  bool finishLoading = true;
  final TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1f1f1f),
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.dark,
        backgroundColor: const Color(0xff121212),
        centerTitle: false,
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xffd1a552), Color.fromARGB(255, 209, 150, 82)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: const Text(
            "Gallery",
            style: TextStyle(
              fontFamily: 'MyBoldFont',
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GridSectionedRoute(),
                  ),
                );
              },
              child: Card(
                color: const Color(0xff212121),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                      Img.get('fello_1.jpg'),
                      height: 140,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            "General Fellowship Gallery",
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                          Container(height: 10),
                          Container(
                            child: const Text(
                                "Explore images of our fellowship events of all batches",
                                style: TextStyle(
                                    fontSize: 15, color: Color(0xff808080))),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        const SizedBox(width: 8),
                        TextButton(
                          style:
                              TextButton.styleFrom(primary: Colors.transparent),
                          child: const Text(
                            "EXPLORE",
                            style: TextStyle(color: Color(0xffd1a522)),
                          ),
                          onPressed: () {},
                        )
                      ],
                    ),
                    Container(height: 5)
                  ],
                ),
              ),
            ),
            Container(height: 5),
            Card(
              color: const Color(0xff212121),
              child: IncludeStoreSimple.get(context),
            ),
          ],
        ),
      ),
    );
  }
}
