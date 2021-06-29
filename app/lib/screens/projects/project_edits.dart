import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProjectEditing extends StatefulWidget {
  const ProjectEditing({Key? key}) : super(key: key);

  @override
  _ProjectEditingState createState() => _ProjectEditingState();
}

class _ProjectEditingState extends State<ProjectEditing> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _collabController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var dropdownValue;
  List<Collab> collab = [];
  List<Collab> suggestions = [];
  List<Collab> users = [];

  Future<void> updateData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("projects")
        .doc()
        .set({
      'title': _titleController.text,
      'type': dropdownValue,
      'body': _descController.text,
      'collab': collab
    }, SetOptions(merge: false));
  }

  getUsers() {
    FirebaseFirestore.instance.collection("users").snapshots().listen((event) {
      List<DocumentChange<Map<String, dynamic>>> list = event.docChanges;
      list.forEach((element) {
        DocumentSnapshot<Map<String, dynamic>> snap = element.doc;
        users.add(Collab(
            email: snap.get('email'), uid: snap.id, image: snap.get('image'), name: snap.get('name')));
      });
    });
  }

  searchUsers() {
    bool found = false;
    if (_collabController.text.trim().isNotEmpty)
      users.forEach((element) {
        if (element.email!.contains(
            RegExp(r'' + _collabController.text, caseSensitive: false)))
          setState(() {
            if (!suggestions.contains(element)) {
              suggestions.add(element);
            }
            found = true;
          });
      });
    if (!found)
      setState(() {
        suggestions.clear();
      });
  }

  @override
  void initState() {
    super.initState();
    getUsers();
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
    return Scaffold(
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
              Center(
                child: Text(
                  "Add Project",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 20, bottom: 20),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        return value == null || value.trim().isEmpty
                            ? ""
                            : null;
                      },
                      autofocus: true,
                      controller: _titleController,
                      maxLines: 1,
                      textCapitalization: TextCapitalization.sentences,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                        value: dropdownValue,
                        validator: (String? value) {
                          return value == null || value.trim().isEmpty
                              ? ""
                              : null;
                        },
                        onChanged: (newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
              suggestions.length == 0
                  ? SizedBox()
                  : Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 30, left: 20, right: 20),
                child: Container(
                  height: 50,
                  child: GridView.builder(
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 10,
                      ),
                      itemCount: suggestions.length,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.network(
                                suggestions[index].image.toString()));
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
              SizedBox(
                height: screenHeight * .15,
              ),
              Container(
                height: 40,
                width: screenWidth * .4,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          dropdownValue != null) {
                        updateData();
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      "Add Project",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )),
              ),
              SizedBox(
                height: screenHeight * .3,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Collab {
  Collab({this.email, this.uid, this.image, this.name});

  String? uid;
  String? image;
  String? email;
  String? name;
}
