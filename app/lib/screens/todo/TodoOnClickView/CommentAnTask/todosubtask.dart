import 'package:flutter/material.dart';

class TodoSubTask extends StatefulWidget {
  double screenWidth;
  TodoSubTask(this.screenWidth);

  @override
  _TodoSubTaskState createState() => _TodoSubTaskState();
}

class _TodoSubTaskState extends State<TodoSubTask> {
  TextEditingController _subtaskController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 50,
            width: widget.screenWidth,
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
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: widget.screenWidth*.4,
                    child: TextFormField(
                      maxLines: 1,
                      controller: _subtaskController,
                      style: TextStyle(
                        fontSize: 15,
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
                    ),
                  ),
                  Container(
                    width: widget.screenWidth*.15,
                    child: ElevatedButton(

                      child: Text("add",style: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold,),),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.black),
                        overlayColor: MaterialStateProperty.all(Colors.white.withOpacity(.5))
                      ),
                      onPressed: (){},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
