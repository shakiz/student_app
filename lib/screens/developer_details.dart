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
                      alignment: Alignment.center,
                      child: Hero(
                        tag: "profileIcon",
                        child: Material(
                          color: Colors.transparent,
                          child: CircleAvatar(
                            backgroundColor: Colors.black54,
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
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 0, right: 0, top: 4, bottom: 0),
                          child: Hero(
                            tag: "details",
                            child: Material(
                              color: Colors.transparent,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      "Developer Name : Sakhawat Hossain",
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 16),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 0, right: 0, top: 4, bottom: 0),
                        child: Hero(
                          tag: "org",
                          child: Material(
                            color: Colors.transparent,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    "Organization : Save The Children in Bangladesh",
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 16),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 0, right: 0, top: 4, bottom: 0),
                        child: Hero(
                          tag: "position",
                          child: Material(
                            color: Colors.transparent,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    "Position : Jr. Mobile Application Developer",
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 16),
                                  ),
                                )
                              ],
                            ),
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
