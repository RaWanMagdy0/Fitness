class EditProfileRequestModel {
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

  EditProfileRequestModel({
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
    this.activityLevel,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (firstName != null) map['firstName'] = firstName;
    if (lastName != null) map['lastName'] = lastName;
    if (email != null) map['email'] = email;
    if (password != null) map['password'] = password;
    if (rePassword != null) map['rePassword'] = rePassword;
    if (gender != null) map['gender'] = gender;
    if (height != null) map['height'] = height;
    if (weight != null) map['weight'] = weight;
    if (age != null) map['age'] = age;
    if (goal != null) map['goal'] = goal;
    if (activityLevel != null) map['activityLevel'] = activityLevel;
    return map;
  }
}