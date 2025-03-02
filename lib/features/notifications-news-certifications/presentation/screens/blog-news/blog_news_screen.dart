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
import 'package:trading/features/notifications-news-certifications/domain/models/news_model.dart';
import 'package:trading/features/notifications-news-certifications/presentation/blocs/news-cubit/news_cubit.dart';
import 'package:trading/features/notifications-news-certifications/presentation/screens/blog-news/blog_news_details_screen.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class BlogNewsScreen extends StatefulWidget {
  const BlogNewsScreen({super.key});

  @override
  State<BlogNewsScreen> createState() => _BlogNewsScreenState();
}

class _BlogNewsScreenState extends State<BlogNewsScreen> {
  late final NewsCubit newsCubit;
  @override
  void initState() {
    newsCubit = context.read<NewsCubit>()..getBlogNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showBackArrow: true,
      title: "NOTIFICATIONS_NEWS".tr(context),
      child: BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {
          if (state is NewsBlogFailureState) {
            customSnackBar(context: context, title: state.errorMessage, isSuccess: false);
          }
        },
        builder: (context, state) {
          if (state is NewsBlogLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (newsCubit.blogNews.isEmpty) {
            return Center(child: Txt.bodyMeduim("There are no news to display"));
          }
          return GridView.builder(
            itemCount: newsCubit.blogNews.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.w,
              mainAxisSpacing: 8.w,
            ),
            itemBuilder: (context, index) {
              NewsModel newsModel = newsCubit.blogNews[index];
              // newsModel.nameEn = "hello";
              // newsModel.nameAr = "مرحبا";
              // newsModel.descriptionEn = AppStrings.loremEn;
              // newsModel.descriptionAr = AppStrings.loremAr;
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BLogNewsDetailsSreen(newsModel: newsModel),
                    ),
                  );
                },
                child: BlogNewsDisplayWidget(newsModel: newsModel),
              );
            },
          );
        },
      ),
    );
  }
}

class BlogNewsDisplayWidget extends StatelessWidget {
  const BlogNewsDisplayWidget({
    super.key,
    required this.newsModel,
  });

  final NewsModel newsModel;

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
            //     EndPoint.uploadBlogNews + (newsModel.image ?? ''),
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
              networkImagePath: EndPoint.uploadBlogNews + (newsModel.image ?? ''),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Txt.bodyMeduim(certificationModel.nameEn ?? 'Unknown', textAlign: TextAlign.center, color: Colors.white),
          _displayTitle(context: context, newsModel: newsModel),
        ],
      ),
    );
  }

  Widget _displayTitle({
    required BuildContext context,
    required NewsModel newsModel,
  }) {
    final String? nameAr = newsModel.nameAr;
    final String? nameEn = newsModel.nameEn;
    final bool isEnglish = context.read<PickLanguageAndThemeCubit>().isEnglishLanguage();
    if (isEnglish) {
      if (nameEn == null || nameEn == "") {
        return const SizedBox();
      } else {
        return Txt.bodyMeduim(newsModel.nameEn!, textAlign: TextAlign.center, color: Colors.white);
      }
    } else {
      if (nameAr == null || nameAr == "") {
        return const SizedBox();
      } else {
        return Txt.bodyMeduim(newsModel.nameAr!, textAlign: TextAlign.center, color: Colors.white);
      }
    }
  }
}
