import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';
import 'package:onthewheelpractice/map/myPage/myPage_setting.dart';
// import 'package:naver_map_plugin-d6029c020e13c926ff5f94b445b4f65abb48b85f/lib/src/overlay_image.dart';
import 'package:onthewheelpractice/map/placeModal.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Info.dart';
import '../placeinfo.dart';
import '../search_screen.dart';
import '../size.dart';
import 'myPage/myPage_FAQ.dart';
import 'myPage/myPage_notice.dart';
import 'myPage/myPage_question.dart';
import 'newPlace.dart';

List<Marker> rest_marker = [];
List<Marker> bokji_marker = [];
List<Marker> mart_marker = [];
List<Marker> all_marker = [];

class NaverMapTest extends StatefulWidget {
  @override
  _NaverMapTestState createState() => _NaverMapTestState();
}

class _NaverMapTestState extends State<NaverMapTest> {
  Completer<NaverMapController> _controller = Completer();
  MapType _mapType = MapType.Basic;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final imageUrl1 =
      'https://s3-alpha-sig.figma.com/img/7e62/21e6/b66f076abc8c42787d3343a22987d8be?Expires=1676246400&Signature=UDEA3OVmYCYzhlV2QFwfb4HIA2DUI~8byJ2YtkSdYXsMDDxzv9zyaVjtDgspv0HS8H0bKq52aLSu23dQ1JCTJ0y7vioLlWuDPBIlrxMKY55rax-p-dZrI6M8au5clCPzeqFTcCd4217pPIo7C-tK61eBdkgKuyKCdh7q5yetV7AKuc2Jn85MqjoC-2tB4nMsStGqAAwUYvTUnyt56DfExgLtxGZI0~EAiBCY44BzQmdh6M6o0ZDmKr5UPoRzfQpCPuvjks9YBTTOijmFNQ36D7Ypeu9-PnuB3nhsSu8cEcY28JTIEQIq6qZ~IsiVi4bKLViz3tYOJHt54kzpFP5fxA__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4';

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    all_marker.clear();
    bokji_marker.clear();
    mart_marker.clear();
    rest_marker.clear();

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('place')
            .orderBy('id', descending: false)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              // snapshot.data!.docs.length
              var places = snapshot.data!.docs[i];

              var name = places.get('name');
              var info = places.get('info');
              var location = places.get('location');
              var latitude = places.get('latitude');
              var longitude = places.get('longitude');
              var category = places.get('category');
              print(name + " : " + info + "\n");

