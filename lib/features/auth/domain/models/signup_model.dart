import 'package:trading/core/api/end_points.dart';

class SignupModel {
  int? userId;
  SignupModel({this.userId});
  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(
      userId: json[ApiKey.data],
    );
  }
}


/*
*Request Post Form Data
Form Data {
String first_name
String last_name
String email
String mobile
String password
String profile
int level_id
file passport_back
file passport
}
*Response
!Success
{
  "data": 21,
  "status": "success",
  "error": false,
  "messageAr": "تم إضافة المستخدم بنجاح",
  "messageEn": "The user has been registered"
}
!Failure
{
  "data": 0,
  "status": "fail",
  "error": true,
  "messageAr": "هذا البريد الإلكترونى موجود بالفعل",
  "messageEn": "This Email is already exist"
}

 */