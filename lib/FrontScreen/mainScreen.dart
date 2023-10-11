import 'package:attendence_app/FrontScreen/loginSignup.dart';
import 'package:attendence_app/FrontScreen/profile.dart';
import 'package:flutter/material.dart';
import '../scan/scan.dart';
import './classroom.dart';

class MainScreen extends StatefulWidget {
  MainScreen(this.user, {Key? key}) : super(key: key);
  User1 user;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget> [
            Padding(
              padding: const EdgeInsets.only(top: 30.0,),
              child: Container(
                color: Colors.red,
                child: const Center (
                  child: Padding (
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text(
                      "GOA UNIVERSITY",
                      style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text("Department of Computer Science and Technology",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Image.asset('assets/images/unigoa.jpg'),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => Classroom(widget.user)
                    )
                );
              },
              child: const Text("CLASSROOM"),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                color: Colors.red,
                child: Center (
                    child: Padding (
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Card(
                        color: Colors.red,
                        elevation: 10.0,
                        child: Column(
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.only(left: 100.0, right: 100.0),
                              child: Text(
                                "Teacher Details",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                "Name: ${widget.user.teacherName}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                "Email: ${widget.user.teacherEmail}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}