import 'package:app/screens/projects/project_edits.dart';
import 'package:app/screens/projects/projectscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
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
                        title:
                            Text("Start a voice call with the collaborators?"),
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
                          MaterialButton(
                              minWidth: 20,
                              color: Colors.grey[900],
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "YES",
                                style: TextStyle(
                                  color: Colors.white,
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
              padding: const EdgeInsets.only(top: 20),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(project!.owner!['image']),
                ),
                title: Text(project!.owner!['name']),
                subtitle: Text(
                  project!.owner!['email'],
                  style: TextStyle(fontSize: 12),
                ),
                trailing: Icon(
                  Icons.person,
                  color: Colors.green,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 15),
                itemCount: project!.collab!.length,
                itemBuilder: (context, index) => ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(project!.collab![index]['image']),
                  ),
                  title: Text(project!.collab![index]['name']),
                  subtitle: Text(
                    project!.collab![index]['email'],
                    style: TextStyle(fontSize: 12),
                  ),
                  trailing: Icon(Icons.person),
                ),
              ),
            )
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
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(project!.owner!['uid'])
              .collection("owned_projects")
              .doc(project!.id)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData || snapshot.hasError)
              return Center(child: CupertinoActivityIndicator());

            project!.title = snapshot.data!.get('title');
            project!.type = snapshot.data!.get('type');
            project!.body = snapshot.data!.get('body');
            project!.collab = snapshot.data!.get('collab');

            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          project!.title!,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[900]),
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
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              project!.type!,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
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
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
