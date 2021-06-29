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

  Future<void> updateData() async {
    List<String> list = [];
    collab.forEach((element) {
      list.add(element.uid!);
    });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("projects")
        .doc()
        .set({
      'title': _titleController.text,
      'type': dropdownValue,
      'body': _descController.text,
      'collab': list
    }, SetOptions(merge: false));
  }

  searchUsers() {
    bool found = false;
    bool existing = false;
    if (_collabController.text.trim().isNotEmpty) {
      FirebaseFirestore.instance
          .collection("users")
          .snapshots()
          .forEach((element) {
        element.docs.forEach((element) {
          setState(() {
            if (element.id != FirebaseAuth.instance.currentUser?.uid &&
                element.get('email').contains(RegExp(
                    r'' + _collabController.text,
                    caseSensitive: false))) {
              collab.forEach((user) {
                if (user.email == element.get('email')) existing = true;
              });
              if (!existing)
                suggestions.add(Collab(
                    email: element.get('email'),
                    uid: element.id,
                    image: element.get('image'),
                    name: element.get('name')));
              found = true;
            }
          });
        });
      });
    }
    if (!found)
      setState(() {
        suggestions.clear();
      });
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
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  height: suggestions.length == 0 ? 0 : 50,
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 10,
                      ),
                      itemCount: suggestions.length,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  collab.add(suggestions[index]);
                                  suggestions.clear();
                                  _collabController.clear();
                                });
                              },
                              child: Image.network(suggestions[index].image!)),
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
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  height: collab.length * 70,
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: collab.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          horizontalTitleGap: 10,
                          subtitle: Text(
                            collab[index].email!,
                            style: TextStyle(fontSize: 12),
                          ),
                          dense: true,
                          title: Text(collab[index].name!),
                          leading: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                  height: 40,
                                  child: Image.network(collab[index].image!))),
                        );
                      }),
                ),
              ),
              SizedBox(
                height: screenHeight * .1,
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
