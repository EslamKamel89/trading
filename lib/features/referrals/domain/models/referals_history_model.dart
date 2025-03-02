import 'package:trading/core/api/end_points.dart';

class ReferalHistoryModel {
  int? currentUserId;
  int? referalUserId;
  String? currentFirstName;
  String? currentLastName;
  String? referalFirstName;
  String? referalLastName;
  String? referalUserProfile;
  DateTime? createdAt;
  ReferalHistoryModel({
    this.currentUserId,
    this.referalUserId,
    this.currentFirstName,
    this.currentLastName,
    this.referalFirstName,
    this.referalLastName,
    this.referalUserProfile,
    this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      ApiKey.currentUserId: currentUserId,
      ApiKey.refferalUserId: referalUserId,
      ApiKey.currentFirstName: currentFirstName,
      ApiKey.currentLastName: currentLastName,
      ApiKey.refferalFirstName: referalFirstName,
      ApiKey.refferalLastName: referalLastName,
      ApiKey.refferalUserProfile: referalUserProfile,
      ApiKey.createdAt: createdAt?.toIso8601String(),
    };
  }

  factory ReferalHistoryModel.fromJson(Map<String, dynamic> json) {
    return ReferalHistoryModel(
      currentUserId: json[ApiKey.currentUserId],
      referalUserId: json[ApiKey.refferalUserId],
      currentFirstName: json[ApiKey.currentFirstName],
      currentLastName: json[ApiKey.currentLastName],
      referalFirstName: json[ApiKey.refferalFirstName],
      referalLastName: json[ApiKey.refferalLastName],
      referalUserProfile: json[ApiKey.refferalUserProfile],
      createdAt: DateTime.parse(json[ApiKey.createdAt]),
    );
  }

  @override
  String toString() {
    return 'RefferalHistoryModel(currentUserId: $currentUserId, refferalUserId: $referalUserId, currentFirstName: $currentFirstName, currentLastName: $currentLastName, refferalFirstName: $referalFirstName, refferalLastName: $referalLastName, refferalUserProfile: $referalUserProfile, createdAt: $createdAt)';
  }
}



/*
{
  "data": [
    {
      "id": 1,
      "main_user_id": 1,
      "user_id": 5,
      "created_at": "2024-05-12 13:31:26",
      "updated_at": "2024-05-12 13:31:26",
      "main_first_name": "Osama",
      "main_last_name": "Elmahdy",
      "user_first_name": "mohamed",
      "user_last_name": "-----",
      "user_profile": "1714492772.png"
    }
  ],
  "status": "success",
  "error": false,
  "messageAr": "",
  "messageEn": ""
}
 */