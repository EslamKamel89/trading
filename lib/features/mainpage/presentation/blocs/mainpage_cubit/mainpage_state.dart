part of 'mainpage_cubit.dart';

sealed class MainpageState {}

final class MainpageInitial extends MainpageState {}

class AdvertiseSuccessState extends MainpageState {
  List<BannerModel> banners;
  AdvertiseSuccessState({required this.banners});
}

class MainpageLoadingState extends MainpageState {}

class MainpageFailureState extends MainpageState {
  final String errorMessage;
  MainpageFailureState({required this.errorMessage});
}

class MainpageSuccessState extends MainpageState {
  final UserModel userModel;
  MainpageSuccessState({required this.userModel});
}
