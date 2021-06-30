import 'package:app/screens/projects/project_edits.dart';
import 'package:app/screens/projects/projectscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          project!.owner!['uid'] == _user.uid
              ? IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProjectEditing(
                                  project: project,
                                )));
                  },
                  icon: Tooltip(
                    message: "Edit Project",
                    child: Icon(
                      Icons.edit,
                      color: Colors.grey[700],
                    ),
                  ),
                )
              : SizedBox(),
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
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
          children: [
            DrawerHeader(child: Text("Collaborators")),
            ListView.builder(
                itemCount: project!.collab!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: project!.collab![index]['name'],
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20),
        child: NeumorphicFloatingActionButton(
          child: Icon(Icons.call),
          onPressed: () {},
        ),
      ),
      body: Padding(
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
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey[700]!)
              ),
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
      ),
    );
  }
}
