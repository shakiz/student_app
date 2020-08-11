import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_app/helper/db_helper.dart';
import 'package:student_app/models/student.dart';

class StudentDetails extends StatefulWidget {
  Student student;
  String title;
  StudentDetails(this.student, this.title);

  @override
  State<StatefulWidget> createState() {
    //student details state
    return StudentDetailsState(this.student, this.title);
  }
}

class StudentDetailsState extends State<StudentDetails> {
  static var _grade = ["Class 4", "Class 5"];
  TextEditingController nameEditor = TextEditingController();
  TextEditingController dobEditor = TextEditingController();
  TextEditingController fathersNameEditor = TextEditingController();
  TextEditingController mothersNameEditor = TextEditingController();

  DatabaseHelper _databaseHelper;
  Student _student;
  String title;

  StudentDetailsState(this._student, this.title);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    nameEditor.text = _student.name;
    dobEditor.text = _student.dob;
    mothersNameEditor.text = _student.mothersName;
    fathersNameEditor.text = _student.fathersName;

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper();
    }
    return WillPopScope(
      onWillPop: () {
        onBackPressed();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Colors.orange,
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
                  onChanged: (value) {
                    _student.name = value;
                    debugPrint("Name $value");
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
                  onChanged: (value) {
                    _student.dob = value;
                    debugPrint("DOB $value");
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
                  onChanged: (value) {
                    _student.mothersName = value;
                    debugPrint("Mothers Name $value");
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
                  onChanged: (value) {
                    _student.fathersName = value;
                    debugPrint("Fathers Name $value");
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
          backgroundColor: Colors.orange,
          onPressed: () {
            _saveOrEdit();
            debugPrint("Save clicked");
          },
        ),
      ),
    );
  }

  //region perform save or edit operation
  void _saveOrEdit() async {
    print(_student.name);
    int result = await _databaseHelper.add(_student);
    if (result != 0) {
      _showAlertDialog('Status', 'Record added successfully');
    } else {
      _showAlertDialog('Status', 'Record addition failed');
    }
  }
  //endregion

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  //region on back pressed call back
  void onBackPressed() {
    Navigator.pop(context, true);
  }
  //endregion
}
