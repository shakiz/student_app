import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_app/screens/student_details.dart';
import 'package:student_app/helper/db_helper.dart';
import 'package:student_app/models/student.dart';
import 'package:sqflite/sqflite.dart';

import 'developer_details.dart';

class StudentList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    //widget state
    return StudentListState();
  }
}

class StudentListState extends State<StudentList> {
  DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Student> students;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    if (students == null) {
      students = List<Student>();
      _loadRecycler();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Student List"),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Card(
              color: Colors.white,
              elevation: 4.0,
              margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Container(
                  padding:
                      EdgeInsets.only(left: 4, top: 8, bottom: 8, right: 4),
                  child: Container(
                    margin: EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: CircleAvatar(
                            backgroundColor: Colors.orange,
                            child: Icon(
                              Icons.wc,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Total Students : " + students.length.toString(),
                            style:
                                TextStyle(color: Colors.orange, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
          Container(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    fullscreenDialog: true,
                    transitionDuration: Duration(milliseconds: 1000),
                    pageBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation) {
                      return DeveloperDetails();
                    },
                    transitionsBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation,
                        Widget child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: Card(
                color: Colors.white,
                elevation: 4.0,
                margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Container(
                    padding:
                        EdgeInsets.only(left: 4, top: 8, bottom: 8, right: 4),
                    child: Container(
                      margin: EdgeInsets.all(8),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Hero(
                              tag: "profileIcon",
                              child: Material(
                                color: Colors.transparent,
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Hero(
                              tag: "details",
                              child: Material(
                                color: Colors.transparent,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        "Developer Name : Shakil[Tap for More Details]",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
          ),
          Container(
            child: getStudentList(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add",
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.orange,
        onPressed: () {
          debugPrint('FAB clicked');
          performNavigation(Student("", "", "", ""), 'Add New Student');
        },
      ),
    );
  }

  //region get student list and card
  //wrap it into Expanded widget or Container with width, Example below.
  Expanded getStudentList() {
    return Expanded(
      child: ListView.builder(
          itemCount: count,
          itemBuilder: (BuildContext context, int position) {
            return Card(
              margin: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 8),
              color: Colors.white,
              elevation: 8.0,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: SafeArea(
                child: InkWell(
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(8),
                        child: CircleAvatar(
                          backgroundColor: Colors.orange,
                          child: Icon(
                            Icons.person_outline,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          textDirection: TextDirection.ltr,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                child: Text(
                                  students[position].name,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                child: Text(
                                  "Fathers Name : " +
                                      students[position].fathersName,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 4, 0, 4),
                                child: Text(
                                  "Mothers Name : " +
                                      students[position].mothersName,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: IconButton(
                          icon: Icon(Icons.delete_forever),
                          iconSize: 32,
                          color: Colors.orange,
                          onPressed: () {
                            _deleteRecord(context, students[position]);
                          },
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    performNavigation(
                        students[position], "Edit Student Details");
                  },
                ),
              ),
            );
          }),
    );
  }
  //endregion

  //region perform navigation
  void performNavigation(Student student, String title) async {
    bool result;
    result = await Navigator.of(context).push(
      PageRouteBuilder(
        fullscreenDialog: true,
        transitionDuration: Duration(milliseconds: 1000),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return StudentDetails(student, title);
        },
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );

    if (result) {
      _loadRecycler();
    }
  }
  //endregion

  //region perform delete operation
  void _deleteRecord(BuildContext context, Student student) async {
    int result = await _databaseHelper.delete(student.id);
    if (result != 0) {
      final snackBar = SnackBar(
        content: Text("Note Successfully Deleted"),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text("No Notes Deleted"),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
    _loadRecycler();
  }
  //endregion

  //region load recycler
  void _loadRecycler() {
    final Future<Database> dbLater = _databaseHelper.initializeDatabase();
    dbLater.then((database) {
      Future<List<Student>> listOfFutureStudents =
          _databaseHelper.getListObjectFromMap();
      listOfFutureStudents.then((students) {
        setState(() {
          this.students = students;
          this.count = students.length;
        });
      });
    });
  }
  //endregion
}
