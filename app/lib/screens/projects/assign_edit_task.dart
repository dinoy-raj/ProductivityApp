import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class AssignEditTask extends StatefulWidget {
  AssignEditTask({this.collaborator, this.projectID, this.task, this.ownerUID});

  final String? ownerUID;
  final String? projectID;
  final Map<String, dynamic>? collaborator;
  final Map<String, dynamic>? task;

  @override
  State<StatefulWidget> createState() {
    return _TaskState(
        collaborator: collaborator,
        projectID: projectID,
        task: task,
        ownerUID: ownerUID);
  }
}

class _TaskState extends State<AssignEditTask> {
  _TaskState({this.collaborator, this.projectID, this.task, this.ownerUID});

  final String? ownerUID;
  final String? projectID;
  final Map<String, dynamic>? collaborator;
  final Map<String, dynamic>? task;
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime? _dateTime;
  String _dateTimeString = "Deadline";
  bool _loading = false;

  addTask() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(ownerUID)
        .collection("owned_projects")
        .doc(projectID)
        .collection("tasks")
        .doc()
        .set({
      'title': _titleController.text,
      'body': _bodyController.text,
      'datetime': _dateTime,
      'collab': collaborator,
      'completed': false,
    });
  }

  updateTask() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(ownerUID)
        .collection("owned_projects")
        .doc(projectID)
        .collection("tasks")
        .doc(task!['id'])
        .update({
      'title': _titleController.text,
      'body': _bodyController.text,
      'datetime': _dateTime,
    });
  }

  deleteTask() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(ownerUID)
        .collection("owned_projects")
        .doc(projectID)
        .collection("tasks")
        .doc(task!['id'])
        .delete();
  }

  @override
  void initState() {
    super.initState();
    if (task != null) {
      _titleController.text = task!['title'];
      _bodyController.text = task!['body'];
      _dateTime = task!['datetime']?.toDate();
      _dateTimeString = (_dateTime == null
          ? "Deadline"
          : DateFormat.yMEd().add_jms().format(_dateTime!));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Card(
        margin: EdgeInsets.only(
            left: screenWidth * .05,
            right: screenWidth * .05,
            top: screenHeight * .1,
            bottom: screenHeight * .1),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 30),
            child: Column(
              children: [
                Text(
                  task == null ? "Assign Task" : "Edit Task",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800]),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: _loading
                      ? Padding(
                          padding: const EdgeInsets.all(14),
                          child: CupertinoActivityIndicator(),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                                style: ButtonStyle(
                                    overlayColor: MaterialStateProperty.all(
                                        Colors.transparent)),
                                onPressed: () async {
                                  FocusScopeNode currentFocus =
                                      FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  setState(() {
                                    _loading = true;
                                  });
                                  if (task != null) await deleteTask();
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  task == null ? "Cancel" : "Delete",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                )),
                            ElevatedButton(
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
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      _loading = true;
                                    });
                                    task == null
                                        ? await addTask()
                                        : await updateTask();
                                    Navigator.pop(context);
                                  }
                                },
                                child: Text(
                                  task == null ? "Assign" : "Update",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                )),
                          ],
                        ),
                ),
                Dialog(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 100,
                          padding: const EdgeInsets.all(20),
                          child: TextFormField(
                            controller: _titleController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (val) {
                              return val == null || val.trim().isEmpty
                                  ? "Cannot be empty"
                                  : null;
                            },
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              hintText: "Title",
                              hintStyle: TextStyle(fontSize: 20),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                            controller: _bodyController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (val) {
                              return val == null || val.trim().isEmpty
                                  ? "Cannot be empty"
                                  : null;
                            },
                            maxLines: 2,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              labelText: "Description",
                              labelStyle: TextStyle(
                                  fontSize: 18, color: Colors.grey[800]),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              TextButton(
                                style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all(
                                      Colors.grey[800]),
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                ),
                                child: Text(
                                  _dateTimeString,
                                  style: TextStyle(fontSize: 16),
                                ),
                                onPressed: () {
                                  FocusScopeNode currentFocus =
                                      FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  DatePicker.showDateTimePicker(
                                    context,
                                    onConfirm: (dateTime) {
                                      setState(() {
                                        _dateTime = dateTime;
                                        _dateTimeString = DateFormat.yMEd()
                                            .add_jms()
                                            .format(_dateTime!);
                                      });
                                    },
                                    minTime: DateTime.now(),
                                    theme: DatePickerTheme(
                                      cancelStyle: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.red),
                                      doneStyle:
                                          TextStyle(color: Colors.grey[800]),
                                    ),
                                  );
                                },
                              ),
                              if (_dateTime != null)
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _dateTime = null;
                                      _dateTimeString = "Deadline";
                                    });
                                  },
                                  icon: Icon(Icons.clear),
                                  splashRadius: 16,
                                  iconSize: 20,
                                  color: Colors.grey[800],
                                  splashColor: Colors.transparent,
                                )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
