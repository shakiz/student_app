import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudentDetails extends StatefulWidget {
  String appBarTitle;
  StudentDetails(this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    //student details state
    return StudentDetailsState(this.appBarTitle);
  }
}

class StudentDetailsState extends State<StudentDetails> {
  String appBarTitle;
  static var _grade = ["Class 4", "Class 5"];
  TextEditingController nameEditor = TextEditingController();
  TextEditingController dobEditor = TextEditingController();
  TextEditingController fathersNameEditor = TextEditingController();
  TextEditingController mothersNameEditor = TextEditingController();

  StudentDetailsState(this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
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
        },
      ),
    );
  }
}
