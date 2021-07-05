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
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
      ),
      body:SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height:screenWidth * .055,
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
                      width: 30,
                      child: Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                      ),
                    ),
                    Container(
                      width: screenWidth * .75,
                      height: 100,
                      child: Text(data["title"]),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * .0263,
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
                  height: screenWidth * .0416 * 5,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * .07,
                        right: screenWidth * .0416,
                        top: screenHeight * .0105,
                        bottom: screenHeight * .0105),
                    child: Align(
                        alignment: Alignment.center,
                        child: TextFormField(
                          maxLines: 1,

                          style: TextStyle(
                            fontSize: screenWidth * .047,
                            color: Colors.black.withOpacity(.6),
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            hintText: "Sub Task 1",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * .0263,
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
                  height: screenWidth * .0416 * 7,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * .07,
                        right: screenWidth * .0416,
                        top: screenHeight * .0105,
                        bottom: screenHeight * .0105),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: TextFormField(
                          maxLines: 10,

                          style: TextStyle(
                              fontSize: screenWidth * .04,
                              color: Colors.black.withOpacity(.5)),
                          decoration: InputDecoration(
                            hintText: "# Comments",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * .0263,
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
                  height: screenWidth * .0416 * 8,
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
                height: screenHeight * .08,
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
                          "Cancel",
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
                        onPressed: () {

                        },
                        child: Text(
                          "Save Task",
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
