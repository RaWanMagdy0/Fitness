import '../../../domain/entity/profile/user.dart';

class UserModel {
  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.activityLevel,
    this.goal,
    this.photo,
    this.createdAt,
    this.passwordResetCode,
    this.passwordResetExpires,
    this.resetCodeVerified,
    this.passwordChangedAt,
  });

  UserModel.fromJson(dynamic json) {
    id = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    gender = json['gender'];
    age = json['age'];
    weight = json['weight'];
    height = json['height'];
    activityLevel = json['activityLevel'];
    goal = json['goal'];
    photo = json['photo'];
    createdAt = json['createdAt'];
    passwordResetCode = json['passwordResetCode'];
    passwordResetExpires = json['passwordResetExpires'];
    resetCodeVerified = json['resetCodeVerified'];
    passwordChangedAt = json['passwordChangedAt'];
  }

  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  int? age;
  int? weight;
  int? height;
  String? activityLevel;
  String? goal;
  String? photo;
  String? createdAt;
  String? passwordResetCode;
  String? passwordResetExpires;
  bool? resetCodeVerified;
  String? passwordChangedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['email'] = email;
    map['gender'] = gender;
    map['age'] = age;
    map['weight'] = weight;
    map['height'] = height;
    map['activityLevel'] = activityLevel;
    map['goal'] = goal;
    map['photo'] = photo;
    map['createdAt'] = createdAt;
    map['passwordResetCode'] = passwordResetCode;
    map['passwordResetExpires'] = passwordResetExpires;
    map['resetCodeVerified'] = resetCodeVerified;
    map['passwordChangedAt'] = passwordChangedAt;
    return map;
  }

  User toEntity() {
    return User(
        id: id,
        firstName: firstName,
        lastName: lastName,
        email: email,
        goal: goal,
        gender: gender,
        age: age,
        weight: weight,
        height: height,
        activityLevel: activityLevel,
        photo: photo,
        createdAt: createdAt,
        passwordChangedAt: passwordChangedAt,
        passwordResetCode: passwordResetCode,
        passwordResetExpires: passwordResetExpires,
        resetCodeVerified: resetCodeVerified
    );
  }
}