import 'package:app/screens/main/catalog/catalog_listview.dart';
import 'package:app/screens/main/catalog/catalog_listview2.dart';
import 'package:app/statistics/stats.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:lottie/lottie.dart';

class ScreenBody extends StatefulWidget {
  const ScreenBody({Key? key}) : super(key: key);

  @override
  _ScreenBodyState createState() => _ScreenBodyState();
}

class _ScreenBodyState extends State<ScreenBody> {
  final user = FirebaseAuth.instance.currentUser!;
  bool switched = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 10.0, bottom: 20, left: 20, right: 20),
        child: Container(
          width: screenWidth,
          // height: screenHeight,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      child: Text(
                        "Hi",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 50),
                      ),
                    ),
                    Container(
                        height: 60,
                        width: 60,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Center(
                              child: Lottie.network(
                                  "https://assets4.lottiefiles.com/packages/lf20_fft5vg8j.json")),
                        )),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: 50,
                  width: 400,
                  child: Text(
                    user.displayName!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: screenWidth,
                child: Text(
                  "Catalog",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black.withOpacity(.6)),
                ),
              ),
              Container(
                height: 210,
                width: double.infinity,
                color: Colors.white,
                child: AnimatedCrossFade(
                  firstChild: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0, top: 4),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              switched = !switched;
                            });
                          },
                          child: Container(
                              height: 25,
                              width: 300,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.black.withOpacity(.2), width: 1),

                                  //borderRadius: BorderRadius.circular(10),
                                  ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Pinned Todo",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child:Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: Icon(CupertinoIcons.square_favorites,color: Colors.grey,size: 15,),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                      Container(
                          height: 150,
                          width: double.infinity,
                          child: ListCatalog()),
                    ],
                  ),
                  secondChild: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0, top: 4),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              switched = !switched;
                            });
                          },
                          child: Container(
                              height: 25,
                              width: 300,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.black.withOpacity(.2), width: 1),
                                  //borderRadius: BorderRadius.circular(10),
                                  ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Latest Task",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child:Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: Icon(CupertinoIcons.group,color: Colors.grey,size: 15,),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                      Container(
                          height: 150,
                          width: double.infinity,
                          child: ListView2()),
                    ],
                  ),
                  crossFadeState: switched
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 300),
                ),
              ),
              Container(
                height: 200,
                width: screenWidth,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.1),
                        blurRadius: 1000,
                        spreadRadius: 2,
                        offset: Offset(0, 3),
                      ),
                    ]
                    //borderRadius: BorderRadius.circular(10),
                    ),
                child: Row(
                  children: [
                    Container(
                      height: 170,
                      width: 170,
                      child: Lottie.network(
                          "https://assets2.lottiefiles.com/packages/lf20_Ginph2.json"),
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.white10,
                                  //borderRadius: BorderRadius.circular(10),
                                  ),
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FeatherIcons.checkCircle,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Lets Do It",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ],
                              ))),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StatsPage()));
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white10),
                              elevation: MaterialStateProperty.all(0),
                              overlayColor:
                                  MaterialStateProperty.all(Colors.white),
                            ),
                            child: Text(
                              "See Statistics  ->",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ]),
                    const SizedBox(width: 5.0, height: 50.0),
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
