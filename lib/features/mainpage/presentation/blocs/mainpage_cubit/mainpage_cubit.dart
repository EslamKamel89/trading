import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trading/core/const-strings/app_strings.dart';
import 'package:trading/core/dependency-injection-container/injection_container.dart';
import 'package:trading/core/extensions/extensions.dart';
import 'package:trading/features/auth/data/repo/auth_repo_implement.dart';
import 'package:trading/features/auth/domain/models/user_model.dart';
import 'package:trading/features/mainpage/domain/models/banner_model.dart';
import 'package:trading/features/mainpage/domain/repo_interface/advetise_repo_interface.dart';

part 'mainpage_state.dart';

class MainpageCubit extends Cubit<MainpageState> {
  AdvertiseRepoInterface advertiseRepo;
  // AuthRepo authRepo;
  UserModel? userModel;
  MainpageCubit({required this.advertiseRepo}) : super(MainpageInitial());

  Future<List<BannerModel>?> getAdvertise() async {
    if (isClosed) {
      return null;
    }
    emit(MainpageLoadingState());
    final response = await advertiseRepo.getAdvertise();
    if (isClosed) {
      return null;
    }
    return response.fold(
      (errorModel) {
        emit(MainpageFailureState(errorMessage: errorModel.errorMessageEn ?? "Advertise banners not found"));
        return null;
      },
      (banners) async {
        emit(AdvertiseSuccessState(banners: banners));
        return banners;
      },
    );
  }

  Future<UserModel?> getUserData() async {
    if (isClosed) {
      return null;
    }
    emit(MainpageLoadingState());
    final AuthRepo authRepo = sl<AuthRepo>();
    userModel = await authRepo.getChacedUserData();
    if (userModel == null) {
      return null;
    }
    final int userId = (userModel?.id)!;
    final response = await authRepo.getUserData(userId: userId);
    return response.fold(
      (errorModel) {
        emit(MainpageFailureState(errorMessage: errorModel.errorMessageEn ?? "Error ocurred when fetching user data"));
        return null;
      },
      (user) async {
        await authRepo.cacheUserData(user);
        userModel = (await authRepo.getChacedUserData())!;
        userModel?.prm('User Data in MainpageCubit');
        if (!isClosed) {
          emit(MainpageSuccessState(userModel: userModel!));
        }
        return userModel;
      },
    );
  }

  void refreshUserData() {
    sl<AuthRepo>().getUserData(userId: sl<SharedPreferences>().getInt(AppStrings.USER_ID) ?? -1);
  }
}
