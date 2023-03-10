import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:onthewheelpractice/size.dart';

import '../placeinfo.dart';

class placeModal extends StatelessWidget {
  placeModal(this.name, this.category, this.location, this.info, {Key? key})
      : super(key: key);
  String name;
  String category;
  String location;
  String info;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: getScreenWidth(context) * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: 10),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            category,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey),
                          ),
                        ),
                        IconButton(onPressed: (){
                          Get.to(PlaceInfo());
                        }, icon: Icon(Icons.search))
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Divider(thickness: 1),
                    SizedBox(height: 3),
                    Text(location,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w300)),
                    SizedBox(height: 5),
                    Text("???????????? + ??? ??????????????? ????????????",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w300)),
                    SizedBox(height: 10),
                    Divider(
                      thickness: 1,
                    ),
                  ],
                ),
              ),
              //??????!!!!!!!!!!!!!!!!!!!!!!!
              SizedBox(
                width: getScreenWidth(context) * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: getScreenWidth(context) * 0.35,
                    height: getScreenHeight(context) * 0.2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/hgu.png'),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          iconMaker(info, context)
        ],
      ),
    );
  }

  Container iconMaker(String s, BuildContext context) {
    List<String> result = s.split(',');
    List<Icon> Icondata = []; //

    return Container(
      width: getScreenWidth(context),
      height: getScreenHeight(context) * 0.05,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children:getList(result)
      ),
    );
  }

  List<Widget> getList(List<String> result){
    List<Widget> childs = [];
    for (int i = 0; i < result.length; i++) {
      print(result[i]);
      if (result[i] == "?????? ??????") {
        childs.add(Icon(Icons.dangerous_outlined, size: 35,));
        childs.add(SizedBox(width: 15));
      }
      else if (result[i] == "???????????? ?????????"){
        childs.add(Icon(Icons.circle_outlined, size: 35));
        childs.add(SizedBox(width: 15));
      }
      else if (result[i] == "???????????? ???????????? ??????"){
        childs.add(Icon(CupertinoIcons.arrow_up_right, size: 35));
        childs.add(SizedBox(width: 15));
      }
      else if (result[i] == "?????? ?????? ????????????"){
        childs.add(Icon(Icons.elevator, size: 35));
        childs.add(SizedBox(width: 15));
      }
      else if (result[i] == "???????????????????????????"){
        childs.add(Icon(Icons.local_parking, size: 35));
        childs.add(SizedBox(width: 15));
      }
      else if (result[i] == "?????????"){
        childs.add(Icon(Icons.water, size: 35));
        childs.add(SizedBox(width: 15));
      }
      else if (result[i] == "?????????"){
        childs.add(Icon(CupertinoIcons.tortoise, size: 35));
        childs.add(SizedBox(width: 15));
      }
      else if (result[i] == "1?????? ??????"){
        childs.add(Icon(Icons.numbers, size: 35));
        childs.add(SizedBox(width: 15));
      }
    }

    return childs;
  }
}
