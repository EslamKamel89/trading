import 'package:trading/core/api/end_points.dart';

class CertificationModel {
  String? image;
  String? nameAr;
  String? nameEn;
  String? descriptionAr;
  String? descriptionEn;
  DateTime? createdAt;
  CertificationModel({
    this.image,
    this.nameAr,
    this.nameEn,
    this.descriptionAr,
    this.descriptionEn,
    this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      ApiKey.image: image,
      ApiKey.nameAr: nameAr,
      ApiKey.nameEn: nameEn,
      ApiKey.descriptionAr: descriptionAr,
      ApiKey.descriptionEn: descriptionEn,
      ApiKey.createdAt: createdAt,
    };
  }

  factory CertificationModel.fromJson(Map<String, dynamic> json) {
    return CertificationModel(
      image: json[ApiKey.image],
      nameAr: json[ApiKey.nameAr],
      nameEn: json[ApiKey.nameEn],
      descriptionAr: json[ApiKey.descriptionAr],
      descriptionEn: json[ApiKey.descriptionEn],
      createdAt: json[ApiKey.createdAt] == null ? null : DateTime.parse(json[ApiKey.createdAt]),
    );
  }

  @override
  String toString() {
    return 'CertifcationModel(image: $image, nameAr: $nameAr, nameEn: $nameEn, descriptionAr: $descriptionAr, descriptionEn: $descriptionEn, createdAt: $createdAt)';
  }
}





/*

{
  "data": [
    {
      "id": 1,
      "image": "1716913130.jpg",
      "name": "خسشةش",
      "description": null,
      "created_at": "2024-05-28 13:18:50",
      "updated_at": "2024-05-28 13:18:50"
    }
  ],
  "status": "success",
  "error": false,
  "messageAr": "",
  "messageEn": ""
}

 */