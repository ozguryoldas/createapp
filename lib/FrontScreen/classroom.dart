import 'package:attendence_app/FrontScreen/addClassForm.dart';
import 'package:attendence_app/FrontScreen/loginSignup.dart';
import 'package:attendence_app/FrontScreen/profile.dart';
import 'package:flutter/material.dart';
import './class.dart';
import 'dart:convert';
import 'package:http/http.dart'as http;

class Classroom extends StatefulWidget {
  Classroom(this.user, {Key? key}) : super(key: key);
  User1 user;

  @override
  State<Classroom> createState() => _ClassroomState();
}

class _ClassroomState extends State<Classroom> {

  List<Classes1> classList = [];

  getClasses() async {
    final response = await http.get(
        Uri.parse("https://script.google.com/macros/s/AKfycbzU3UfJ86OA_VXBXB8cDASbWDfgbQlsaw_Rbqako3rUHEgPQNbB5yMlkvvBxQRQvHgF_w/exec?action=getClasses"));
    var notesJson = jsonDecode(response.body);
    for (var x in notesJson) {
      Classes1 classes = Classes1(x["ClassID"], x["ClassName"], x["TeacherEmail"]);
      if (widget.user.teacherEmail == x["TeacherEmail"]) {
        classList.add(classes);
      }
    }
    return classList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.user.teacherName}"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.face),
            tooltip: "Profile",
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Profile(widget.user),
                  )
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black,
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: FutureBuilder(
                  future: getClasses(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return const Center(
                        child: Text(
                          "Loading...",
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }
                    else {
                      return Column(
                        children: [
                          for (int i = 0; i < snapshot.data.length; i++)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => ClassData(snapshot.data[i])
                                      )
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: SizedBox(
                                    height: 150.0,
                                    width: MediaQuery.of(context).size.width,
                                    child: Card(
                                      color: Colors.amber,
                                      elevation: 25.0,
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(top: 40.0),
                                            child: Text(
                                              "${snapshot.data[i].ClassID}",
                                              style: const TextStyle(
                                                fontSize: 30.0,
                                                decoration: TextDecoration.underline,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10.0),
                                            child: Text(
                                              "${snapshot.data[i].ClassName}",
                                              style: const TextStyle(
                                                fontSize: 20.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                        ],
                      );
                    }
                  }
              ),
            )
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => addClassForm(widget.user),
              ),
            );
          }
      ),
    );
  }
}

class Classes1{
  final String ClassID;
  final String ClassName;
  final String TeacherEmail;
  Classes1(this.ClassID,this.ClassName,this.TeacherEmail);
}