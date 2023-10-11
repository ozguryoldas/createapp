import 'package:attendence_app/FrontScreen/loginSignup.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class Profile extends StatefulWidget {
  Profile(this.user, {Key? key}) : super(key: key);
  User1? user;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
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
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Card(
              color: Colors.lightBlue,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      color: Colors.white,
                      child: const Icon(Icons.face, size: 100.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      "Name: ${widget.user!.teacherName!}",
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      "Email: ${widget.user!.teacherEmail!}",
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const MyApp(),
                            )
                        );
                      },
                      child: const Text("LogOut"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}