import 'package:agora_rtc_engine/rtc_engine.dart';
import 'dart:async';
import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Agora extends ChangeNotifier {
  final _appID = "b56fef490d8a41d38013a8841333dca8";
  final _appCertificate = "14b0edd725394c0ab1c6fa34a740abff";
  final _user = FirebaseAuth.instance.currentUser!;
  final _db = FirebaseFirestore.instance;
  String? _channel;
  String? _text;
  String? projectID;
  String? projectTitle;
  String? ownerUID;
  String? hostUID;
  String? token;
  List? collab;
  BuildContext? context;
  RtcEngine? _engine;
  StreamSubscription? _streamSubscription;
  StreamSubscription? _streamSubscription2;
  List<dynamic> participants = [];
  bool isInCall = false;
  bool isCallLive = false;
  bool isCreating = false;

  createChannel() async {
    isCreating = true;
    _text = "Creating channel";
    notifyListeners();

    final response = await http.post(
        Uri.parse("https://agora-app-server.herokuapp.com/getToken/"),
        body: {
          "uid": "0",
          "appID": _appID,
          "appCertificate": _appCertificate,
          "channelName": _channel,
        });

    if (response.statusCode == 200) {
      token = response.body;
      token = jsonDecode(token!)['token'];

      RtcEngineConfig config = RtcEngineConfig(_appID);
      _engine = await RtcEngine.createWithConfig(config);
      _engine!.setEventHandler(RtcEngineEventHandler(
        joinChannelSuccess: (channel, uid, elapsed) async {
          isCreating = false;
          _text = "Group call live";
          isInCall = true;
          participants = [
            {
              'uid': _user.uid,
              'image': _user.photoURL,
              'agoraUID': uid,
              'isTalking': false,
              'isMuted': false,
            }
          ];

          await _db
              .collection("users")
              .doc(ownerUID)
              .collection("owned_projects")
              .doc(projectID)
              .collection("calls")
              .doc(channel)
              .set({
            'token': token,
            'host': hostUID,
            'participants': participants,
          });

          await _db
              .collection("users")
              .doc(ownerUID)
              .collection("alerts")
              .doc(projectID)
              .set({
            'isCallLive': true,
          }, SetOptions(merge: true));

          collab?.forEach((element) async {
            await _db
                .collection("users")
                .doc(element['uid'])
                .collection("alerts")
                .doc(projectID)
                .set({
              'isCallLive': true,
            }, SetOptions(merge: true));
          });

          _streamSubscription = await _db
              .collection("users")
              .doc(ownerUID)
              .collection("owned_projects")
              .doc(projectID)
              .collection("calls")
              .doc(channel)
              .snapshots()
              .listen((event) {
            if (event.exists) {
              participants = event.get('participants');
              int index = 0;
              for (Map element in participants) {
                if (element['uid'] == _user.uid) break;
                index++;
              }
              participants.insert(0, participants.removeAt(index));
              notifyListeners();
            }
          });
        },
        error: (error) {
          "Error. Please try again";
          _engine?.destroy();
          _engine = null;
          notifyListeners();
        },
        audioVolumeIndication: (speakers, totalVolume) {
          if (speakers.isNotEmpty && participants.isNotEmpty) {
            if (speakers[0].volume > 50)
              participants[0]['isTalking'] = true;
            else
              participants[0]['isTalking'] = false;

            participants.forEach((participant) {
              participant['isTalking'] = false;
              speakers.forEach((element) {
                if (element.uid == participant['agoraUID'])
                  participant['isTalking'] = true;
              });
            });

            if (speakers[0].vad == 1)
              participants[0]['isTalking'] = true;
            else
              participants[0]['isTalking'] = false;

            notifyListeners();
          }
        },
      ));

      await _engine!.enableAudio();
      await _engine!.enableAudioVolumeIndication(200, 3, true);
      await _engine!.joinChannel(token, _channel, null, 0);
    } else {
      _text = "Failed to create channel. Try again";
      notifyListeners();
    }
  }

  joinChannel() async {
    _text = "Connecting";
    notifyListeners();

    await _db
        .collection("users")
        .doc(ownerUID)
        .collection("owned_projects")
        .doc(projectID)
        .collection("calls")
        .doc(_channel)
        .get()
        .then((value) async {
      hostUID = value.get('host');
      token = value.get('token');

      RtcEngineConfig config = RtcEngineConfig(_appID);
      _engine = await RtcEngine.createWithConfig(config);
      _engine!.setEventHandler(RtcEngineEventHandler(
        joinChannelSuccess: (channel, uid, elapsed) async {
          _text = "Group call live";
          isInCall = true;

          await _db
              .collection("users")
              .doc(ownerUID)
              .collection("owned_projects")
              .doc(projectID)
              .collection("calls")
              .doc(channel)
              .get()
              .then((value) async {
            participants = value.get('participants');
            participants.insert(0, {
              'uid': _user.uid,
              'image': _user.photoURL,
              'agoraUID': uid,
              'isTalking': false,
              'isMuted': false,
            });

            await _db
                .collection("users")
                .doc(ownerUID)
                .collection("owned_projects")
                .doc(projectID)
                .collection("calls")
                .doc(channel)
                .set({
              'participants': participants,
            }, SetOptions(merge: true));

            notifyListeners();
          });

          _streamSubscription = await _db
              .collection("users")
              .doc(ownerUID)
              .collection("owned_projects")
              .doc(projectID)
              .collection("calls")
              .doc(channel)
              .snapshots()
              .listen((event) {
            if (event.exists) {
              participants = event.get('participants');
              int index = 0;
              for (Map element in participants) {
                if (element['uid'] == _user.uid) break;
                index++;
              }
              participants.insert(0, participants.removeAt(index));
              notifyListeners();
            }
          });

          if (hostUID != _user.uid)
            _streamSubscription2 = _db
                .collection("users")
                .doc(ownerUID)
                .collection("owned_projects")
                .doc(projectID)
                .collection("calls")
                .doc(_channel)
                .snapshots()
                .listen((event) async {
              if (!event.exists) {
                try {
                  await _engine?.leaveChannel();
                  await _engine?.destroy();
                  _engine = null;
                  _streamSubscription?.cancel();
                  _streamSubscription2?.cancel();
                  isInCall = false;
                  notifyListeners();
                  Navigator.pop(context!);
                } catch (e) {
                  _streamSubscription2?.cancel();
                }
              }
            });
        },
        error: (error) {
          _text = "Error. Please try again";
          _engine?.destroy();
          _engine = null;
          notifyListeners();
        },
        audioVolumeIndication: (speakers, totalVolume) {
          if (speakers.isNotEmpty && participants.isNotEmpty) {
            participants.forEach((participant) {
              participant['isTalking'] = false;
              speakers.forEach((element) {
                if (element.uid == participant['agoraUID'])
                  participant['isTalking'] = true;
              });
            });

            if (speakers[0].vad == 1)
              participants[0]['isTalking'] = true;
            else
              participants[0]['isTalking'] = false;

            notifyListeners();
          }
        },
      ));

      await _engine!.enableAudio();
      await _engine!.enableAudioVolumeIndication(200, 3, true);
      await _engine!.joinChannel(token, _channel, null, 0);
    });
  }

  muteChannel(muted) async {
    await _engine?.muteLocalAudioStream(muted);
    participants[0]['isMuted'] = !participants[0]['isMuted'];
    await _db
        .collection("users")
        .doc(ownerUID)
        .collection("owned_projects")
        .doc(projectID)
        .collection("calls")
        .doc(_channel)
        .update({
      'participants': participants,
    });
  }

  leaveChannel() async {
    if (participants.length == 1)
      await endChannel();
    else {
      _text = "Disconnecting";
      notifyListeners();
      await _engine?.leaveChannel();
      await _engine?.destroy();
      _streamSubscription?.cancel();
      _streamSubscription2?.cancel();
      _engine = null;
      isInCall = false;
      int index = 0;
      for (Map element in participants) {
        if (element['uid'] == _user.uid) break;
        index++;
      }
      participants.removeAt(index);
      notifyListeners();
      await _db
          .collection("users")
          .doc(ownerUID)
          .collection("owned_projects")
          .doc(projectID)
          .collection("calls")
          .doc(_channel)
          .update({'participants': participants});
    }
  }

  endChannel() async {
    _text = "Ending group call";
    notifyListeners();
    _streamSubscription?.cancel();
    _streamSubscription2?.cancel();
    await _db
        .collection("users")
        .doc(ownerUID)
        .collection("owned_projects")
        .doc(projectID)
        .collection("calls")
        .doc(_channel)
        .delete();

    collab?.forEach((element) async {
      await _db
          .collection("users")
          .doc(element['uid'])
          .collection("alerts")
          .doc(projectID)
          .set({
        'isCallLive': false,
      }, SetOptions(merge: true));
    });

    await _db
        .collection("users")
        .doc(ownerUID)
        .collection("alerts")
        .doc(projectID)
        .set({
      'isCallLive': false,
    }, SetOptions(merge: true));

    await _engine?.leaveChannel();
    await _engine?.destroy();
    _engine = null;
    isInCall = false;
    notifyListeners();
  }
}

