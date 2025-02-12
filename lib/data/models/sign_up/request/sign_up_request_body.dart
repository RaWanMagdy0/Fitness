class SignupRequestBody {
  SignupRequestBody({
      this.firstName, 
      this.lastName, 
      this.email, 
      this.password, 
      this.rePassword, 
      this.gender, 
      this.height, 
      this.weight, 
      this.age, 
      this.goal, 
      this.activityLevel,});

  SignupRequestBody.fromJson(dynamic json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
    rePassword = json['rePassword'];
    gender = json['gender'];
    height = json['height'];
    weight = json['weight'];
    age = json['age'];
    goal = json['goal'];
    activityLevel = json['activityLevel'];
  }
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? rePassword;
  String? gender;
  int? height;
  int? weight;
  int? age;
  String? goal;
  String? activityLevel;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['email'] = email;
    map['password'] = password;
    map['rePassword'] = rePassword;
    map['gender'] = gender;
    map['height'] = height;
    map['weight'] = weight;
    map['age'] = age;
    map['goal'] = goal;
    map['activityLevel'] = activityLevel;
    return map;
  }

}