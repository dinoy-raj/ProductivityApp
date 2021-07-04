import 'package:app/screens/projects/projectscreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ListView2 extends StatefulWidget {
  const ListView2({Key? key}) : super(key: key);

  @override
  _ListView2State createState() => _ListView2State();
}

class _ListView2State extends State<ListView2> {
   List<Map> list=[];

  listenDB() async {
     await Project().getLatestTasks().then((value){list=value;});
  }
  @override
  Widget build(BuildContext context) {
    print(list.length);

    return list.length==0?Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0,bottom: 20),
          child: Text(
            "You Don't Have Any Tasks Yet",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.grey),
          ),
        ),
        Container(
          height: 40,
          width: 40,
          child: Lottie.network("https://assets7.lottiefiles.com/packages/lf20_f03c4dci.json"),
        ),
      ],
    ):ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      itemCount: list.length,

      itemBuilder: (BuildContext context, int index){
        List<Map> data =  list;
        return Container(
          child: Text(data[index]["title"]),
        );

    },
    );

  }
}
