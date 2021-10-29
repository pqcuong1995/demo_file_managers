
class UserField{
  static final List<String> value =  [
    cId,
    cPassword,
  ];
  static  String cId = "_id";
  static  String cPassword = "password";
}

class User{
  int id = 0;
  String? password;

  User({ this.password});

  User.fromJson(Map<String, Object?> map) {
    id = map[UserField.cId] != null ? map[UserField.cId] as int : 0;
    password = map[UserField.cPassword] as String;
  }

  Map<String, Object?> toJson() {
    var map = <String, Object?>{
      UserField.cPassword : password,
    };
    if(id !=0){
      map[UserField.cId] = id;
    }
    return map;
  }
}