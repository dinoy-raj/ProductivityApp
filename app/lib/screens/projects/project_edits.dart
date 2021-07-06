import 'dart:math';
import 'package:do_it/screens/projects/projectscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProjectEditing extends StatefulWidget {
  ProjectEditing({this.project});

  final Project? project;

  @override
  _ProjectEditingState createState() => _ProjectEditingState(project: project);
}

class _ProjectEditingState extends State<ProjectEditing> {
  _ProjectEditingState({this.project});

  final Project? project;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _collabController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _dropdownValue;
  List collab = [];
  List suggestions = [];
  bool _loading = false;

  addData() async {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random.secure();

    String id = String.fromCharCodes(Iterable.generate(
        15, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("owned_projects")
        .doc(id)
        .set({
      'title': _titleController.text,
      'type': _dropdownValue,
      'body': _descController.text,
      'collab': collab,
      'progress': 0.0,
    });

    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("alerts")
        .doc(id)
        .set({
      'isCallLive': false,
      'unreadGroupChatCount': 0,
    });

    collab.forEach((element) async {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(element['uid'])
          .collection("other_projects")
          .doc(id)
          .set({
        'owner': FirebaseAuth.instance.currentUser?.uid,
      });
    });

    collab.forEach((element) async {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(element['uid'])
          .collection("alerts")
          .doc(id)
          .set({
        'isCallLive': false,
        'unreadGroupChatCount': 0,
      });
    });
  }

  updateData() async {
    project!.collab!.forEach((element) async {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(element['uid'])
          .collection("other_projects")
          .doc(project!.id)
          .delete();
    });

    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("owned_projects")
        .doc(project!.id)
        .update({
      'title': _titleController.text,
      'type': _dropdownValue,
      'body': _descController.text,
      'collab': collab,
    });

    collab.forEach((element) async {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(element['uid'])
          .collection("other_projects")
          .doc(project!.id)
          .set({
        'owner': FirebaseAuth.instance.currentUser?.uid,
      });
    });
  }

  deleteData() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("owned_projects")
        .doc(project!.id)
        .delete();

    project!.collab!.forEach((element) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(element['uid'])
          .collection("other_projects")
          .doc(project!.id)
          .delete();
    });
  }

  searchUsers() {
    bool found = false;
    if (_collabController.text.trim().isNotEmpty) {
      FirebaseFirestore.instance
          .collection("users")
          .snapshots()
          .forEach((users) {
        for (var user in users.docs) {
          if (mounted)
            setState(() {
              if (user.id != FirebaseAuth.instance.currentUser?.uid &&
                  (user.get('email').contains(RegExp(
                          r'' + _collabController.text,
                          caseSensitive: false)) ||
                      user
                          .get('name')
                          .toLowerCase()
                          .contains(_collabController.text.toLowerCase()))) {
                bool existing = false;
                collab.forEach((_user) {
                  if (_user['uid'] == user.id) existing = true;
                });
                suggestions.forEach((_user) {
                  if (_user['uid'] == user.id) existing = true;
                });
                if (!existing) {
                  suggestions.add({
                    'name': user.get('name'),
                    'email': user.get('email'),
                    'image': user.get('image'),
                    'uid': user.id
                  });
                  found = true;
                }
              }
            });
          if (suggestions.length == 5) break;
        }
      });
    }
    if (!found && mounted)
      setState(() {
        suggestions.clear();
      });
  }

