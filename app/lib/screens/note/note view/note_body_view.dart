// import 'package:flutter/material.dart';
//
// class NoteBody extends StatefulWidget {
//   const NoteBody({Key? key}) : super(key: key);
//
//   @override
//   _NoteBodyState createState() => _NoteBodyState();
// }
//
// class _NoteBodyState extends State<NoteBody> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.white10,
//           leading: IconButton(
//               splashRadius: 10,
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: Tooltip(
//                 message: "Exit Body View",
//                 child: Icon(
//                   Icons.cancel,
//                   color: Colors.black,
//                   size: 23,
//                 ),
//               )),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: SingleChildScrollView(
//             physics: BouncingScrollPhysics(),
//             child: Text(),
//           ),
//         )
//     );
//   }
// }
