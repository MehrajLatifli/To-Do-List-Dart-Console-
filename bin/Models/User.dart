

import 'Abstract/Human.dart';


class User<T extends String, T2 extends double> extends Human {
  T? idUser;
  T? schoolname;
  T? password;
  T2? grade;

  T? get Get_idUser => this.idUser;

  void Set_idUser(T? idUser) {
    this.idUser = idUser;
  }

  T? get Get_schoolname => this.schoolname;

  void Set_schoolname(T? schoolname) {
    this.schoolname = schoolname;
  }

  T? get Get_password => this.password;

  void Set_password(T? password) {
    this.password = password;
  }

  T2? get Get_grade => this.grade;

  void Set_grade(T2? grade) {
    this.grade = grade;
  }

  User(T? name, T2? age,idUser, schoolname, password, grade)
      : super(name, age) {
    this.idUser=idUser;
    this.schoolname=schoolname;
    this.password=password;
    this.grade=grade;

  }

   User.logIn(T? name, T? password)  : super(name, null) {
     this.idUser=null;
     this.schoolname=null;
     this.password=password;
     this.grade=null;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['name'] as T?,
      json['age'] != null ? (json['age'] as num).toDouble() as T2? : null,
      json['idUser'] as T?,
      json['schoolname'] as T?,
      json['password'] as T?,
      json['grade'] != null ? (json['grade'] as num).toDouble() as T2? : null,
    );
  }


  Map<String, dynamic> toJson() {
    return {

      'name': name,
      'age': age,
      'idUser': idUser,
      'schoolname': schoolname,
      'password': password,
      'grade': grade
    };
  }



  @override
  void humanInfo() {
    // TODO: implement humanInfo
  }

  void userInfo() {
    // TODO: implement userInfo
  }
}
