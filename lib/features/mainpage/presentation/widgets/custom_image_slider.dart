import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/api/end_points.dart';
import 'package:trading/core/const-strings/app_images.dart';
import 'package:trading/core/utils/snackbar.dart';
import 'package:trading/features/mainpage/domain/models/banner_model.dart';
import 'package:trading/features/mainpage/presentation/blocs/mainpage_cubit/mainpage_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomImageSlider extends StatefulWidget {
  const CustomImageSlider({
    super.key,
  });

  @override
  State<CustomImageSlider> createState() => _CustomImageSliderState();
}

class _CustomImageSliderState extends State<CustomImageSlider> {
  final List<String> bannerImages = [
    AppImages.banner1,
    AppImages.banner2,
    AppImages.banner3,
  ];
  int currentIndex = 0;
  late final MainpageCubit controller;

  @override
  void initState() {
    controller = context.read<MainpageCubit>();

    controller.getAdvertise();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainpageCubit, MainpageState>(
      buildWhen: (previous, current) {
        if (current is MainpageSuccessState) {
          return false;
        }
        return true;
      },
      builder: (context, state) {
        List<Widget> imageList;
        if (state is AdvertiseSuccessState) {
          imageList = state.banners.map((BannerModel banner) {
            return LayoutBuilder(builder: (context, constrains) {
              return InkWell(
                onLongPress: () async {
                  // final Uri url = Uri.parse('https://flutter.dev');
                  final Uri url = Uri.parse(banner.link);
                  try {
                    await launchUrl(url);
                  } on Exception catch (e) {
                    customSnackBar(context: context, title: "Couldn't connect With the Url: $e", isSuccess: false);
                  }
                },
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(20.w),
                  // shadowColor: Clr.d,
                  child: Container(
                    height: 150.h,
                    width: constrains.maxWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.w),
                      image: DecorationImage(
                          image: NetworkImage("${EndPoint.advertiseBanners}${banner.image}"), fit: BoxFit.cover),
                    ),
                  ),
                ),
              );
            });
          }).toList();
        } else {
          imageList = bannerImages
              .map(
                (path) => LayoutBuilder(builder: (context, constrains) {
                  return Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20.w),
                    // shadowColor: Clr.d,
                    child: Container(
                      height: 150.h,
                      width: constrains.maxWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.w),
                        image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
                      ),
                    ),
                  );
                }),
              )
              .toList();
        }
        return Expanded(
          flex: 1,
          child: SizedBox(
            child: CarouselSlider(
              items: imageList,
              options: CarouselOptions(
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayInterval: const Duration(seconds: 10),
                enlargeCenterPage: true,
                aspectRatio: 2,
                pauseAutoPlayOnTouch: true,
                enlargeFactor: 10,
                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                height: 150.h,
                onPageChanged: (index, reason) {
                  currentIndex = index;
                  setState(() {});
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
