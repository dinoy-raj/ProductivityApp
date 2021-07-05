import 'dart:async';
import 'package:intl/intl.dart';
import 'package:app/screens/projects/project_edits.dart';
import 'package:app/screens/projects/project_management.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'group_voice_call.dart';

class ProjectScreen extends StatefulWidget {
  ProjectScreen(this.agora);

  final Agora? agora;

  @override
  _ProjectScreenState createState() => _ProjectScreenState(agora);
}

class _ProjectScreenState extends State<ProjectScreen> {

  _ProjectScreenState(this.agora);

  Agora? agora;
  List<Project> ownedProjects = [];
  List<Project> otherProjects = [];
  FirebaseFirestore _db = FirebaseFirestore.instance;
  User? _user = FirebaseAuth.instance.currentUser;
  bool _loading1 = true;
  bool _loading2 = true;


  listenDB() {




    _db
        .collection("users")
        .doc(_user?.uid)
        .collection("owned_projects")
        .snapshots()
        .listen((event) {
      if (event.docs.isEmpty && mounted)
        setState(() {
          _loading1 = false;
        });

      event.docChanges.forEach((element) {
        if (element.type == DocumentChangeType.added) {
          DocumentSnapshot snap = element.doc;
          if (mounted)
            setState(() {
              ownedProjects.add(Project(
                title: snap.get('title'),
                body: snap.get('body'),
                type: snap.get('type'),
                progress: snap.get('progress').toDouble(),
                id: snap.id,
                collab: snap.get('collab'),
                owner: {
                  'uid': _user?.uid,
                  'name': _user?.displayName,
                  'email': _user?.email,
                  'image': _user?.photoURL,
                },
              ));
              _loading1 = false;
            });
        } else if (element.type == DocumentChangeType.modified) {
          DocumentSnapshot snap = element.doc;
          if (mounted)
            setState(() {
              ownedProjects.forEach((project) {
                if (project.id == snap.id) {
                  project.title = snap.get('title');
                  project.type = snap.get('type');
                  project.body = snap.get('body');
                  project.collab = snap.get('collab');
                  project.progress = snap.get('progress').toDouble();
                }
              });
            });
        } else {
          if (mounted)
            setState(() {
              Project? project;
              for (project in ownedProjects) {
                if (project.id == element.doc.id) break;
              }
              ownedProjects.remove(project);
            });
        }
      });

      if (mounted)
        setState(() {
          ownedProjects.sort((a, b) => a.progress!.compareTo(b.progress!));
        });
    });

    _db
        .collection("users")
        .doc(_user?.uid)
        .collection("other_projects")
        .snapshots()
        .listen((event) {
      if (event.docs.isEmpty && mounted)
        setState(() {
          _loading2 = false;
        });
      event.docChanges.forEach((element) {
        if (element.type == DocumentChangeType.added) {
          _db
              .collection("users")
              .doc(element.doc.get('owner'))
              .get()
              .then((owner) {
            FirebaseFirestore.instance
                .collection("users")
                .doc(element.doc.get('owner'))
                .collection("owned_projects")
                .doc(element.doc.id)
                .get()
                .then((value) {
              if (mounted)
                setState(() {
                  otherProjects.add(Project(
                    title: value.get('title'),
                    body: value.get('body'),
                    type: value.get('type'),
                    progress: value.get('progress').toDouble(),
                    id: value.id,
                    owner: {
                      'uid': owner.id,
                      'name': owner.get('name'),
                      'email': owner.get('email'),
                      'image': owner.get('image'),
                    },
                    collab: value.get('collab'),
                  ));
                  _loading2 = false;
                  otherProjects
                      .sort((a, b) => a.progress!.compareTo(b.progress!));
                });
            });
          });
        } else if (element.type == DocumentChangeType.removed) {
          if (mounted)
            setState(() {
              Project? project;
              for (project in otherProjects) {
                if (project.id == element.doc.id) break;
              }
              otherProjects.remove(project);
              otherProjects.sort((a, b) => a.progress!.compareTo(b.progress!));
            });
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      listenDB();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 60, left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Your\nProjects",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Text(
                "Add and edit your projects",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.1),
                        blurRadius: 80,
                        spreadRadius: 2,
                        offset: Offset(0, 3),
                      ),
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      child: Lottie.network(
                          "https://assets9.lottiefiles.com/packages/lf20_l2ekftsq.json"),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Have a new one?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          "Add new project   ->",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProjectEditing()));
                        },
                        icon: Icon(Icons.add),
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "   Owned Projects",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
              ),
              _loading1
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 40),
                      child: CupertinoActivityIndicator(),
                    )
                  : ownedProjects.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20, bottom: 40),
                          child: Text(
                            "Create a new project by clicking above",
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : Container(
                          height: 200,
                          child: GridView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1),
                              itemCount: ownedProjects.length,
                              itemBuilder: (context, index) {
                                Color color;
                                if (ownedProjects[index].progress! <= .2)
                                  color = Colors.grey;
                                else if (ownedProjects[index].progress! <= .4)
                                  color = Colors.red;
                                else if (ownedProjects[index].progress! <= .6)
                                  color = Colors.orange;
                                else if (ownedProjects[index].progress! <= .8)
                                  color = Colors.lime;
                                else if (ownedProjects[index].progress! < 1)
                                  color = Colors.green;
                                else
                                  color = Colors.greenAccent;
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5, right: 20, top: 20, bottom: 40),
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: 200,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: ownedProjects[index]
                                                        .progress! ==
                                                    1
                                                ? Colors.greenAccent
                                                    .withOpacity(0.25)
                                                : ownedProjects[index]
                                                            .progress! ==
                                                        0
                                                    ? Colors.grey
                                                        .withOpacity(0.25)
                                                    : Colors.white,
                                            border: Border.all(
                                                color: color, width: 1.5)),
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                height: 5,
                                                width: 15,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
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
                                                  ownedProjects[index].title!,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Text(
                                                ownedProjects[index].type!,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[700]),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  ownedProjects[index].body!,
                                                  overflow: TextOverflow.clip,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          splashColor: color.withOpacity(0.5),
                                          highlightColor:
                                              color.withOpacity(0.25),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProjectManagement(
                                                          agora: agora,
                                                          project:
                                                              ownedProjects[
                                                                  index],
                                                        )));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
              Text(
                "   Other Projects",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
              ),
              _loading2
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 40),
                      child: CupertinoActivityIndicator(),
                    )
                  : otherProjects.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20, bottom: 40),
                          child: Text(
                            "There are no other projects",
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : Container(
                          height: 200,
                          child: GridView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1),
                              itemCount: otherProjects.length,
                              itemBuilder: (context, index) {
                                Color color;
                                if (otherProjects[index].progress! <= .2)
                                  color = Colors.grey;
                                else if (otherProjects[index].progress! <= .4)
                                  color = Colors.red;
                                else if (otherProjects[index].progress! <= .6)
                                  color = Colors.orange;
                                else if (otherProjects[index].progress! <= .8)
                                  color = Colors.lime;
                                else if (otherProjects[index].progress! < 1)
                                  color = Colors.green;
                                else
                                  color = Colors.greenAccent;
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5, right: 20, top: 20, bottom: 40),
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: 200,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: otherProjects[index]
                                                        .progress! ==
                                                    1
                                                ? Colors.greenAccent
                                                    .withOpacity(0.25)
                                                : otherProjects[index]
                                                            .progress! ==
                                                        0
                                                    ? Colors.grey
                                                        .withOpacity(0.25)
                                                    : Colors.white,
                                            border: Border.all(
                                                color: color, width: 1.5)),
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 5,
                                                width: 15,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  shape: BoxShape.rectangle,
                                                  color: color,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      otherProjects[index]
                                                          .title!,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    height: 30,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      child: Image.network(
                                                          otherProjects[index]
                                                              .owner!['image']),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Text(
                                                otherProjects[index].type!,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[700]),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  otherProjects[index].body!,
                                                  overflow: TextOverflow.clip,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          splashColor: color.withOpacity(0.5),
                                          highlightColor:
                                              color.withOpacity(0.25),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProjectManagement(
                                                          agora: agora,
                                                          project:
                                                              otherProjects[
                                                                  index],
                                                        )));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}

