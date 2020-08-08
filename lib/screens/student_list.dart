import 'package:flutter/material.dart';
import 'package:student_app/screens/student_details.dart';
import 'package:student_app/helper/db_helper.dart';
import 'package:student_app/models/student.dart';
import 'package:sqflite/sqflite.dart';

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
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Student List"),
      ),
      body: getStudentList(),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add",
        child: Icon(Icons.add),
        onPressed: () {
          performNavigation();
        },
      ),
    );
  }

  ListView getStudentList() {
    TextStyle textStyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.lightGreenAccent,
                child: Icon(Icons.keyboard_arrow_right),
              ),
              title: Text(
                students[position].name,
                style: textStyle,
              ),
              subtitle: Text(
                students[position].fathersName,
                style: textStyle,
              ),
              trailing: GestureDetector(
                child: Icon(Icons.delete_forever, color: Colors.blueGrey),
                onTap: () {
                  _deleteRecord(context, students[position]);
                },
              ),
              onTap: () {
                performNavigation();
              },
            ),
          );
        });
  }

  void performNavigation() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return StudentDetails();
    }));
  }

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
