import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/api/end_points.dart';
import 'package:trading/core/const-strings/app_images.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/presentation/custom_image.dart';
import 'package:trading/core/presentation/custom_scaffold.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/notifications-news-certifications/domain/models/certification_model.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class CertificationDetailsScreen extends StatelessWidget {
  const CertificationDetailsScreen({super.key, required this.certificationModel});
  final CertificationModel certificationModel;
  @override
  Widget build(BuildContext context) {
    context.watch<PickLanguageAndThemeCubit>();
    return CustomScaffold(
      title: "LICENSE".tr(context),
      showBackArrow: true,
      child: ListView(
        children: [
          _getTitle(context: context, certificationModel: certificationModel),
          _getDescription(context: context, certificationModel: certificationModel),
          // Container(
          //   // padding: EdgeInsets.only(bottom: 10.w, left: 10.w, right: 10.w),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(20.w),
          //     color: Colors.red,
          //   ),
          //   clipBehavior: Clip.hardEdge,
          //   child: Image.network(
          //     EndPoint.uploadCertifications + (certificationModel.image ?? ''),
          //     errorBuilder: (context, error, stackTrace) {
          //       return Txt.bodyMeduim('Image Not Found');
          //     },
          //     // width: .w,
          //     height: 600.w,
          //     fit: BoxFit.cover,
          //   ),
          // )
          CustomRectangleImage(
            placeholderAssetPath: AppImages.splashScreen,
            networkImagePath: "${EndPoint.uploadCertifications}${certificationModel.image ?? ''}",
            height: 600.w,
          )
        ],
      ),
    );
  }

  Widget _getTitle({required BuildContext context, required CertificationModel certificationModel}) {
    final bool isEnglish = context.read<PickLanguageAndThemeCubit>().isEnglishLanguage();
    if (isEnglish) {
      if (certificationModel.nameEn == null || certificationModel.nameEn == "") {
        return const SizedBox();
      } else {
        return _title(certificationModel.nameEn!);
      }
    } else {
      if (certificationModel.nameAr == null || certificationModel.nameAr == "") {
        return const SizedBox();
      } else {
        return _title(certificationModel.nameAr!);
      }
    }
  }

  Widget _getDescription({required BuildContext context, required CertificationModel certificationModel}) {
    final bool isEnglish = context.read<PickLanguageAndThemeCubit>().isEnglishLanguage();
    if (isEnglish) {
      if (certificationModel.descriptionEn == null || certificationModel.descriptionEn == "") {
        return const SizedBox();
      } else {
        return _description(certificationModel.descriptionEn!);
      }
    } else {
      if (certificationModel.descriptionAr == null || certificationModel.descriptionAr == "") {
        return const SizedBox();
      } else {
        return _description(certificationModel.descriptionAr!);
      }
    }
  }

  Widget _title(String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.w),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Clr.f))),
      child: Txt.headlineMeduim(title),
    );
  }

  Widget _description(String description) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.w),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Clr.f))),
      child: Txt.bodyMeduim(description),
    );
  }
}