class Project {
  Project(
      {this.id,
      this.collab,
      this.type,
      this.body,
      this.title,
      this.owner,
      this.progress});

  String? id;
  String? title;
  String? body;
  String? type;
  double? progress;
  Map<String, dynamic>? owner;
  List<dynamic>? collab;

  Future<int> getCompletedProjectCount() {
    int count = 0;
    final _db = FirebaseFirestore.instance;
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final completer = Completer<int>();

    _db
        .collection("users")
        .doc(uid)
        .collection("owned_projects")
        .get()
        .then((ownedProjects) {
      ownedProjects.docs.forEach((ownedProject) {
        if (ownedProject.get('progress') == 1) count++;
      });

      _db
          .collection("users")
          .doc(uid)
          .collection("other_projects")
          .get()
          .then((otherProjects) {
        int index = 0;
        otherProjects.docs.forEach((otherProject) {
          _db
              .collection("users")
              .doc(otherProject.get('owner'))
              .collection("owned_projects")
              .doc(otherProject.id)
              .get()
              .then((project) {
            if (project.get('progress') == 1) count++;
            index++;
            if (index == otherProjects.docs.length) completer.complete(count);
          });
        });
      });
    });

    return completer.future;
  }

  Future<int> getCompletedTaskCount() {
    int count = 0;
    final _db = FirebaseFirestore.instance;
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final completer = Completer<int>();

    _db
        .collection("users")
        .doc(uid)
        .collection("owned_projects")
        .get()
        .then((ownedProjects) async {
      for (var ownedProject in ownedProjects.docs) {
        var tasks = await ownedProject.reference.collection("tasks").get();
        tasks.docs.forEach((task) {
          if (task.get('collab')['uid'] == uid && task.get('completed'))
            count++;
        });
      }

      _db
          .collection("users")
          .doc(uid)
          .collection("other_projects")
          .get()
          .then((otherProjects) async {
        for (var otherProject in otherProjects.docs) {
          var project = await _db
              .collection("users")
              .doc(otherProject.get('owner'))
              .collection("owned_projects")
              .doc(otherProject.id)
              .get();
          var tasks = await project.reference.collection("tasks").get();
          tasks.docs.forEach((task) {
            if (task.get('collab')['uid'] == uid && task.get('completed'))
              count++;
          });
        }
        completer.complete(count);
      });
    });

    return completer.future;
  }

