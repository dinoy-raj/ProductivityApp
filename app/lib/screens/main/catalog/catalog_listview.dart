import 'package:flutter/material.dart';

class ListCatalog extends StatefulWidget {
  const ListCatalog({Key? key}) : super(key: key);

  @override
  _ListCatalogState createState() => _ListCatalogState();
}

class _ListCatalogState extends State<ListCatalog> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: [
            Container(
              height: 40,
              width: 100,
              child: Text("hi"),
              color: Colors.blueAccent,
            ),
            Container(
              height: 40,
              width: 100,
              child: Text("hi"),
              color: Colors.blueAccent,
            ),
            Container(
              height: 40,
              width: 100,
              child: Text("hi"),
              color: Colors.blueAccent,
            ),
            Container(
              height: 40,
              width: 100,
              child: Text("hi"),
              color: Colors.blueAccent,
            ),

           ],
        );



  }
}
