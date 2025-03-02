// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:trading/core/api/end_points.dart';
import 'package:trading/core/extensions/extensions.dart';

class UserModel {
  int? id;
  String? userName;
  String? fullName;
  String? gender;
  String? email;
  String? mobile;
  DateTime? emailVerifiedAt;
  String? password;
  String? profile;
  String? passport;
  String? passportBack;
  int? levelId = 2;
  String? rememberToken;
  DateTime? createdAt;
  DateTime? updatedAt;
  double? balance;
  double? profit;
  double? daily;
  double? weekly;
  double? referral;
  String? chat;
  UserModel({
    this.id,
    this.userName,
    this.fullName,
    this.gender,
    this.email,
    this.mobile,
    this.emailVerifiedAt,
    this.password,
    this.profile,
    this.passport,
    this.passportBack,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
    this.balance,
    this.profit,
    this.daily,
    this.weekly,
    this.referral,
    this.chat,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    // print('=============');
    // print(json);
    const t = "UserModel.fromJson";
    json.toString().prm(t);
    return UserModel(
      id: json[ApiKey.data]["0"][ApiKey.id],
      userName: json[ApiKey.data]["0"][ApiKey.userName],
      fullName: json[ApiKey.data]["0"][ApiKey.fullName],
      gender: json[ApiKey.data]["0"][ApiKey.gender],
      email: json[ApiKey.data]["0"][ApiKey.email],
      mobile: json[ApiKey.data]["0"][ApiKey.mobile],
      emailVerifiedAt: json[ApiKey.data]["0"][ApiKey.emailVerifiedAt] != null
          ? DateTime.parse(json[ApiKey.data]["0"][ApiKey.emailVerifiedAt])
          : null,
      password: json[ApiKey.data]["0"][ApiKey.password],
      profile: json[ApiKey.data]["0"][ApiKey.profile],
      passport: json[ApiKey.data]["0"][ApiKey.passport],
      passportBack: json[ApiKey.data]["0"][ApiKey.passportBack],
      rememberToken: json[ApiKey.data]["0"][ApiKey.rememberToken],
      createdAt: DateTime.parse(json[ApiKey.data]["0"][ApiKey.createdAt]),
      updatedAt: DateTime.parse(json[ApiKey.data]["0"][ApiKey.updatedAt]),
      balance: json[ApiKey.data]["0"][ApiKey.balance]?.toDouble(),
      profit: json[ApiKey.data]["0"][ApiKey.profit]?.toDouble(),
      daily: json[ApiKey.data][ApiKey.daily]?.toDouble(),
      weekly: json[ApiKey.data][ApiKey.weekly]?.toDouble(),
      referral: json[ApiKey.data][ApiKey.referral]?.toDouble(),
      chat: json[ApiKey.data]["0"][ApiKey.chat],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      ApiKey.data: {
        "0": {
          ApiKey.id: id,
          ApiKey.userName: userName,
          ApiKey.fullName: fullName,
          ApiKey.gender: gender,
          ApiKey.email: email,
          ApiKey.mobile: mobile,
          ApiKey.emailVerifiedAt: emailVerifiedAt?.toString(),
          ApiKey.password: password,
          ApiKey.profile: profile,
          ApiKey.createdAt: createdAt?.toString(),
          ApiKey.updatedAt: updatedAt?.toString(),
          ApiKey.balance: balance,
          ApiKey.profit: profit,
          ApiKey.chat: chat,
        },
        ApiKey.daily: daily,
        ApiKey.weekly: weekly,
        ApiKey.referral: referral,
      }
    };
  }

  String toJsonString() => json.encode(toJson());

  // factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, userName: $userName, fullName: $fullName, gender: $gender, email: $email, mobile: $mobile, emailVerifiedAt: $emailVerifiedAt, password: $password, profile: $profile, passport: $passport, passportBack: $passportBack, levelId: $levelId, rememberToken: $rememberToken, createdAt: $createdAt, updatedAt: $updatedAt, balance: $balance, profit: $profit, daily: $daily, weekly: $weekly, referral: $referral, chat: $chat)';
  }
}


/*
*Request Get parameter userId

*Response
!Success
{
  "data": {
    "id": 17,
    "first_name": "eslam",
    "last_name": "kamel",
    "email": "eslamm_kamelllll_89@hotmail.com",
    "mobile": "01024520809",
    "email_verified_at": null,
    "password": "$2y$12$VLN/b3fY7NZ/hFkdL/2ake5ZmW7GwZd5uPP2HMeXTVUevcWMn2Xtq",
    "profile": "1714751626.png",
    "passport": "1714751626.png",
    "passport_back": "1714751626.png",
    "level_id": 2,
    "remember_token": null,
    "created_at": "2024-05-03T15:53:46.000000Z",
    "updated_at": "2024-05-03T15:53:46.000000Z"
  },
  "status": "success",
  "error": false
}
! new response
{
  "data": {
    "0": {
      "id": 24,
      "username": "",
      "first_name": "mounir",
      "last_name": "Mohamed mounir",
      "email": "admin@lambh.com",
      "mobile": "+2010000000000",
      "email_verified_at": null,
      "password": "$2y$12$OZ.NRqnDiActCELC5SGzlOu8JQ1IhNxqSI9HAaO9hQJyfbS1p453y",
      "profile": "1718454360.jpg",
      "passport": "1718451862.jpg",
      "passport_back": null,
      "level_id": 2,
      "remember_token": null,
      "active": "0",
      "block": "chat",
      "created_at": "2024-06-15 14:44:23",
      "updated_at": "2024-07-11 23:21:17",
      "balance": null,
      "profit": null
    },
    "daily": 0,
    "weekly": 0,
    "referral": null
  },
  "status": "success",
  "error": false
}

! blocked chat userdata
{
  "data": {
    "0": {
      "id": 28,
      "username": "Eslam",
      "first_name": "Eslam",
      "last_name": "Eslam Ahmed Kamel",
      "email": "eslam@gmail.com",
      "mobile": "+201020504470",
      "email_verified_at": null,
      "password": "$2y$12$/IbqQNf3XV87LoXSIyE7Je8snOW6BSiagK1fQJOMqjjf6dWhZZEx.",
      "profile": "1718485950.jpg",
      "passport": "1718485951.jpg",
      "passport_back": null,
      "level_id": 2,
      "remember_token": null,
      "active": "0",
      "block": "blocked",
      "created_at": "2024-06-16 00:12:32",
      "updated_at": "2024-06-16 00:13:06",
      "balance": null,
 */