import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoView extends StatefulWidget {
  Map<String, dynamic> data;
  TodoView(this.data);

  @override
  _TodoViewState createState() => _TodoViewState(data);
}

class _TodoViewState extends State<TodoView> {
  Map<String, dynamic> data;
  final _formKey = GlobalKey();
  _TodoViewState(this.data);
  Color _colorM = Colors.white;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    if (data["isdone"]) {
      _colorM = Colors.teal.withOpacity(.5);
    } else if (!data["isdead"]) {
      _colorM = Colors.white;
    } else if (!data["isdone"]) {
      _colorM = Colors.red.withOpacity(.5);
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.withOpacity(.1),
        leading: IconButton(
            splashRadius: 10,
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            },
            icon: Tooltip(
              message: "Exit Todo View",
              child: Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.black,
                size: 23,
              ),
            )),

        actions: [
          data["isfav"]?Padding(
            padding:  EdgeInsets.only(left: screenWidth*.25),
            child: Icon(Icons.push_pin,color: Colors.orange,),
          ):Icon(Icons.push_pin_outlined,color: Colors.grey,),
          Container(
            width: screenWidth*.05,
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: screenWidth * .035,
              ),
              Container(
                width: screenWidth * .85,
                height: screenWidth * .06 * 6,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white10,
                    border: Border.all(color: Colors.white, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.1),
                        blurRadius: 100,
                        spreadRadius: 2,
                        offset: Offset(0, 3),
                      ),
                    ]
                    //borderRadius: BorderRadius.circular(10),
                    ),
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      child: Container(
                        height: 10,
                        width: 100,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle, color: _colorM),
                      ),
                    ),
                    Container(
                      width: screenWidth * .75,
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Text(
                            data["title"],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * .0103,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * .07, right: screenWidth * .07),
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white10,
                      border: Border.all(color: Colors.white, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.1),
                          blurRadius: 100,
                          spreadRadius: 2,
                          offset: Offset(0, 3),
                        ),
                      ]
                      //borderRadius: BorderRadius.circular(10),
                      ),
                  width: screenWidth,
                  height: screenWidth * .0416 * 3,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * .07,
                        right: screenWidth * .0416,
                        top: screenHeight * .0105,
                        bottom: screenHeight * .0105),
                    child: Align(
                      alignment: Alignment.center,
                      child: data["isdead"]
                          ? Text(
                              data["deadline"],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black.withOpacity(.6)),
                            )
                          : Text(
                              "No Deadline",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black.withOpacity(.6)),
                            ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * .0163,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * .07, right: screenWidth * .07),
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white10,
                      border: Border.all(color: Colors.white, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.1),
                          blurRadius: 100,
                          spreadRadius: 2,
                          offset: Offset(0, 3),
                        ),
                      ]
                      //borderRadius: BorderRadius.circular(10),
                      ),
                  width: screenWidth,
                  height: screenWidth * .0416 * 4,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * .07,
                        right: screenWidth * .0416,
                        top: screenHeight * .0105,
                        bottom: screenHeight * .0105),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("")),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * .0063,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * .07, right: screenWidth * .07),
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white10,
                      border: Border.all(color: Colors.white, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.1),
                          blurRadius: 100,
                          spreadRadius: 2,
                          offset: Offset(0, 3),
                        ),
                      ]
                      //borderRadius: BorderRadius.circular(10),
                      ),
                  width: screenWidth,
                  height: screenWidth * .0416 * 20,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Is This Task Have Deadline ? "),
                            Transform.scale(
                              scale: .6,
                            ),
                          ],
                        ),
                        Container(
                          width: screenWidth * .7,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * .04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      height: screenHeight * 0.0526 < 40
                          ? 40
                          : screenHeight * 0.0526,
                      width: screenWidth * .4,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            elevation: MaterialStateProperty.all(0),
                            side: MaterialStateProperty.all(
                                BorderSide(width: 1, color: Colors.red)),
                            overlayColor: MaterialStateProperty.all(
                                Colors.redAccent.withOpacity(.5))),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Delete",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      )),
                  Container(
                      height: screenHeight * 0.0526 < 40
                          ? 40
                          : screenHeight * 0.0526,
                      width: screenWidth * .4,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                          //elevation: MaterialStateProperty.all(0),
                          //shape: MaterialStateProperty.all(),
                        ),
                        onPressed: () {},
                        child: data["isfav"]?Text(
                          "UnPin Todo",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ):Text(
                          "Pin Todo",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: screenHeight * .1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
