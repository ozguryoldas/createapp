import 'package:flutter/material.dart';
import '../scan/scan.dart';
import 'classroom.dart';

class ClassData extends StatefulWidget {
  ClassData(this.data, {Key? key}) : super(key: key);
  Classes1 data;

  @override
  State<ClassData> createState() => _ClassDataState();
}

class _ClassDataState extends State<ClassData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data.ClassName), // Name Of Subject
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Column(
              children: <Widget>[
                Card(
                  child: Column(
                    children: <Widget>[
                      Text(
                        widget.data.ClassName,
                        style: const TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        widget.data.ClassID,
                        style: const TextStyle(
                            fontSize: 30.0
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => scan(widget.data),
                          )
                      );
                    },
                    child: const Text("Scan"),
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