import 'dart:convert';
import 'package:attendence_app/FrontScreen/Signup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'mainScreen.dart';

class LoginSignUp extends StatefulWidget {
  const LoginSignUp({Key? key}) : super(key: key);

  @override
  State<LoginSignUp> createState() => _LoginSignUpState();
}

class _LoginSignUpState extends State<LoginSignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  List<User1> users = [];

  fetchNotes() async {
    final response = await http.get(Uri.parse('https://script.google.com/macros/s/AKfycbxUX_3HZZzXKIcMNWRr4S_BgJyEghj8sACssjLkErfrxcVKTiNHF-nrd-KrscA5WqtzvQ/exec?action=getTeacher'));
    var notesJson = jsonDecode(response.body);
    for(var u in notesJson){
      User1 user =User1(u["teacherEmail"], u["password"], u["teacherName"], u["phoneNum"]);
      users.add(user);
    }
    return users;
  }

  // checkEmailPassword(a,b,c){
  //   for(var i =0;i<a.length;i++) {
  //     if(a[i].teacherEmail==b && a[i].password==c){
  //       print(out);
  //       // return out;
  //     }
  //   else{
  //     out = false;
  //     print(out);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    fetchNotes();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/unigoa.jpg'),
              TextFormField(
                autofocus: true,
                controller: emailController,
                decoration: const InputDecoration(
                    hintText: 'Email'
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                      hintText: 'Password'
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  var flag = 0;
                  for(var i=0;i<users.length;i++) {
                    if(users[i].teacherEmail==emailController.text &&  users[i].password==passwordController.text) {
                      flag = 1;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreen(users[i])),
                      );
                    }
                  }
                  if (flag == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Center(child: Text("Please insert correct EmailID & Password"))));
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Center(
                      child: Text('Login'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ElevatedButton(
                    onPressed:(){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Signup()),
                      );
                    },
                    child: const Text("Signup... Create New Account"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class User1{
  final String? teacherEmail;
  final String? password;
  final String? teacherName;
  final String? phoneNum;
  User1(this.teacherEmail, this.password, this.teacherName, this.phoneNum);
}