  Future<List<Map>> getLatestTasks() {
    List<Map> allTasks = [];
    final _db = FirebaseFirestore.instance;
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final completer = Completer<List<Map>>();

    _db
        .collection("users")
        .doc(uid)
        .collection("owned_projects")
        .get()
        .then((ownedProjects) async {
      for (var ownedProject in ownedProjects.docs) {
        var tasks = await ownedProject.reference.collection("tasks").get();
        tasks.docs.forEach((task) {
          if (task.get('collab')['uid'] == uid) {
            Map data = task.data();

            data.remove('collab');

            String deadline;
            Duration? duration =
                data['datetime']?.toDate().difference(DateTime.now());
            if (data['completed']) deadline = "Completed";
            if (data['datetime'] == null)
              deadline = "No Deadline";
            else if (duration!.isNegative)
              deadline = "Past Deadline";
            else if (duration.inMinutes <= 24 * 60)
              deadline = "Today";
            else if (duration.inMinutes <= 48 * 60)
              deadline = "Tomorrow";
            else
              deadline =
                  DateFormat.yMEd().add_jms().format(data['datetime'].toDate());

            data.remove('datetime');
            data['deadline'] = deadline;

            data['project'] = ownedProject.get('title');

            bool completed = data.remove('completed');

            if (!completed) allTasks.add(data);
          }
        });
      }

      _db
          .collection("users")
          .doc(uid)
          .collection("other_projects")
          .get()
          .then((otherProjects) async {
        for (var otherProject in otherProjects.docs) {
          var project = await _db
              .collection("users")
              .doc(otherProject.get('owner'))
              .collection("owned_projects")
              .doc(otherProject.id)
              .get();
          var tasks = await project.reference.collection("tasks").get();
          tasks.docs.forEach((task) {
            if (task.get('collab')['uid'] == uid) {
              Map data = task.data();

              data.remove('collab');

              String deadline;
              Duration? duration =
                  data['datetime']?.toDate().difference(DateTime.now());
              if (data['completed']) deadline = "Completed";
              if (data['datetime'] == null)
                deadline = "No Deadline";
              else if (duration!.isNegative)
                deadline = "Past Deadline";
              else if (duration.inMinutes <= 24 * 60)
                deadline = "Today";
              else if (duration.inMinutes <= 48 * 60)
                deadline = "Tomorrow";
              else
                deadline = DateFormat.yMEd()
                    .add_jms()
                    .format(data['datetime'].toDate());

              data.remove('datetime');
              data['deadline'] = deadline;

              data['project'] = project.get('title');

              bool completed = data.remove('completed');

              if (!completed) allTasks.add(data);
            }
          });
        }

        allTasks.sort((a, b) {
          if (a['datetime'] == null) return 1;
          return a['datetime'].compareTo(b['datetime']);
        });

        completer.complete(
            allTasks.sublist(0, allTasks.length >= 5 ? 5 : allTasks.length));
      });
    });

    return completer.future;
  }
}

/*class RandomColorModel {
  Color getColor() {
    Random random = Random();
    List<Color> colorList = [
      Colors.red,
      Colors.blue,
      Colors.pink,
      Colors.purple,
      Colors.green,
      Colors.teal,
      Colors.deepOrange,
      Colors.deepPurple,
      Colors.amber,
      Colors.cyan
    ];
    return colorList[random.nextInt(10)];
  }
}*/
