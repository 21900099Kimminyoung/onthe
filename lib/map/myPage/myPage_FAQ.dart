import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../size.dart';

class MyPage_FAQ extends StatelessWidget {
  const MyPage_FAQ({Key? key}) : super(key: key);
  final imageUrl1 = 'https://s3-alpha-sig.figma.com/img/7e62/21e6/b66f076abc8c42787d3343a22987d8be?Expires=1676246400&Signature=UDEA3OVmYCYzhlV2QFwfb4HIA2DUI~8byJ2YtkSdYXsMDDxzv9zyaVjtDgspv0HS8H0bKq52aLSu23dQ1JCTJ0y7vioLlWuDPBIlrxMKY55rax-p-dZrI6M8au5clCPzeqFTcCd4217pPIo7C-tK61eBdkgKuyKCdh7q5yetV7AKuc2Jn85MqjoC-2tB4nMsStGqAAwUYvTUnyt56DfExgLtxGZI0~EAiBCY44BzQmdh6M6o0ZDmKr5UPoRzfQpCPuvjks9YBTTOijmFNQ36D7Ypeu9-PnuB3nhsSu8cEcY28JTIEQIq6qZ~IsiVi4bKLViz3tYOJHt54kzpFP5fxA__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFBCCF9B),
        title: const Text('자주 묻는 질문(FAQ)',style: TextStyle(fontSize: 23),),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                width: getScreenWidth(context),
                child: ElevatedButton(onPressed: (){}, child: Row(
                  children: [
                    Text('장소등록 하는 법',style: TextStyle(fontSize: 20),),
                    SizedBox(width: 130,),
                    Text('2023.2.10',style: TextStyle(fontSize: 13,color: Colors.grey),),
                  ],
                ),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white,
                    alignment: Alignment.centerLeft,side: BorderSide.none),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}