var wbook = SpreadsheetApp.openByUrl("https://docs.google.com/spreadsheets/d/1L-UZ-Oduy1LagJul-1russoZjpXhtq0jgbc77A6U4Vc/edit#gid=0");
var teacher = wbook.getSheetByName("Teacher");
var classes = wbook.getSheetByName("Class");
var lecture = wbook.getSheetByName("Lecture");
var attandance = wbook.getSheetByName("Attandance");
var loginsignup =wbook.getSheetByName("user")

function doPost(e){
  var action = e.parameter.action;
  if(action == "addTeacher"){
    return addTeacher(e);
  }
  else if(action == "addClass") {
    return addClass(e);
  }
  else if(action == "addLecture") {
    return addLecture(e);
  }
  else if(action == "addAttandance") {
    return addAttandance(e);
  }
  return -1; // if action is wrong -- safety check
}

function doGet(e){
  var action = e.parameter.action;
  if(action == "getTeacher"){
    return getTeacher(e);
  }
  else if(action == "getClass"){
    return getClass(e);
  }
  else if(action == "getClasses"){
    return getClasses(e);
  }
  else if(action == "getLectures"){
    return getLectures(e);
  }
  return -1;
}

function addAttandance(e) { // add new record to attandance table
  var newAttandance = JSON.parse(e.postData.contents);
  attandance.appendRow([newAttandance.Email,newAttandance.ClassID, newAttandance.date, newAttandance.time, newAttandance.attendence]);
  return ContentService.createTextOutput(e.postData.contents).setMimeType(ContentService.MimeType.TEXT);
}

function addTeacher(e) { // during new registration, add new record to teacher table
  var newTeacher = JSON.parse(e.postData.contents);
  teacher.appendRow([newTeacher.TeacherName,newTeacher.TeacherEmail, newTeacher.Phone,newTeacher.Password]);
  return ContentService.createTextOutput(e.postData.contents).setMimeType(ContentService.MimeType.TEXT);
}

function getTeacher(e){
  // var rows =teacher.getRange(2,1,3).getValues();
  var rows = teacher.getRange(2,1,teacher.getLastRow()-1,teacher.getLastColumn()).getValues();
  var data=[];
  for(var i =0;i<rows.length;i++){
      var row = rows[i];
      var record = {};
      record["teacherName"]= row[0];
      record["teacherEmail"]=row[1];
      record["phone"]=row[2];
      record["password"]=row[3];
      record["password"]=record["password"].toString();
      data.push(record);

  }
  var result=JSON.stringify(data);
  return ContentService.createTextOutput(result).setMimeType(ContentService.MimeType.TEXT);
}
function getClasses(e) { // return data of all classes taught by a teacher
  var rows = classes.getRange(2,1,classes.getLastRow()-1,classes.getLastColumn()).getValues();
  var data=[];
  for(var i =0;i<rows.length;i++){
    var row = rows[i];
    var record = {};
    record["ClassID"]= row[0];
    record["ClassName"]=row[1];
    record["TeacherEmail"]=row[2];
    data.push(record);
  }
  var result=JSON.stringify(data);
  return ContentService.createTextOutput(result).setMimeType(ContentService.MimeType.TEXT);
}

function addClass(e) { // on + buttonclick, adds record in class table, and appends classId in the teacher's row
  var newClass = JSON.parse(e.postData.contents);
  classes.appendRow([newClass.ClassID,newClass.ClassName, newClass.TeacherEmail]);
  return ContentService.createTextOutput(e.postData.contents).setMimeType(ContentService.MimeType.TEXT);
}

function removeClass(e) { // remove class record from class table, remove classID from teacher's row
  // e = ClassID
}

// function getClass(e) { // returns data of particular class
//   var rows = classes.getRange(2,1,classes.getLastRow()-1,classes.getLastColumn()-1).getValues();
//   var data=[];
//   for(var i =0;i<=rows.length;i++){
//     var row = rows[i];
//     var record = {};
//     record["ClassID"]= row[0];
//     record["ClassName"]=row[1];
//     record["TeacherEmail"]=row[2];
//     data.push(record);
//   }
//   var result=JSON.stringify(data);
//   return ContentService.createTextOutput(result).setMimeType(ContentService.MimeType.JSON);
// }



function addLecture(e) { // on add buttonclick in class, add record in lectures table
  var newLecture = JSON.parse(e.postData.contents);
  lecture.appendRow([newLecture.LectureID,newLecture.ClassID, newLecture.LecDay, newLecture.LecStartTime, newLecture.LecEndTime]);
  return ContentService.createTextOutput(e.postData.contents).setMimeType(ContentService.MimeType.TEXT);
}

function removeLec(e) { // remove lecture record from lecture table
  // e = LectureID
}

function getLectures(e) { // return lectures of a particular class
  var rows = lecture.getRange(2,1,sheet.getLastRow()-1,sheet.getLastColumn()-1).getValues();
  var data=[];
  for(var i =0;i<=rows.length;i++){
    var row = rows[i];
    var record = {};
    record["LectureID"]= row[0];
    record["ClassID"]= row[1];
    record["LecDay"]=row[1];
    record["LecStartTime"]=row[2];
    record["LecEndTime"]=row[3];
    data.push(record);
  }
  var result=JSON.stringify(data);
  return ContentService.createTextOutput(result).setMimeType(ContentService.MimeType.JSON);
}



// function doGet(e) {
//   var x = HtmlService.createTemplateFromFile("index");
//   var y = x.evaluate();
//   var z = y.setXFrameOptionsMode(HtmlService.XFrameOptionsMode.ALLOWALL);
//   return z;
// }

// function checkLogin(username, password) {
//   var url = 'https://docs.google.com/spreadsheets/d/1L-UZ-Oduy1LagJul-1russoZjpXhtq0jgbc77A6U4Vc/edit?usp=sharing';
//   var ss= SpreadsheetApp.openByUrl(url);
//   var webAppSheet = ss.getSheetByName("user");
//   var getLastRow =  webAppSheet.getLastRow();
//   var found_record = '';
//   for(var i = 1; i <= getLastRow; i++)
//   {
//    if(webAppSheet.getRange(i, 1).getValue().toUpperCase() == username.toUpperCase() &&
//      webAppSheet.getRange(i, 2).getValue().toUpperCase() == password.toUpperCase())
//    {
//      found_record = 'TRUE';
//    }
//   }
//   if(found_record == '')
//   {
//     found_record = 'FALSE';
//   }

//   return found_record;

// }

// function AddRecord(usernamee, passwordd, email, phone) {
//   var url = 'https://docs.google.com/spreadsheets/d/1L-UZ-Oduy1LagJul-1russoZjpXhtq0jgbc77A6U4Vc/edit?usp=sharing';
//   var ss= SpreadsheetApp.openByUrl(url);
//   var webAppSheet = ss.getSheetByName("user");
//   webAppSheet.appendRow([usernamee,passwordd,email,phone]);

// }