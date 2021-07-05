import 'package:app/screens/projects/projectscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ListView2 extends StatefulWidget {
  const ListView2({Key? key}) : super(key: key);

  @override
  _ListView2State createState() => _ListView2State();
}

class _ListView2State extends State<ListView2> {
  List<Map<dynamic, dynamic>> list = [];

  listenDB() async {
    await Project().getLatestTasks().then((value) {
      list = value;
    });
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      listenDB();
    });
  }

  @override
  Widget build(BuildContext context) {
    print(list);

    return list.length == 0
        ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                child: Text(
                  "You Don't Have Any Tasks Yet",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ),
              Container(
                height: 40,
                width: 40,
                child: Lottie.network(
                    "https://assets7.lottiefiles.com/packages/lf20_f03c4dci.json"),
              ),
            ],
          )
        : ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              List<Map> data = list;
              Color color;
              if (data[index]['deadline'] == "Today")
                color = Colors.orange[700]!;
              else if (data[index]['deadline'] == "Tomorrow")
                color = Colors.yellow[700]!;
              else if (data[index]['deadline'] == "Past Deadline")
                color = Colors.red;
              else if (data[index]['deadline'] == "No Deadline")
                color = Colors.grey[700]!;
              else
                color = Colors.green;
              return Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 20, bottom: 20, right: 20),
                child: Stack(
                  children: [
                    Container(
                      width: 270,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: color, width: 1)),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 5,
                              width: 15,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                shape: BoxShape.rectangle,
                                color: color,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Expanded(
                              flex: 0,
                              child: Text(
                                data[index]['project']!,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                data[index]['deadline'],
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                    fontSize: 10, color: Colors.grey[700]),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                data[index]['title']!,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.black.withOpacity(.6)),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                data[index]['body']!,
                                overflow: TextOverflow.clip,
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }
}
