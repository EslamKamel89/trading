import 'package:trading/core/api/end_points.dart';

class BannerModel {
  int id;
  String image;
  String link;
  BannerModel({
    required this.id,
    required this.image,
    required this.link,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      ApiKey.id: id,
      ApiKey.image: image,
      ApiKey.link: link,
    };
  }

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json[ApiKey.id] as int,
      image: json[ApiKey.image] as String,
      link: json[ApiKey.link] as String,
    );
  }
  @override
  String toString() => 'BannerModel(id: $id, image: $image, link: $link)';
}




/*
 {
  "0": {
    "id": 1,
    "image": "1716911586.jpg",
    "link": "خسشةش",
    "created_at": "2024-05-28 12:53:06",
    "updated_at": "2024-05-28 12:53:06"
  },
  "data": [
    {
      "id": 1,
      "image": "1716911586.jpg",
      "link": "خسشةش",
      "created_at": "2024-05-28 12:53:06",
      "updated_at": "2024-05-28 12:53:06"
    }
  ],
  "status": "success",
  "error": false,
  "messageAr": "",
  "messageEn": ""
}
 */