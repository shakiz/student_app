import 'package:flutter/material.dart';

class StudentList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StudentListState();
  }
}

class StudentListState extends State<StudentList> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Student List"),
      ),
      body: getStudentList(),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add",
        child: Icon(Icons.add),
        onPressed: () {
          debugPrint("Add button pressed");
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
                "Child Item",
                style: textStyle,
              ),
              trailing: Icon(Icons.delete_forever, color: Colors.blueGrey),
              onTap: () {
                debugPrint("Test Purpose");
              },
            ),
          );
        });
  }
}
