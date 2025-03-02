import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/api/end_points.dart';
import 'package:trading/core/const-strings/app_images.dart';
import 'package:trading/core/presentation/custom_image.dart';
import 'package:trading/features/auth/domain/models/user_model.dart';

class UserProfilePhoto extends StatelessWidget {
  const UserProfilePhoto({
    super.key,
    required this.userModel,
  });
  final Future<UserModel?> userModel;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final double size = 200.w;
      return Material(
        shape: const CircleBorder(),
        elevation: 5,
        child: FutureBuilder(
            future: userModel,
            builder: (context, snapshot) {
              return SizedBox(
                width: size,
                height: size,
                child: CustomCircularImage(
                  placeholderAssetPath: AppImages.moneyMaker,
                  networkImagePath: '${EndPoint.uploadUser}${snapshot.data?.profile}',
                ),
              );
            }),
      );
    });
  }
}
