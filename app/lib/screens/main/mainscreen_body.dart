import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app/screens/main/catalog_listview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ScreenBody extends StatefulWidget {
  const ScreenBody({Key? key}) : super(key: key);

  @override
  _ScreenBodyState createState() => _ScreenBodyState();
}

class _ScreenBodyState extends State<ScreenBody> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;
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
                    user.email!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 25,
                width: screenWidth,
                child: Text(
                  "Catalog",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.grey),
                ),
              ),
              Container(
                height: 210,
                width: screenWidth,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        ListCatalog(),
                      ],
                    ),
                  ),
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
                      children: [
                        
                       ]
                    ),
                    const SizedBox(width: 10.0, height: 100.0),
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
