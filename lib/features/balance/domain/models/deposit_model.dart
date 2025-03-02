// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:trading/core/api/end_points.dart';

class DepositModel {
  final String paymentId;
  final String userId;
  final String transactionNumber; // transaction number the user entered
  final double amount;
  final String image;
  final String createdAt;
  DepositModel({
    required this.paymentId,
    required this.userId,
    required this.transactionNumber,
    required this.amount,
    required this.image,
    required this.createdAt,
  });
  factory DepositModel.fromJson(Map<String, dynamic> json) {
    return DepositModel(
      paymentId: json[ApiKey.paymentId],
      userId: json[ApiKey.userId],
      transactionNumber: json[ApiKey.transactionNumber],
      amount: json[ApiKey.amount],
      image: json[ApiKey.image],
      createdAt: json[ApiKey.createdAt],
    );
  }

  @override
  String toString() {
    return 'DepositModel(paymentId: $paymentId, userId: $userId, transactionNumber: $transactionNumber, amount: $amount, image: $image, createdAt: $createdAt)';
  }
}

/**
 * success 
{
  "data": 30,
  "status": "success",
  "error": false,
  "messageAr": "عملية الإيداع تحت التنفيذ",
  "messageEn": "The deposit has been in progress"
}
* failure 
statusCode = 500 
 */
