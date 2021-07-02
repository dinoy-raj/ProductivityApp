import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class Agora extends StatefulWidget {
  Agora({this.host});

  Map<String, dynamic>? host;

  @override
  State<StatefulWidget> createState() {
    return AgoraState(host: host);
  }
}

class AgoraState extends State<Agora> {
  AgoraState({this.host});

  final _appID = "b56fef490d8a41d38013a8841333dca8";
  final _appCertificate = "14b0edd725394c0ab1c6fa34a740abff";
  String? channel;
  String? token;
  Map<String, dynamic>? host;
  List<Map<String, dynamic>>? participants;

  createChannel() async {}
  joinChannel() async {}
  leaveChannel() async {}

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 10),
          child: Row(
            children: [
              Text(
                "Group Call Live",
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  TyperAnimatedText(
                    " . . .",
                    speed: Duration(milliseconds: 300),
                    textStyle: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            "Participants",
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 18,
            ),
          ),
        ),
        SizedBox(
          height: 100,
        ),
      ],
    );
  }
}