              if (category == "????????????") {
                bokji_marker.add(makeMarker(name, category, location, latitude,
                    longitude, info, Colors.blueAccent));
                all_marker.add(makeMarker(name, category, location, latitude,
                    longitude, info, Colors.blueAccent));
              } else if (category == "??????") {
                mart_marker.add(makeMarker(name, category, location, latitude,
                    longitude, info, Colors.redAccent));
                all_marker.add(makeMarker(name, category, location, latitude,
                    longitude, info, Colors.redAccent));
              } else if (category == "??????") {
                rest_marker.add(makeMarker(name, category, location, latitude,
                    longitude, info, Colors.purpleAccent));
                all_marker.add(makeMarker(name, category, location, latitude,
                    longitude, info, Colors.purpleAccent));
              }
            }

            return Scaffold(
              key: _scaffoldKey,
              body: SafeArea(
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: NaverMap(
                        onMapCreated: onMapCreated,
                        mapType: _mapType,
                        markers: all_marker,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 6, 0, 0),
                      child: IconButton(
                          onPressed: () {
                            _scaffoldKey.currentState?.openDrawer();
                          },
                          icon: Icon(Icons.menu, size: 30)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 8, 8, 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          width: 500,
                          height: 50,
                          color: Colors.white,
                          child: Row(children: <Widget>[
                            Expanded(
                                child: TextField(
                              onTap: () {
                                Get.to(SearchScreen());
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                hintText: '??????',
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                            )),
                          ]),
                        ),
                      ),
                    ),

                    Padding(padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 160,
                            width: 17,
                          ),
                        ],

                      ),),
                    Padding(padding: const EdgeInsets.fromLTRB(10, 60, 0, 0),
                      child: Column(
                        children: [
                          Container(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [

                                  OutlinedButton(onPressed: (){}, child: Text(" ????????? "),
                                    style: ElevatedButton.styleFrom(

                                      shape: RoundedRectangleBorder(	//???????????? ?????????
                                          borderRadius: BorderRadius.circular(15)),
                                      side: BorderSide(
                                        color: Colors.lightGreen,
                                      ),
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w600,

                                      ),
                                      foregroundColor: Colors.lightGreen,
                                      backgroundColor: Colors.white,


                                    ),),
                                  SizedBox(width: 10,),
                                  OutlinedButton(onPressed: (){}, child: Text("  ?????? "),style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(	//???????????? ?????????
                                        borderRadius: BorderRadius.circular(15)),   textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.lightGreen,),
                                  ),
                                  SizedBox(width: 10,),
                                  OutlinedButton(onPressed: (){}, child: Text("  ?????? "),style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(	//???????????? ?????????
                                        borderRadius: BorderRadius.circular(15)),   textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.lightGreen,),
                                  ),
                                  SizedBox(width: 10,),
                                  OutlinedButton(onPressed: (){}, child: Text("?????? ??????"),style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(	//???????????? ?????????
                                        borderRadius: BorderRadius.circular(15)),   textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.lightGreen,),
                                  ),
                                  SizedBox(width: 10,),
                                  OutlinedButton(onPressed: (){}, child: Text("?????? ??????"),style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(	//???????????? ?????????
                                        borderRadius: BorderRadius.circular(15)),   textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.lightGreen,),
                                  ),
                                  SizedBox(width: 10,),
                                  OutlinedButton(onPressed: (){}, child: Text(" ????????? "),style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(	//???????????? ?????????
                                        borderRadius: BorderRadius.circular(15)),   textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                    side: BorderSide(
                                      color: Colors.lightGreen,
                                    ),
                                    foregroundColor: Color(0xffBCCF9B),
                                    backgroundColor: Colors.white,),
                                  ),
                                  SizedBox(width: 10,),
                                  OutlinedButton(onPressed: (){}, child: Text(" ?????? "),style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(	//???????????? ?????????
                                        borderRadius: BorderRadius.circular(15)),   textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                    foregroundColor: Color(0xffBCCF9B),
                                    backgroundColor: Colors.white,),
                                  ),
                                  SizedBox(width: 10,),
                                  OutlinedButton(onPressed: (){}, child: Text("????????????"),style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(	//???????????? ?????????
                                        borderRadius: BorderRadius.circular(15)),   textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,

                                  ),
                                    foregroundColor: Colors.black,
                                    backgroundColor: Colors.white,),

                                  ),
                                  SizedBox(width: 10,),
                                  OutlinedButton(onPressed: (){}, child: Text("????????????"),style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(	//???????????? ?????????
                                        borderRadius: BorderRadius.circular(15)),   textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                    foregroundColor: Colors.white,
                                    backgroundColor: Color(0xffBCCF9B),),
                                  ),
                                  SizedBox(width: 10,),
                                  OutlinedButton(onPressed: (){}, child: Text(" ?????? "),style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(	//???????????? ?????????
                                        borderRadius: BorderRadius.circular(15)),   textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                    foregroundColor: Colors.white,
                                    backgroundColor: Color(0xffBCCF9B),),
                                  ),

                                ],
                              ),
                            ),

                          )
                        ],
                      ),

                    )

                  ],

                ),


              ),
              bottomNavigationBar: BottomAppBar(),
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(imageUrl1),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                children: [
                                  Text('????????? ???', style: TextStyle(fontSize: 15)),
                                  Text('Lv.3',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF968686))),

                                ],
                              )
                            ],
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(children: [
                                Text(
                                  '?????? ?????? 6???',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ]),
                              VerticalDivider(
                                thickness: 1,
                                color: Colors.black,
                              ),
                              Column(children: [
                                Text(
                                  '?????? ?????? 7???',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ]),
                            ],
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                    ListTile(
                      title: Text('?????? ??????'),
                      onTap: () {
                        Get.to(MyPage_notice());
                      },
                    ),
                    ListTile(
                      title: Text('??????'),
                      onTap: () {
                        Get.to(MyPage_FAQ());
                      },
                    ),

                    ListTile(
                      title: Text('??????'),
                      onTap: () {
                        Get.to(MyPage_Setting());
                      },
                    ),
                    ListTile(
                      title: Text('Log Out'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              floatingActionButton: Stack(
                children: <Widget>[
                  Align(
                    //???????????? '+' ?????????
                    alignment: Alignment(
                        Alignment.bottomRight.x, Alignment.bottomRight.y - 0.4),
                    child: FloatingActionButton(
                      onPressed: () {
                        Get.to(Newplace());
                      },
                      child: Icon(Icons.add),
                    ),
                  ),
                  Align(
                    //????????? ????????? ???????????? ?????????
                    alignment: Alignment(
                        Alignment.bottomRight.x, Alignment.bottomRight.y - 0.2),
                    child: FloatingActionButton(
                      onPressed: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text("???????????? ????????? ?????????"),
                            content: Text('054-231-1117'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('??????',style: TextStyle(color: Colors.black),),
                              ),
                              TextButton(
                                onPressed: () async {
                                  final url = Uri.parse('tel:0542311117');
                                  launchUrl(url);
                                },
                                child: Text('????????????',style: TextStyle(color: Colors.black),),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Icon(Icons.local_taxi),
                    ),
                  ),
                  Align(
                      //?????? ?????? ?????????
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        onPressed: () {
                          Get.to(PlaceInfo());
                        },
                        child: Icon(Icons.my_location),
                      ))
                ],
              ),
            );
          }
        });
  }

  void onMapCreated(NaverMapController controller) {
    if (_controller.isCompleted) _controller = Completer();
    _controller.complete(controller);
  }

  Marker makeMarker(String name, String category, String location,
      double latitude, double longitude, String info, Color color) {
    return Marker(
      // icon: OverlayImage(AssetImage('assets/images/hgu.png'), AssetBundleImageKey(null, null, null)),
      // icon: OverlayImage(Image( image: AssetImage('assets/images/hgu.png'),)),
        onMarkerTab: (marker, iconSize) {
          showModalBottomSheet(
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(10))),
              context: context,
              builder: (context) => Container(
                    height: getScreenHeight(context) * 0.3,
                    child: placeModal(name, category, location, info),
                  ));
        },
        width: 40,
        height: 50,
        position: LatLng(latitude, longitude),
        markerId: name,
        iconTintColor: color);
  }
}
