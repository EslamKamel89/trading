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
import 'package:trading/features/notifications-news-certifications/domain/models/news_model.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class BLogNewsDetailsSreen extends StatelessWidget {
  const BLogNewsDetailsSreen({super.key, required this.newsModel});
  final NewsModel newsModel;
  @override
  Widget build(BuildContext context) {
    context.watch<PickLanguageAndThemeCubit>();
    return CustomScaffold(
      title: "NOTIFICATIONS_NEWS".tr(context),
      showBackArrow: true,
      child: ListView(
        children: [
          _getTitle(context: context, newsModel: newsModel),
          _getDescription(context: context, newsModel: newsModel),
          // Container(
          //   // padding: EdgeInsets.only(bottom: 10.w, left: 10.w, right: 10.w),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(20.w),
          //     color: Colors.red,
          //   ),
          //   clipBehavior: Clip.hardEdge,
          //   child: Image.network(
          //     EndPoint.uploadBlogNews + (newsModel.image ?? ''),
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
            networkImagePath: EndPoint.uploadBlogNews + (newsModel.image ?? ''),
            height: 600.w,
          )
        ],
      ),
    );
  }

  Widget _getTitle({required BuildContext context, required NewsModel newsModel}) {
    final bool isEnglish = context.read<PickLanguageAndThemeCubit>().isEnglishLanguage();
    if (isEnglish) {
      if (newsModel.nameEn == null || newsModel.nameEn == "") {
        return const SizedBox();
      } else {
        return _title(newsModel.nameEn!);
      }
    } else {
      if (newsModel.nameAr == null || newsModel.nameAr == "") {
        return const SizedBox();
      } else {
        return _title(newsModel.nameAr!);
      }
    }
  }

  Widget _getDescription({required BuildContext context, required NewsModel newsModel}) {
    final bool isEnglish = context.read<PickLanguageAndThemeCubit>().isEnglishLanguage();
    if (isEnglish) {
      if (newsModel.descriptionEn == null || newsModel.descriptionEn == "") {
        return const SizedBox();
      } else {
        return _description(newsModel.descriptionEn!);
      }
    } else {
      if (newsModel.descriptionAr == null || newsModel.descriptionAr == "") {
        return const SizedBox();
      } else {
        return _description(newsModel.descriptionAr!);
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
