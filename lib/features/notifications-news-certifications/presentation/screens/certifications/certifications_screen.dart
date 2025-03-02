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
import 'package:trading/core/utils/snackbar.dart';
import 'package:trading/features/notifications-news-certifications/domain/models/certification_model.dart';
import 'package:trading/features/notifications-news-certifications/presentation/blocs/news-cubit/news_cubit.dart';
import 'package:trading/features/notifications-news-certifications/presentation/screens/certifications/certifications_details_screen.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class CertificationsScreen extends StatefulWidget {
  const CertificationsScreen({super.key});

  @override
  State<CertificationsScreen> createState() => _CertificationsScreenState();
}

class _CertificationsScreenState extends State<CertificationsScreen> {
  late final NewsCubit newsCubit;
  @override
  void initState() {
    newsCubit = context.read<NewsCubit>()..getCertifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // sl<NewsRepo>().getCertifications();
    return CustomScaffold(
      showBackArrow: true,
      title: "LICENSE".tr(context),
      child: BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {
          if (state is CertificationsFailureState) {
            customSnackBar(context: context, title: state.errorMessage, isSuccess: false);
          }
        },
        builder: (context, state) {
          if (state is CertificationsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (newsCubit.certifications.isEmpty) {
            return Center(child: Txt.bodyMeduim("There are no certifications to display"));
          }
          return GridView.builder(
            itemCount: newsCubit.certifications.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.w,
              mainAxisSpacing: 8.w,
            ),
            itemBuilder: (context, index) {
              CertificationModel certificationModel = newsCubit.certifications[index];
              // certificationModel.nameEn = "hello";
              // certificationModel.nameAr = "مرحبا";
              // certificationModel.descriptionEn = AppStrings.loremEn;
              // certificationModel.descriptionAr = AppStrings.loremAr;
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CertificationDetailsScreen(certificationModel: certificationModel),
                    ),
                  );
                },
                child: CertificationDisplayWidget(certificationModel: certificationModel),
              );
            },
          );
        },
      ),
    );
  }
}

class CertificationDisplayWidget extends StatelessWidget {
  const CertificationDisplayWidget({
    super.key,
    required this.certificationModel,
  });

  final CertificationModel certificationModel;

  @override
  Widget build(BuildContext context) {
    final languageController = context.read<PickLanguageAndThemeCubit>();
    return Material(
      // shape: const CircleBorder(),
      elevation: 5,
      borderRadius: BorderRadius.circular(20.w),
      color: Clr.d,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            // child: Container(
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
            //     width: 200.w,
            //     height: 200.w,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            child: CustomRectangleImage(
              placeholderAssetPath: AppImages.moneyMaker,
              networkImagePath: "${EndPoint.uploadCertifications}${certificationModel.image ?? ''}",
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Txt.bodyMeduim(certificationModel.nameEn ?? 'Unknown', textAlign: TextAlign.center, color: Colors.white),
          _displayTitle(context: context, certificationModel: certificationModel),
        ],
      ),
    );
  }

  Widget _displayTitle({
    required BuildContext context,
    required CertificationModel certificationModel,
  }) {
    final String? nameAr = certificationModel.nameAr;
    final String? nameEn = certificationModel.nameEn;
    final bool isEnglish = context.read<PickLanguageAndThemeCubit>().isEnglishLanguage();
    if (isEnglish) {
      if (nameEn == null || nameEn == "") {
        return const SizedBox();
      } else {
        return Txt.bodyMeduim(certificationModel.nameEn!, textAlign: TextAlign.center, color: Colors.white);
      }
    } else {
      if (nameAr == null || nameAr == "") {
        return const SizedBox();
      } else {
        return Txt.bodyMeduim(certificationModel.nameAr!, textAlign: TextAlign.center, color: Colors.white);
      }
    }
  }
}
