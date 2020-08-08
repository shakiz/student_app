class Student {
  int _id;
  String _name;
  String _dob;
  String _fathersName;
  String _mothersName;

  Student(
      this._id, this._name, this._dob, this._fathersName, this._mothersName);

  String get mothersName => _mothersName;

  set mothersName(String value) {
    _mothersName = value;
  }

  String get fathersName => _fathersName;

  set fathersName(String value) {
    _fathersName = value;
  }

  String get dob => _dob;

  set dob(String value) {
    _dob = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  //region get map object to save in db
  Map<String, dynamic> toMap() {
    var object = Map<String, dynamic>();
    if (_id != null) {
      object["id"] = this._id;
    }
    object["name"] = this._name;
    object["dob"] = this._dob;
    object["fName"] = this._fathersName;
    object["mName"] = this._mothersName;
  }
  //endregion

  //region get student object from map object
  Student.fromMapObject(Map<String, dynamic> map) {
    this._id = map["id"];
    this._name = map["name"];
    this._dob = map["dob"];
    this._fathersName = map["fName"];
    this._mothersName = map["mName"];
  }
  //endregion
}
