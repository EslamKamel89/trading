// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:trading/core/api/end_points.dart';

class SigninModel {
  int? userId;
  SigninModel({this.userId});
  factory SigninModel.fromJson(Map<String, dynamic> json) {
    return SigninModel(
      userId: json[ApiKey.data],
    );
  }

  @override
  String toString() => 'SigninModel(userId: $userId)';
}




/*
*Request >> post raw-json
{
  "user" : "eslamm_kamelllll_89@hotmail.com",
  "password" : "123456"
}
*Response
  !Success
{
  "data": 17,
  "status": "success",
  "error": false
}
!Failure
{
  "data": 0,
  "status": "fail",
  "error": true,
  "messageAr": "كلمة المرور أو المستخدم غير متاحين",
  "messageEn": "User or password not available!!"
}

 */