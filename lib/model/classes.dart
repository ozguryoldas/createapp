class Classes {
  String ClassID, ClassName, TeacherEmail;

  Classes(this.ClassID, this.ClassName, this.TeacherEmail);

  Classes.fromJson (Map<String, dynamic> json):
        ClassID = json["ClassID"],
        ClassName = json["ClassName"],
        TeacherEmail = json["TeacherEmail"];

  Map<String, dynamic> toJson() => {
    "ClassID": ClassID,
    "ClassName": ClassName,
    "TeacherEmail": TeacherEmail
  };
}