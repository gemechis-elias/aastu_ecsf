//  SizedBox(
//                   height: 205,
//                   child: ListView.separated(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: devotions.length,
//                     separatorBuilder: (BuildContext context, int index) =>
//                         const Divider(
//                       height: 2,
//                       thickness: 1,
//                       color: Color.fromARGB(188, 189, 189, 189),
//                     ),
//                     itemBuilder: (BuildContext context, int index) {
//                       Map<dynamic, dynamic> devotion = devotions[index];
//                       id = devotions[index]['id'];
//                       title = devotion['title'];
//                       imagePath = devotion['image'];
//                       date = devotion['addedDate'];
//                       devoLink = devotion['content'];
//                       views = "1k+ Views"; // defualt value

//                       return Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 5),
//                         child: GestureDetector(
//                           onTap: () {
//                             // passing id and link to Devotion Detail Page
//                             Navigator.push<dynamic>(
//                               context,
//                               MaterialPageRoute<dynamic>(
//                                   builder: (BuildContext context) =>
//                                       DevotionDetail(idd: id, link: devoLink)),
//                             );
//                             //openDevotions(devoLink);
//                             // WebViewPage(url: devoLink);
//                           },
//                           child: Card(
//                             elevation: 2,
//                             color: const Color(0xff212121),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(2),
//                             ),
//                             clipBehavior: Clip.antiAliasWithSaveLayer,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 ClipRRect(
//                                   borderRadius: const BorderRadius.only(
//                                     topLeft: Radius.circular(15),
//                                     topRight: Radius.circular(15),
//                                   ),
//                                   child: CachedNetworkImage(
//                                     imageUrl: imagePath,
//                                     placeholder: (context, url) => const Center(
//                                       child: SizedBox(
//                                         width: 24, // Adjust the size as needed
//                                         height: 24, // Adjust the size as needed
//                                         child: CircularProgressIndicator(
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                     errorWidget: (context, url, error) =>
//                                         const Icon(Icons.error),
//                                     width: 150,
//                                     height: 90,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: <Widget>[
//                                       SizedBox(
//                                         width: 130,
//                                         child: Text(
//                                           title,
//                                           style: TextStyle(
//                                             fontFamily: 'MyFont',
//                                             color: AppTheme.normalText(context),
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                           textAlign: TextAlign.left,
//                                           maxLines: 1,
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                       ),
//                                       Container(height: 3),
//                                       Text(
//                                         date,
//                                         style: TextStyle(
//                                           fontFamily: 'MyLightFont',
//                                           color:
//                                               AppTheme.iconBackground(context),
//                                           fontSize: 12,
//                                         ),
//                                         textAlign: TextAlign.left,
//                                       ),
//                                       Container(height: 10),
//                                       Text(
//                                         views,
//                                         style: TextStyle(
//                                           color:
//                                               AppTheme.iconBackground(context),
//                                           fontSize: 10,
//                                         ),
//                                         textAlign: TextAlign.left,
//                                       ),
//                                       Row(
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Icon(
//                                                 Icons.star,
//                                                 size: 11,
//                                                 color: AppTheme
//                                                     .activeIconBackground(
//                                                         context),
//                                               ),
//                                               Icon(
//                                                 Icons.star,
//                                                 size: 11,
//                                                 color: AppTheme
//                                                     .activeIconBackground(
//                                                         context),
//                                               ),
//                                               Icon(
//                                                 Icons.star,
//                                                 size: 11,
//                                                 color: AppTheme
//                                                     .activeIconBackground(
//                                                         context),
//                                               ),
//                                               Icon(
//                                                 Icons.star,
//                                                 size: 11,
//                                                 color: AppTheme
//                                                     .activeIcon2Background(
//                                                         context),
//                                               ),
//                                               Icon(
//                                                 Icons.star,
//                                                 size: 11,
//                                                 color: AppTheme
//                                                     .activeIcon2Background(
//                                                         context),
//                                               ),
//                                             ],
//                                           ),
//                                           Container(
//                                             width: 20,
//                                           ),
//                                           Row(
//                                             textDirection: TextDirection.rtl,
//                                             children: [
//                                               Transform.translate(
//                                                 offset: const Offset(-8, 0),
//                                                 child: Positioned(
//                                                   left: 0,
//                                                   child: CircleAvatar(
//                                                     radius: 10,
//                                                     backgroundImage: AssetImage(
//                                                         images[rnd1]),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Transform.translate(
//                                                 offset: const Offset(0, 0),
//                                                 child: Positioned(
//                                                   left: 0,
//                                                   child: CircleAvatar(
//                                                     radius: 10,
//                                                     backgroundImage: AssetImage(
//                                                         images[rnd2]),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Transform.translate(
//                                                 offset: const Offset(8, 0),
//                                                 child: Positioned(
//                                                   left: 0,
//                                                   child: CircleAvatar(
//                                                     radius: 10,
//                                                     backgroundImage: AssetImage(
//                                                         images[rnd3]),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
             