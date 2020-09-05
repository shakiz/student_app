import 'package:flutter/material.dart';

class DeveloperDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DeveloperState();
  }
}

class DeveloperState extends State<DeveloperDetails> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        onBackPressed();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Developer Details"),
          backgroundColor: Colors.orange,
        ),
        body: Card(
          color: Colors.white,
          elevation: 4.0,
          margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
              padding: EdgeInsets.only(left: 4, top: 8, bottom: 8, right: 4),
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
    );
  }

  //region on back pressed call back
  void onBackPressed() {
    Navigator.pop(context, true);
  }
  //endregion
}
