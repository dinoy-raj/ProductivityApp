import 'package:app/screens/projects/project_edits.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({Key? key}) : super(key: key);

  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  List<Projects> ownedProjects = [];
  List<Projects> otherProjects = [];
  FirebaseFirestore _db = FirebaseFirestore.instance;
  User? _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 30, right: 30),
        child: SingleChildScrollView(
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
              StreamBuilder(
                  stream: _db
                      .collection("users")
                      .doc(_user?.uid)
                      .collection("owned_projects")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData || snapshot.hasError)
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 40),
                        child: CupertinoActivityIndicator(),
                      );
                    else {
                      snapshot.data?.docChanges.forEach((element) async {
                        if (element.type == DocumentChangeType.added) {
                          DocumentSnapshot snap = element.doc;
                          Projects newProject = Projects(
                            title: snap.get('title'),
                            body: snap.get('body'),
                            type: snap.get('type'),
                            id: snap.id,
                            collab: [],
                          );
                          newProject.owner = Collab(
                            uid: _user?.uid,
                            email: _user?.email,
                            name: _user?.displayName,
                            image: _user?.photoURL,
                          );
                          snap.get('collab').forEach((element) async {
                            DocumentSnapshot<Map<String, dynamic>> collabSnap =
                                await _db
                                    .collection("users")
                                    .doc(element)
                                    .get();
                            newProject.collab?.add(Collab(
                              uid: collabSnap.id,
                              email: collabSnap.get('email'),
                              name: collabSnap.get('name'),
                              image: collabSnap.get('image'),
                            ));
                          });
                          ownedProjects.add(newProject);
                        } else if (element.type ==
                            DocumentChangeType.modified) {
                          DocumentSnapshot snap = element.doc;
                          ownedProjects.forEach((project) {
                            if (project.id == snap.id) {
                              project.title = snap.get('title');
                              project.type = snap.get('type');
                              project.body = snap.get('body');
                              snap.get('collab').forEach((element) async {
                                DocumentSnapshot<Map<String, dynamic>>
                                    collabSnap = await _db
                                        .collection("users")
                                        .doc(element)
                                        .get();
                                project.collab?.add(Collab(
                                  uid: collabSnap.id,
                                  email: collabSnap.get('email'),
                                  name: collabSnap.get('name'),
                                  image: collabSnap.get('image'),
                                ));
                              });
                            }
                          });
                        } else {
                          ownedProjects.forEach((project) {
                            if (project.id == element.doc.id)
                              ownedProjects.remove(project);
                          });
                        }
                      });
                      if (ownedProjects.isEmpty)
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20, bottom: 40),
                          child: Text(
                            "Create a new project by clicking above",
                            style: TextStyle(color: Colors.grey),
                          ),
                        );
                      return Container(
                        height: 200,
                        child: GridView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1),
                            itemCount: ownedProjects.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 3, right: 20, top: 20, bottom: 40),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey[100],
                                      boxShadow: [
                                        BoxShadow(
                                          spreadRadius: 0,
                                            blurRadius: 10,
                                            color: Colors.grey,
                                            offset: Offset(5, 5))
                                      ]),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ownedProjects[index].title!,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
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
                                                fontSize: 10,
                                                color: Colors.grey),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      );
                    }
                  }),
              Text(
                "   Other Projects",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
              ),
              StreamBuilder(
                  stream: _db
                      .collection("users")
                      .doc(_user?.uid)
                      .collection("other_projects")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData || snapshot.hasError)
                      return Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20, bottom: 40),
                          child: CupertinoActivityIndicator());
                    else {
                      snapshot.data?.docChanges.forEach((element) async {
                        if (element.type == DocumentChangeType.added) {
                          DocumentSnapshot snap = element.doc;
                          Projects newProject = Projects(
                              title: snap.get('title'),
                              body: snap.get('body'),
                              type: snap.get('type'),
                              id: snap.id,
                              collab: []);
                          DocumentSnapshot<Map<String, dynamic>> ownerSnap =
                              await _db
                                  .collection("users")
                                  .doc(snap.get('owner'))
                                  .get();
                          newProject.owner = Collab(
                            uid: ownerSnap.id,
                            email: ownerSnap.get('email'),
                            name: ownerSnap.get('name'),
                            image: ownerSnap.get('image'),
                          );
                          otherProjects.add(newProject);
                        } else if (element.type ==
                            DocumentChangeType.modified) {
                          DocumentSnapshot snap = element.doc;
                          ownedProjects.forEach((project) {
                            if (project.id == snap.id) {
                              project.title = snap.get('title');
                              project.type = snap.get('type');
                              project.body = snap.get('body');
                              snap.get('collab').forEach((element) async {
                                DocumentSnapshot<Map<String, dynamic>>
                                    collabSnap = await _db
                                        .collection("users")
                                        .doc(element)
                                        .get();
                                project.collab?.add(Collab(
                                  uid: collabSnap.id,
                                  email: collabSnap.get('email'),
                                  name: collabSnap.get('name'),
                                  image: collabSnap.get('image'),
                                ));
                              });
                            }
                          });
                        } else {
                          otherProjects.forEach((project) {
                            if (project.id == element.doc.id)
                              otherProjects.remove(project);
                          });
                        }
                      });
                      if (otherProjects.isEmpty)
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20, bottom: 40),
                          child: Text(
                            "There are no other projects",
                            style: TextStyle(color: Colors.grey),
                          ),
                        );
                      return Container(
                        height: 200,
                        child: GridView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1),
                            itemCount: otherProjects.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 3, right: 20, top: 20, bottom: 40),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey[100],
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 0,
                                            blurRadius: 10,
                                            color: Colors.grey,
                                            offset: Offset(5, 5))
                                      ]),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          otherProjects[index].title!,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          otherProjects[index].type!,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[700]),
                                        ),
                                        Expanded(
                                          child: Text(
                                            otherProjects[index].body!,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.grey),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class Projects {
  Projects(
      {this.id, this.collab, this.type, this.body, this.title, this.owner});

  String? id;
  String? title;
  String? body;
  String? type;
  Collab? owner;
  List<Collab>? collab;
}
