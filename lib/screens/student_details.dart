import 'dart:ffi';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController fathersNameController = TextEditingController();
  TextEditingController mothersNameController = TextEditingController();

  DatabaseHelper _databaseHelper;
  Student _student;
  String title, _dropdownValue;
  var _selectedDate = DateTime(2016, 1, 1);
  int _fabIconType;

  StudentDetailsState(this._student, this.title);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    nameController.text = _student.name;
    dobController.text = _student.dob;
    mothersNameController.text = _student.mothersName;
    fathersNameController.text = _student.fathersName;

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper();
    }

    //region set fab icon
    if (nameController.text == "") {
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
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool isInnerBoxScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 228.0,
                backgroundColor: Colors.orange,
                floating: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    title,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  background: Image.network(
                    "https://cdn.dribbble.com/users/16206/screenshots/5404422/education_icons_2x.png",
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ];
          },
          body: Padding(
            padding: EdgeInsets.only(top: 15, left: 10, right: 10),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(
                          left: 8, top: 12, bottom: 0, right: 8),
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4))),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.orange,
                                  size: 24,
                                ),
                                hint: Text("Select Grade"),
                                value: _dropdownValue,
                                isDense: true,
                                onChanged: (newValue) {
                                  setState(() {
                                    _dropdownValue = newValue;
                                    print("DropDown value $_dropdownValue");
                                  });
                                },
                                items: _grade.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: textStyle,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      )),
                  Container(
                      margin: EdgeInsets.only(
                          left: 8, top: 12, bottom: 0, right: 8),
                      child: Hero(
                          tag: "name",
                          child: Material(
                            color: Colors.transparent,
                            child: TextFormField(
                              style: textStyle,
                              controller: nameController,
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
                                  hintText: "Name",
                                  labelStyle: textStyle,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4))),
                            ),
                          ))),
                  //DOB
                  Container(
                      margin: EdgeInsets.only(
                          left: 8, top: 12, bottom: 0, right: 8),
                      child: InkWell(
                        onTap: () {
                          // Below line stops keyboard from appearing
                          FocusScope.of(context).requestFocus(new FocusNode());
                          _selectDate(context);
                        },
                        child: AbsorbPointer(
                            child: Container(
                          child: TextFormField(
                            enabled: true,
                            controller: dobController,
                            keyboardType: TextInputType.datetime,
                            style: textStyle,
                            onChanged: (value) {
                              _student.dob = value;
                              debugPrint("DOB $value");
                            },
                            decoration: InputDecoration(
                                hintText: "Date of birth",
                                labelStyle: textStyle,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4))),
                          ),
                        )),
                      )),
                  //Mothers name
                  Container(
                    margin:
                        EdgeInsets.only(left: 8, top: 12, bottom: 0, right: 8),
                    child: TextFormField(
                      controller: mothersNameController,
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
                          hintText: "Mothers Name",
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4))),
                    ),
                  ),
                  //Fathers name
                  Container(
                      margin: EdgeInsets.only(
                          left: 8, top: 12, bottom: 0, right: 8),
                      child: Hero(
                          tag: "subTitle",
                          child: Material(
                            color: Colors.transparent,
                            child: TextFormField(
                              controller: fathersNameController,
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
                                  hintText: "Fathers Name",
                                  labelStyle: textStyle,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4))),
                            ),
                          )))
                ],
              ),
            ),
          ),
        ),
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
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime.now());
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        dobController.text = "${_selectedDate.toLocal()}".split(' ')[0];
        debugPrint(dobController.text);
      });
    }
  }
  //endregion

  void validateInputs() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      _saveOrEdit();
    } else {
      _showAlertDialog("Data issue", "Please fill up the input fields");
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

  //release unused resources when no longer needed
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    dobController.dispose();
    fathersNameController.dispose();
    mothersNameController.dispose();
  }
  //endregion
}
