import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/extensions/extensions.dart';
import 'package:trading/core/utils/snackbar.dart';
import 'package:trading/features/mainpage/presentation/widgets/section_background_border.dart';
import 'package:trading/features/notifications-news-certifications/presentation/blocs/news-cubit/news_cubit.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class NewsWiget extends StatelessWidget {
  const NewsWiget({
    super.key,
    this.showNews = true,
  });
  final bool showNews;
  @override
  Widget build(BuildContext context) {
    final themeCont = context.watch<PickLanguageAndThemeCubit>();
    final NewsCubit newsCubit = context.read<NewsCubit>();
    List<String> news = [];
    if (themeCont.isEnglishLanguage()) {
      news = newsCubit.newsArrayEn;
    } else {
      news = newsCubit.newsArrayAr;
    }
    // sl<NewsRepo>().getNews();
    if (!showNews) {
      return const SizedBox();
    }
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {
        if (state is NewsFailureState) {
          customSnackBar(context: context, title: state.errorMessage, isSuccess: false);
        }
      },
      builder: (context, state) {
        return SectionBackgroundAndBorder(
          // height: 40.h,
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: 16.sp,
              fontFamily: 'Agne',
            ),
            textAlign: TextAlign.center,
            child: AnimatedTextKit(
              // animatedTexts: [
              //   ...typeTextAnimation(
              //     themeCont.isEnglishLanguage() ? newsCubit.newsEn : newsCubit.newsAr,
              //     themeCont.isEnglishLanguage() ? 6 : 7,
              //   ),
              // ],
              animatedTexts: typeTextAnimationList(news, 15),
              onTap: () {},
              isRepeatingAnimation: true,
              repeatForever: true,
            ),
          ),
        );
      },
    );
  }
}

List<TypewriterAnimatedText> typeTextAnimationList(List<String> news, int wordNumber) {
  const t = "typeTextAnimatedList - NewsWidget";
  // news.prm(t);
  List<TypewriterAnimatedText> resultArray = [];
  for (String message in news) {
    List<String> wordsList = (message).split(" ");
    for (var i = 0; i < wordsList.length; i += wordNumber) {
      bool breakOut = false;
      if (i + wordNumber >= wordsList.length) {
        wordsList.addAll(List.generate(wordNumber, (index) => ""));
        breakOut = true;
      }
      resultArray.add(
        TypewriterAnimatedText(
          List.generate(wordNumber, (index) => wordsList[index + i]).join(" ").prm(t),
          speed: const Duration(milliseconds: 150),
        ),
      );
      if (breakOut) {
        break;
      }
    }
    // resultArray.prm("typeTextAnimatedList");
  }
  return resultArray;
}

List<TypewriterAnimatedText> typeTextAnimation(String message, int wordNumber) {
  List<String> wordsList = (message).split(" ");
  List<TypewriterAnimatedText> resultArray = [];
  for (var i = 0; i < wordsList.length; i += wordNumber) {
    bool breakOut = false;
    if (i + wordNumber >= wordsList.length) {
      wordsList.addAll(List.generate(wordNumber, (index) => ""));
      breakOut = true;
    }
    resultArray.add(
      TypewriterAnimatedText(
        List.generate(wordNumber, (index) => wordsList[index + i]).join(" "),
        speed: const Duration(milliseconds: 150),
      ),
    );
    if (breakOut) {
      break;
    }
  }
  return resultArray;
}