  @override
  void initState() {
    super.initState();
    if (project != null) {
      project!.collab!.forEach((element) {
        collab.add(element);
      });
      _titleController.text = project!.title!;
      _descController.text = project!.body!;
      _dropdownValue = project!.type!;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _collabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white10,
          leading: IconButton(
              splashRadius: .5,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Tooltip(
                message: "Exit Without Saving",
                child: Icon(
                  Icons.cancel,
                  color: Colors.black,
                ),
              )),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      project == null ? "Add Project" : "Edit Project",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 30, bottom: 20),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          return value == null || value.trim().isEmpty
                              ? "Cannot be empty"
                              : null;
                        },
                        autofocus: true,
                        controller: _titleController,
                        maxLines: 1,
                        textCapitalization: TextCapitalization.sentences,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                        decoration: InputDecoration(
                          hintText: "Project Title",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          disabledBorder: InputBorder.none,
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.1),
                              blurRadius: 100,
                              spreadRadius: 2,
                              offset: Offset(0, 3),
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red))),
                          hint: Text("Project Type"),
                          value: _dropdownValue,
                          validator: (String? value) {
                            return value == null || value.trim().isEmpty
                                ? ""
                                : null;
                          },
                          onChanged: (newValue) {
                            setState(() {
                              _dropdownValue = newValue!;
                            });
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          items: <String>[
                            'Construction',
                            'IT',
                            'Service',
                            'Business',
                            'Social',
                            'Educational',
                            'Community',
                            'Research',
                            'Others'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.1),
                            blurRadius: 100,
                            spreadRadius: 2,
                            offset: Offset(0, 3),
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, top: 8, bottom: 8),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: TextFormField(
                            maxLines: 5,
                            controller: _descController,
                            textCapitalization: TextCapitalization.sentences,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: TextStyle(fontSize: 15),
                            decoration: InputDecoration(
                              hintText: "Description",
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    height: suggestions.length * 70,
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: suggestions.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              setState(() {
                                collab.add(suggestions[index]);
                                suggestions.clear();
                                _collabController.clear();
                              });
                            },
                            title: Text(
                              suggestions[index]['name'],
                              style: TextStyle(fontSize: 12),
                            ),
                            subtitle: Text(
                              suggestions[index]['email'],
                              style: TextStyle(fontSize: 10),
                            ),
                            leading: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                    height: 40,
                                    child: Image.network(
                                        suggestions[index]['image']))),
                          );
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.1),
                            blurRadius: 100,
                            spreadRadius: 2,
                            offset: Offset(0, 3),
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, top: 8, bottom: 8),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: TextFormField(
                            onChanged: (val) {
                              searchUsers();
                            },
                            controller: _collabController,
                            textCapitalization: TextCapitalization.sentences,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: TextStyle(fontSize: 15),
                            decoration: InputDecoration(
                              hintText: "Add Collaborators",
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    height: collab.length * 70,
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: collab.length,
                        itemBuilder: (context, index) {
                          bool _contains = false;
                          if (project != null)
                            project!.collab!.forEach((element) {
                              if (mapEquals(element, collab[index]))
                                _contains = true;
                            });
                          return ListTile(
                            horizontalTitleGap: 10,
                            subtitle: Text(
                              collab[index]['email'],
                              style: TextStyle(fontSize: 12),
                            ),
                            dense: true,
                            title: Text(collab[index]['name']),
                            trailing: project != null && _contains
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        collab.removeAt(index);
                                      });
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red[300],
                                    ))
                                : IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      setState(() {
                                        collab.removeAt(index);
                                      });
                                    },
                                  ),
                            leading: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                    height: 40,
                                    child:
                                        Image.network(collab[index]['image']))),
                          );
                        }),
                  ),
                ),
                SizedBox(
                  height: screenHeight * .1,
                ),
                _loading
                    ? CupertinoActivityIndicator()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 40,
                            width: screenWidth * .35,
                            child: TextButton(
                                style: ButtonStyle(
                                    overlayColor: MaterialStateProperty.all(
                                        Colors.transparent)),
                                onPressed: () async {
                                  FocusScopeNode currentFocus =
                                      FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  project == null
                                      ? Navigator.pop(context)
                                      : showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    "Are you sure you want to delete this project?",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          )),
                                                      OutlinedButton(
                                                          onPressed: () {
                                                            deleteData();
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            "Confirm",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                          ))
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                },
                                child: Text(
                                  project == null ? "Cancel" : "Delete Project",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                )),
                          ),
                          Container(
                            height: 40,
                            width: screenWidth * .4,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black),
                                ),
                                onPressed: () async {
                                  FocusScopeNode currentFocus =
                                      FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  if (_formKey.currentState!.validate() &&
                                      _dropdownValue != null) {
                                    setState(() {
                                      _loading = true;
                                    });
                                    project == null
                                        ? await addData()
                                        : await updateData();
                                    Navigator.pop(context);
                                  }
                                },
                                child: Text(
                                  project == null
                                      ? "Add Project"
                                      : "Update Project",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                )),
                          ),
                        ],
                      ),
                SizedBox(
                  height: screenHeight * .15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
