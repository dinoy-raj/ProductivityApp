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
              : IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {},
                  icon: Tooltip(
                    message: "Collaborators",
                    child: Icon(
                      Icons.people,
                      color: Colors.grey[700],
                    ),
                  ),
                )
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20),
        child: NeumorphicFloatingActionButton(
          child: Icon(Icons.call),
          onPressed: () {},
        ),
      ),
    );
  }
}
