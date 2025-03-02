import 'package:trading/core/api/end_points.dart';

class WithdrawHistoryModel {
  final int? id;
  final double? amount;
  final int? userId;
  final String? imageOne;
  final String? accepted;
  final String? process;
  final String? refuseReason;
  final String? createdAt;
  final String? updatedAt;
  final String? firstName;
  final String? profileImage;
  final String? name;
  final String? imageTwo;
  WithdrawHistoryModel({
    required this.id,
    required this.amount,
    required this.userId,
    required this.imageOne,
    required this.accepted,
    required this.process,
    required this.refuseReason,
    required this.createdAt,
    required this.updatedAt,
    required this.firstName,
    required this.profileImage,
    required this.name,
    required this.imageTwo,
  });
  factory WithdrawHistoryModel.fromJson(Map<String, dynamic> json) {
    return WithdrawHistoryModel(
      id: json[ApiKey.paymentId],
      amount: (json[ApiKey.paymentAmount]).toDouble(),
      userId: json[ApiKey.paymentUserId],
      imageOne: json[ApiKey.paymentImageOne],
      accepted: json[ApiKey.paymentAccepted],
      process: json[ApiKey.withdrawPaymentProcess],
      refuseReason: json[ApiKey.paymentRefuseReason],
      createdAt: json[ApiKey.paymentCreatedAt],
      updatedAt: json[ApiKey.paymentUpdatedAt],
      firstName: json[ApiKey.paymentFirstName],
      profileImage: json[ApiKey.paymentProfileImage],
      name: json[ApiKey.paymentName],
      imageTwo: json[ApiKey.paymentImageTwo],
    );
  }
  @override
  String toString() {
    return 'WithdrawHistoryModel(id: $id, amount: $amount, userId: $userId, imageOne: $imageOne, accepted: $accepted, process: $process, refuseReason: $refuseReason, createdAt: $createdAt, updatedAt: $updatedAt, firstName: $firstName, profileImage: $profileImage, name: $name, imageTwo: $imageTwo)';
  }
}
