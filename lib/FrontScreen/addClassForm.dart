import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:attendence_app/model/classes.dart';
import 'package:flutter/material.dart';
import 'loginSignup.dart';
import 'mainScreen.dart';

class addClassForm extends StatefulWidget {
  addClassForm(this.user, {Key? key}) : super(key: key);
  User1 user;

  @override
  State<addClassForm> createState() => _addClassFormState();
}

class _addClassFormState extends State<addClassForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _classID = TextEditingController();
  TextEditingController _className = TextEditingController();
  String ClassID = "";
  String ClassName = "";
  String TeacherEmail = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Class"),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 150.0),
                  child: TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    controller: _classID,
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return "Enter Class ID";
                      }
                    },
                    decoration: const InputDecoration(
                      label: Text("Enter ClassID"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _className,
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return "Enter Class Name";
                      }
                    },
                    decoration: const InputDecoration(
                      label: Text("Enter Class Name"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        addClass();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MainScreen(widget.user)),
                        );
                      }
                    },
                    child: const Text("Submit"),
                  ),
                )
              ],
            )
        ),
      ),
    );
  }

  addClass() async {
    var tEmail;
    tEmail = widget.user.teacherEmail;
    final classes = Classes(_classID.text, _className.text, tEmail);
    String classData = jsonEncode(classes);
    var response = await http.post(
      Uri.parse("https://script.google.com/macros/s/AKfycbyZCHxey_JUEsN8d1WKwSI4u4yP91DXrqfPqEozALNvSWXkwUQEKbmyrvTWQ20-TsDNJA/exec?action=addClass"),
      body: classData,
    );
  }
}