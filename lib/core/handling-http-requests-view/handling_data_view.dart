import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:trading/core/crud/status_request.dart';
import 'package:trading/core/handling-http-requests-view/lottie_assets.dart';
import 'package:trading/core/text_styles/text_style.dart';

class HandlingDataView extends StatelessWidget {
  const HandlingDataView({
    super.key,
    required this.statusRequest,
    this.loadingWidget,
    this.serverFailureWidget,
    this.offlineFailureWidget,
    this.errorWiget,
    this.noDataWiget,
    this.noDataTxt,
    required this.child,
    this.height,
  });
  final StatusRequest statusRequest;
  final Widget? loadingWidget;
  final Widget? serverFailureWidget;
  final Widget? offlineFailureWidget;
  final Widget? errorWiget;
  final Widget? noDataWiget;
  final Widget child;
  final String? noDataTxt;
  final double? height;

  @override
  Widget build(BuildContext context) {
    if (statusRequest == StatusRequest.loading) {
      return loadingWidget ?? _displayInfo(AppLotties.loading, '');
    } else if (statusRequest == StatusRequest.offlineFailure) {
      return offlineFailureWidget ?? _displayInfo(AppLotties.offline, 'No Internet');
    } else if (statusRequest == StatusRequest.serverFailure) {
      return serverFailureWidget ?? _displayInfo(AppLotties.serverfailure, 'Server Failure');
    } else if (statusRequest == StatusRequest.error) {
      return errorWiget ?? _displayInfo(AppLotties.error, '');
    } else if (statusRequest == StatusRequest.noData) {
      return noDataWiget ?? _displayInfo(AppLotties.nodata, noDataTxt ?? '');
    }
    return child;
  }

  Widget _displayInfo(String lottiePath, String info) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LottieBuilder.asset(lottiePath, width: double.infinity, height: height ?? 500.h),
        const SizedBox(width: double.infinity),
        Txt.headlineMeduim(info),
      ],
    );
  }
}