class Call extends StatefulWidget {
  Call(this.agora);
  final Agora? agora;

  @override
  State<StatefulWidget> createState() {
    return CallState(agora);
  }
}

class CallState extends State<Call> {
  CallState(this.agora);
  Agora? agora;

  @override
  void initState() {
    super.initState();
    agora!._channel = "group_call" + agora!.projectID!;
    if (!agora!.isCallLive && agora!._engine == null && !agora!.isCreating)
      agora?.createChannel();
    else if (agora!._engine == null && !agora!.isInCall && !agora!.isCreating)
      agora!.joinChannel();
    agora?.addListener(_callback);
  }

  @override
  void dispose() {
    agora?.removeListener(_callback);
    super.dispose();
  }

  void _callback() {
    if (mounted) setState(() {});
    if (agora!._text == "Error. Please try again") {
      agora?.removeListener(_callback);
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 3, right: 10),
            child: Row(
              children: [
                Text(
                  agora!._text!,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (agora!._text != "Error. Please try again")
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
          if (agora!._text == "Group call live")
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 15, right: 15),
              child: Text(
                agora!.projectTitle!,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (agora!._text == "Group call live")
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
            height: 10,
          ),
          if (agora!._text == "Group call live")
            Container(
              padding: EdgeInsets.only(left: 5, right: 5),
              height: 80,
              child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                  ),
                  itemCount: agora!.participants.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: agora!.participants[index]['isMuted']
                              ? Colors.red[200]
                              : agora!.participants[index]['isTalking']
                                  ? Colors.green[200]
                                  : Colors.transparent,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                                agora!.participants[index]['image']),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          if (agora!._text == "Group call live")
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  if (agora!.hostUID == agora!._user.uid)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () async {
                          await agora?.endChannel();
                          Navigator.pop(context);
                        },
                        child: Text(
                          "End Call",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  Expanded(
                    child: TextButton(
                      onPressed: () async {
                        await agora?.leaveChannel();
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Text(
                        "Leave Call",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () async {
                        await agora
                            ?.muteChannel(!agora!.participants[0]['isMuted']);
                      },
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Text(
                        agora!.participants[0]['isMuted'] ? "Unmute" : "Mute",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
