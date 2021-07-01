import 'package:app/screens/projects/project_edits.dart';
import 'package:app/screens/projects/projectscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ProjectManagement extends StatefulWidget {
  ProjectManagement({this.project});

  final Project? project;

  @override
  State<StatefulWidget> createState() {
    return _ProjectState(project: project);
  }
}

class _ProjectState extends State<ProjectManagement> {
  _ProjectState({this.project});
  User _user = FirebaseAuth.instance.currentUser!;
  final Project? project;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  double _progress = 0;
  bool _progressClicked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
          _progressClicked = false;
        }
      },
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(project!.owner!['uid'])
              .collection("owned_projects")
              .doc(project!.id)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData || snapshot.hasError)
              return Scaffold(
                  body: Center(child: CupertinoActivityIndicator()));

            if (snapshot.data!.exists) {
              project!.title = snapshot.data!.get('title');
              project!.type = snapshot.data!.get('type');
              project!.body = snapshot.data!.get('body');
              project!.collab = snapshot.data!.get('collab');
              try {
                _progress = snapshot.data!.get('progress');
              } catch (e) {}
            }

            return Scaffold(
                key: _scaffoldKey,
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white10,
                  centerTitle: true,
                  leading: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Tooltip(
                        message: "Exit",
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.grey[700],
                        ),
                      )),
                  actions: [
                    IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text(
                                      "Start a voice call with the collaborators?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "NO",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "YES",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
                                  ],
                                ));
                      },
                      icon: Tooltip(
                        message: "Make call",
                        child: Icon(
                          Icons.add_call,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        _scaffoldKey.currentState!.openEndDrawer();
                      },
                      icon: Tooltip(
                        message: "Collaborators",
                        child: Icon(
                          Icons.people,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
                endDrawer: Drawer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 120,
                        child: DrawerHeader(
                          child: Text(
                            "Collaborators",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ExpansionTile(
                          textColor: Colors.black,
                          iconColor: Colors.black,
                          leading: Container(
                            decoration: BoxDecoration(
                                color: Colors.yellowAccent,
                                borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.network(project!.owner!['image']),
                              ),
                            ),
                          ),
                          title: Text(project!.owner!['uid'] == _user.uid
                              ? project!.owner!['name'] + " (You)"
                              : project!.owner!['name']),
                          subtitle: Text(
                            project!.owner!['email'],
                            style: TextStyle(fontSize: 12),
                          ),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                if (project!.owner!['uid'] != _user.uid)
                                  TextButton.icon(
                                    label: Text(
                                      "Call",
                                    ),
                                    icon: Icon(
                                      Icons.call_outlined,
                                      color: Colors.grey[800],
                                    ),
                                    style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                Colors.grey[800]),
                                        overlayColor: MaterialStateProperty.all(
                                            Colors.transparent)),
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) => Container(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      child: Text(
                                                        "Call",
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ));
                                    },
                                  ),
                                TextButton.icon(
                                  label: Text(
                                    project!.owner!['uid'] == _user.uid
                                        ? "Note"
                                        : "Chat",
                                  ),
                                  icon: Icon(
                                    project!.owner!['uid'] == _user.uid
                                        ? Icons.edit_outlined
                                        : Icons.chat_bubble_outline,
                                    color: Colors.grey[800],
                                  ),
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Colors.grey[800]),
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent)),
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) => Container(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: Text(
                                                      project!.owner!['uid'] ==
                                                              _user.uid
                                                          ? "Note"
                                                          : "Chat",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ));
                                  },
                                ),
                                if (project!.owner!['uid'] == _user.uid)
                                  TextButton.icon(
                                    icon: Icon(Icons.add_comment_outlined),
                                    label: Text("Assign"),
                                    style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                Colors.grey[800]),
                                        overlayColor: MaterialStateProperty.all(
                                            Colors.transparent)),
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) => Container(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      child: Text(
                                                        "Assign Task",
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ));
                                    },
                                  ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.only(top: 0),
                          itemCount: project!.collab!.length,
                          itemBuilder: (context, index) => ExpansionTile(
                            textColor: Colors.black,
                            iconColor: Colors.black,
                            leading: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.network(
                                    project!.collab![index]['image']),
                              ),
                            ),
                            title: Text(
                                project!.collab![index]['uid'] == _user.uid
                                    ? project!.collab![index]['name'] + " (You)"
                                    : project!.collab![index]['name']),
                            subtitle: Text(
                              project!.collab![index]['email'],
                              style: TextStyle(fontSize: 12),
                            ),
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  if (project!.collab![index]['uid'] !=
                                      _user.uid)
                                    TextButton.icon(
                                      label: Text(
                                        "Call",
                                      ),
                                      icon: Icon(
                                        Icons.call_outlined,
                                        color: Colors.grey[800],
                                      ),
                                      style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.grey[800]),
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent)),
                                      onPressed: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context) => Container(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15),
                                                        child: Text(
                                                          "Call",
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ));
                                      },
                                    ),
                                  TextButton.icon(
                                    label: Text(
                                      project!.collab![index]['uid'] ==
                                              _user.uid
                                          ? "Note"
                                          : "Chat",
                                    ),
                                    icon: Icon(
                                      project!.collab![index]['uid'] ==
                                              _user.uid
                                          ? Icons.edit_outlined
                                          : Icons.chat_bubble_outline,
                                    ),
                                    style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                Colors.grey[800]),
                                        overlayColor: MaterialStateProperty.all(
                                            Colors.transparent)),
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) => Container(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      child: Text(
                                                        project!.collab![index]
                                                                    ['uid'] ==
                                                                _user.uid
                                                            ? "Note"
                                                            : "Chat",
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ));
                                    },
                                  ),
                                  if (project!.owner!['uid'] == _user.uid ||
                                      project!.collab![index]['uid'] ==
                                          _user.uid)
                                    TextButton.icon(
                                      icon: Icon(Icons.add_comment_outlined),
                                      label: Text("Assign"),
                                      style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.grey[800]),
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent)),
                                      onPressed: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context) => Container(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15),
                                                        child: Text(
                                                          "Assign Task",
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ));
                                      },
                                    ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                floatingActionButton: project!.owner!['uid'] == _user.uid
                    ? Padding(
                        padding: const EdgeInsets.all(20),
                        child: NeumorphicFloatingActionButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProjectEditing(
                                          project: project,
                                        )));
                          },
                          child: Tooltip(
                            message: "Edit Project",
                            child: Icon(
                              Icons.edit,
                            ),
                          ),
                        ))
                    : null,
                body: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8, bottom: 8),
                              child: Text(
                                project!.title!,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[700],
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Text(
                                  project!.type!,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey[700]!)),
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            project!.body!,
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[700]),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, top: 20, bottom: 8),
                        child: Row(
                          children: [
                            Text(
                              "Progress",
                              style: TextStyle(fontSize: 20),
                            ),
                            if (project!.owner!['uid'] == _user.uid &&
                                !_progressClicked)
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _progressClicked = true;
                                  });
                                },
                                icon: Icon(Icons.edit_outlined),
                                iconSize: 16,
                                splashRadius: 16,
                              ),
                            if (_progressClicked)
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  width: 60,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    autofocus: true,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(left: 5, right: 5),
                                      hintText: "%",
                                      hintStyle: TextStyle(fontSize: 16),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Colors.transparent,
                                      )),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Colors.transparent,
                                      )),
                                    ),
                                    onSubmitted: (val) {
                                      setState(() {
                                        _progressClicked = false;
                                        try {
                                          _progress = double.parse(val) / 100;
                                          FirebaseFirestore.instance
                                              .collection("users")
                                              .doc(_user.uid)
                                              .collection("owned_projects")
                                              .doc(project!.id)
                                              .set({'progress': _progress},
                                                  SetOptions(merge: true));
                                        } catch (e) {}
                                      });
                                    },
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                      NeumorphicProgress(
                        percent: _progress,
                      )
                    ],
                  ),
                ));
          }),
    );
  }
}
