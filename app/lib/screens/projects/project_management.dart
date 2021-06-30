import 'package:app/screens/projects/projectscreen.dart';
import 'package:flutter/material.dart';

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

  final Project? project;

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}