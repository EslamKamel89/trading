import 'package:trading/core/api/end_points.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PaymentModel {
  final int? id;
  final String? name;
  final String? code;
  final String? image;
  PaymentModel({
    this.id,
    this.name,
    this.code,
    this.image,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> map) {
    return PaymentModel(
      id: map[ApiKey.id],
      name: map[ApiKey.name],
      code: map[ApiKey.code],
      image: map[ApiKey.image],
    );
  }

  @override
  String toString() {
    return 'PaymentMethod(id: $id, name: $name, code: $code, image: $image)';
  }
}

/*
[
  {
    "id": 2,
    "name": "Vodafone",
    "code": "01008052485",
    "image": "1714928172.png",
    "created_at": "2024-05-05T16:56:12.000000Z",
    "updated_at": "2024-05-05T16:56:12.000000Z"
  },
  {
    "id": 3,
    "name": "Etisalat",
    "code": "01147240127",
    "image": "1714928223.png",
    "created_at": "2024-05-05T16:57:03.000000Z",
    "updated_at": "2024-05-05T16:57:03.000000Z"
  },
  {
    "id": 4,
    "name": "We",
    "code": "0502317562",
    "image": "1714928267.png",
    "created_at": "2024-05-05T16:57:47.000000Z",
    "updated_at": "2024-05-05T16:57:47.000000Z"
  }
]

 */