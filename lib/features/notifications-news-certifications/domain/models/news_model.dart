import 'package:trading/core/api/end_points.dart';

class NewsModel {
  String? nameAr;
  String? descriptionAr;
  String? descriptionEn;
  String? nameEn;
  String? image;
  String? type;
  NewsModel({
    this.nameAr,
    this.descriptionAr,
    this.descriptionEn,
    this.nameEn,
    this.image,
    this.type,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'nameAr': ApiKey.nameAr,
      'descriptionAr': ApiKey.descriptionAr,
      'descriptionEn': ApiKey.descriptionEn,
      'nameEn': ApiKey.nameEn,
      'image': ApiKey.image,
      'type': ApiKey.type,
    };
  }

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      nameAr: json[ApiKey.nameAr],
      descriptionAr: json[ApiKey.descriptionAr],
      descriptionEn: json[ApiKey.descriptionEn],
      nameEn: json[ApiKey.nameEn],
      image: json[ApiKey.image],
      type: json[ApiKey.type],
    );
  }

  @override
  String toString() {
    return 'NewsModel(nameAr: $nameAr, descriptionAr: $descriptionAr, descriptionEn: $descriptionEn, nameEn: $nameEn, image: $image, type: $type)';
  }
}








/*
{
  "data": [
    {
      "id": 1,
      "name_ar": "خسشةش",
      "description_ar": "ىخ بثشق خسشةش اثقث",
      "description_en": "",
      "name_en": "",
      "image": "1716022730.png",
      "type": "new",
      "created_at": "2024-05-18 05:58:50",
      "updated_at": "2024-05-18 06:13:34"
    }
  ],
  "status": "success",
  "error": false,
  "messageAr": "",
  "messageEn": ""
}
 */