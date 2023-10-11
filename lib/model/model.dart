class User{
  String name, teacheremail, phone, password;
  User( this.name,this.teacheremail,this.phone,this.password);
  User.fromJson(Map<String,dynamic> json) :
  // id=json['id'],
        name= json['name'],
        teacheremail=json['teacheremail'],
        phone= json['phone'],
        password= json['password'];

  Map<String,dynamic> toJson()=>{
    'name':name,
    'teacheremail':teacheremail,
    'phone':phone,
    'password':password
  };
}

class LoginUser{
  String teacheremail,password;
  LoginUser(this.teacheremail,this.password);
  LoginUser.fromJson(Map<String,dynamic> json):
        teacheremail=json['teacheremail'],
        password=json['password'];
  Map<String,dynamic> toJson()=>{
    'teacheremail': teacheremail,
    'password':password
  };
}



class Att{
  String Email, ClassID, date, time, attendance;

  Att(this.Email, this.ClassID, this.date, this.time, this.attendance);

  Att.fromJson(Map<String,dynamic> json):
        Email = json['Email'],
        ClassID = json['ClassID'],
        date = json['date'],
        time = json['time'],
        attendance = json['attendence'];

  Map<String,dynamic> toJson() => {
    'Email': Email,
    'ClassID': ClassID,
    'date': date,
    'time': time,
    'attendence': attendance
  };
}