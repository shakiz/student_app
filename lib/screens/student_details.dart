import 'dart:ffi';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_app/helper/db_helper.dart';
import 'package:student_app/models/customIcon.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static var _grade = ["Class 4", "Class 5"];
  TextEditingController nameEditor = TextEditingController();
  TextEditingController dobEditor = TextEditingController();
  TextEditingController fathersNameEditor = TextEditingController();
  TextEditingController mothersNameEditor = TextEditingController();

  DatabaseHelper _databaseHelper;
  Student _student;
  String title, _dropdownValue;
  var _selectedDate = DateTime(2016, 1, 1);
  int _fabIconType;

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

    //region set fab icon
    if (nameEditor.text == "") {
      _fabIconType = 0;
    } else {
      _fabIconType = 1;
    }
    //endregion

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
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    margin:
                        EdgeInsets.only(left: 8, top: 4, bottom: 0, right: 8),
                    child: DropdownButton<String>(
                      value: _grade[0],
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 18,
                      elevation: 8,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      underline: Container(
                        height: 2,
                        color: Colors.orange,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _dropdownValue = value;
                        });
                      },
                      items:
                          _grade.map<DropdownMenuItem<String>>((selectedValue) {
                        return DropdownMenuItem<String>(
                          value: selectedValue,
                          child: Text(selectedValue),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(left: 8, top: 4, bottom: 0, right: 8),
                    child: TextFormField(
                      style: textStyle,
                      controller: nameEditor,
                      onChanged: (value) {
                        _student.name = value;
                        debugPrint("Name $value");
                      },
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.length == 0 || value.isEmpty) {
                          return "Name can not be empty";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          labelText: "Name",
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4))),
                    ),
                  ),
                  //DOB
                  Container(
                    margin:
                        EdgeInsets.only(left: 8, top: 12, bottom: 0, right: 8),
                    child: InkWell(
                        onTap: () {
                          // Below line stops keyboard from appearing
                          FocusScope.of(context).requestFocus(new FocusNode());
                          _selectDate(context);
                        },
                        child: Container(
                          child: TextFormField(
                            enabled: false,
                            controller: dobEditor,
                            style: textStyle,
                            onChanged: (value) {
                              _student.dob = value;
                              debugPrint("DOB $value");
                            },
                            validator: (value) {
                              if (value.length == 0 || value.isEmpty) {
                                return "Date of birth can not be empty.";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                labelText: "Date of birth",
                                labelStyle: textStyle,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4))),
                          ),
                        )),
                  ),
                  //Mothers name
                  Container(
                    margin:
                        EdgeInsets.only(left: 8, top: 12, bottom: 0, right: 8),
                    child: TextFormField(
                      controller: mothersNameEditor,
                      style: textStyle,
                      onChanged: (value) {
                        _student.mothersName = value;
                        debugPrint("Mothers Name $value");
                      },
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.length == 0 || value.isEmpty) {
                          return "Mothers name can not be empty";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          labelText: "Mothers Name",
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4))),
                    ),
                  ),
                  //Fathers name
                  Container(
                    margin:
                        EdgeInsets.only(left: 8, top: 12, bottom: 0, right: 8),
                    child: TextFormField(
                      controller: fathersNameEditor,
                      style: textStyle,
                      onChanged: (value) {
                        _student.fathersName = value;
                        debugPrint("Fathers Name $value");
                      },
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.length == 0 || value.isEmpty) {
                          return "Fathers name can not be empty.";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          labelText: "Fathers Name",
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4))),
                    ),
                  )
                ],
              ),
            )),
        floatingActionButton: FloatingActionButton(
          tooltip: "Save",
          child: Icon(_iconTypes[_fabIconType].icon),
          backgroundColor: Colors.orange,
          onPressed: () {
            validateInputs();
            debugPrint("Save/Update clicked");
          },
        ),
      ),
    );
  }

  //region date picker
  Future<DateTime> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        dobEditor.text = "${_selectedDate.toLocal()}".split(' ')[0];
        dobEditor.selection = TextSelection.fromPosition(TextPosition(
            offset: dobEditor.text.length, affinity: TextAffinity.upstream));
        debugPrint(dobEditor.text);
      });
    }
  }
  //endregion

  void validateInputs() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      _saveOrEdit();
    } else {
      print('Form is invalid');
    }
  }

  //region perform save or edit operation
  void _saveOrEdit() async {
    print(_student.name);
    int result = 0;
    String message = "";
    if (_student.id == 0 || _student.id == null) {
      result = await _databaseHelper.add(_student);
      message = "Record added successfully";
    } else {
      result = await _databaseHelper.update(_student);
      message = "Record updated successfully";
    }
    if (result != 0) {
      _showAlertDialog('Status', message);
    } else {
      _showAlertDialog('Status', 'Problem occurred');
    }
  }
  //endregion

  //region show alert dialog
  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
  //endregion

  //region on back pressed call back
  void onBackPressed() {
    Navigator.pop(context, true);
  }
  //endregion

  //region get fab icon programmatically
  List<MyIcon> _iconTypes = [
    MyIcon(0, Icons.save),
    MyIcon(1, Icons.check),
  ];
  //endregion
}
