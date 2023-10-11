import 'dart:convert';
import 'package:attendence_app/FrontScreen/classroom.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart';
import 'View.dart';
import 'package:attendence_app/model/model.dart';

class scan extends StatefulWidget {
  scan(this.data, {Key? key}) : super(key: key);
  Classes1 data;
  @override
  State<scan> createState() => _scanState();
}

class _scanState extends State<scan> {
  List <String> uniqueID=[];
  String date1="";
  String time1="";
  String attendance0="";
  String _data ="";
  String information ="";
  bool _displayNewTextField = false;
  TextEditingController _inputdata = TextEditingController();

  _scan() async{
    return await FlutterBarcodeScanner.scanBarcode("#000000", "Cancel", true, ScanMode.BARCODE)
        .then((value) => setState(()=>_data = value));
  }

  @override
  Widget build(BuildContext context) {
    final date= DateTime.now();  //current date and time
    String date0= DateFormat.yMMMMd('en_US').format(date);
    final time = DateTime.now();
    final time0 = DateFormat.Hm().format(time);
    attendance0 = uniqueID.toString();
    date1=date0.toString();
    time1=time0.toString();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scanning"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: 40.0,
                child: ElevatedButton(
                  onPressed:()=> _scan(),
                  child: const Text("Scan"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 60.0,
                  color: Colors.black,
                  child: Center(
                    child: Text(
                      _data,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Visibility(
                    visible: _displayNewTextField,
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _inputdata,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.location_on),
                        hintText: 'Enter Unique code',
                        labelText: 'Unique ID',
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 40.0,
                  child: ElevatedButton(
                    onPressed:  () async {
                      setState(() {
                        _displayNewTextField = true;
                      });
                      _data="";
                    },
                    child: const Text("Add manually"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 60.0,
                  color: Colors.black,
                  child: Center(
                    child: Text(
                      _inputdata.text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 40.0,
                  child: ElevatedButton(
                    onPressed: (){
                      if (_data=="-1" || _data == ""){
                        information = _inputdata.text;
                      }
                      else{
                        information = _data;
                      }
                      if(information != ""){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Student ID: $information submitted")));
                        uniqueID.add(information);
                        information = "";
                        _inputdata.text ="";
                        _data="";
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Center(child: Text("Please Insert Data"))));
                      }
                    },
                    child: const Text("Submit "),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 40.0,
                  child: ElevatedButton(
                      onPressed: () {
                        print(widget.data.ClassID.toString());
                        if(!uniqueID.isEmpty){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                Cards(uniqueID:uniqueID)),
                          );
                        }
                      },
                      child: const Text("View")
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 40.0,
                  child: ElevatedButton(
                    onPressed: (){
                      // print(uniqueID.toString());
                      postAttendance();

                    },
                    child: const Text("Save and Upload"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  postAttendance() async{
    final attendance = Att(widget.data.TeacherEmail, widget.data.ClassID.toString(), date1, time1, attendance0);
    String attendanceInfo = jsonEncode(attendance);
    var response = await http.post(Uri.parse("https://script.google.com/macros/s/AKfycbznhs8Ni-TGNrC6_D7Lrc3HSLe1azW4gVdWWyqe7ijXngnhncbrtqG9cUycSq89K3sLJQ/exec?action=addAttandance"),
      body: attendanceInfo,
    );
    print(attendanceInfo);
  }
}
