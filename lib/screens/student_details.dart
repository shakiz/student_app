import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_app/helper/db_helper.dart';
import 'package:student_app/models/student.dart';

class StudentDetails extends StatefulWidget {
  StudentDetails();

  @override
  State<StatefulWidget> createState() {
    //student details state
    return StudentDetailsState();
  }
}

class StudentDetailsState extends State<StudentDetails> {
  String appBarTitle;
  static var _grade = ["Class 4", "Class 5"];
  TextEditingController nameEditor = TextEditingController();
  TextEditingController dobEditor = TextEditingController();
  TextEditingController fathersNameEditor = TextEditingController();
  TextEditingController mothersNameEditor = TextEditingController();

  DatabaseHelper _databaseHelper = DatabaseHelper();

  Student student;

  StudentDetailsState();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return WillPopScope(
      onWillPop: () {
        onBackPressed();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Student Details"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              onBackPressed();
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15, left: 10, right: 10),
          child: ListView(
            children: <Widget>[
              //Student grade
              ListTile(
                title: DropdownButton(
                  items: _grade.map((String dropDownValue) {
                    return DropdownMenuItem<String>(
                      value: dropDownValue,
                      child: Text(dropDownValue),
                    );
                  }).toList(),
                  style: textStyle,
                  value: "Class 4",
                  onChanged: (selectedValue) {
                    setState(() {
                      debugPrint('User selected option $selectedValue');
                    });
                  },
                ),
              ),
              //Name
              Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: TextField(
                  style: textStyle,
                  controller: nameEditor,
                  onChanged: (value) {
                    debugPrint("Name $value");
                    nameEditor.text;
                  },
                  decoration: InputDecoration(
                      labelText: "Name",
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
              ),
              //DOB
              Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: TextField(
                  style: textStyle,
                  controller: dobEditor,
                  onChanged: (value) {
                    debugPrint("DOB $value");
                    dobEditor.text;
                  },
                  decoration: InputDecoration(
                      labelText: "Date of birth",
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
              ),
              //Mothers name
              Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: TextField(
                  style: textStyle,
                  controller: fathersNameEditor,
                  onChanged: (value) {
                    debugPrint("Mothers Name $value");
                    mothersNameEditor.text;
                  },
                  decoration: InputDecoration(
                      labelText: "Mothers Name",
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
              ),
              //Fathers name
              Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: TextField(
                  style: textStyle,
                  controller: mothersNameEditor,
                  onChanged: (value) {
                    debugPrint("Fathers Name $value");
                    fathersNameEditor.text;
                  },
                  decoration: InputDecoration(
                      labelText: "Fathers Name",
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: "Save",
          child: Icon(Icons.save),
          onPressed: () {
            debugPrint("Save clicked");
            student.name = nameEditor.text;
            student.dob = nameEditor.text;
            student.fathersName = fathersNameEditor.text;
            student.mothersName = mothersNameEditor.text;
            _saveOrEdit();
          },
        ),
      ),
    );
  }

  void onBackPressed() {
    Navigator.pop(context, true);
  }

  //region perform save or edit operation
  void _saveOrEdit() async {
    int result = await _databaseHelper.add(student);
    if (result != 0) {
      final snackBar = SnackBar(content: Text("Student Added"));
      Scaffold.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(content: Text("Student Not Added"));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }
  //endregion
}
