import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/auth/presentation/blocs/signup-cubit/signup_cubit.dart';
import 'package:trading/features/auth/presentation/screens/signup/widgets/upload_image_button.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class PickImageWidget extends StatelessWidget {
  const PickImageWidget({
    super.key,
    required this.scaffoldKey,
  });
  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  Widget build(BuildContext context) {
    SignupCubit controller = context.read<SignupCubit>();
    context.watch<PickLanguageAndThemeCubit>();
    return SizedBox(
      width: 130,
      height: 130,
      child: BlocBuilder<SignupCubit, SignupState>(
        buildWhen: (previous, current) {
          return current is UpdateUserImageState ? true : false;
        },
        builder: (context, state) {
          return CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            backgroundImage: controller.uploadImageFile == null
                ? const AssetImage("assets/images/avatar.png")
                : FileImage(controller.uploadImageFile!) as ImageProvider<Object>,
            child: Stack(
              children: [
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: () {
                      scaffoldKey.currentState!.showBottomSheet(
                        (context) => Container(
                          width: double.infinity,
                          height: 200.h,
                          decoration: const BoxDecoration(
                            color: Color(0x00000eee),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(Icons.close),
                                ),
                              ),
                              Center(
                                child: Text("UPLOAD_METHOD_PHOTO".tr(context)),
                              ),
                              SizedBox(height: 5.h),
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    _pickImageFromGallery(controller);
                                    Navigator.of(context).maybePop();
                                  },
                                  child: UploadImageButton(
                                    buttonTitle: "GALLERY".tr(context),
                                    width: 200.w,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    _pickImageFromCamera(controller);
                                    Navigator.of(context).maybePop();
                                  },
                                  child: UploadImageButton(
                                    buttonTitle: "CAMERA".tr(context),
                                    width: 200.w,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Clr.d,
                        border: Border.all(color: Theme.of(context).dividerColor, width: 3),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Icon(
                        Icons.camera_alt_sharp,
                        color: Clr.c,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future _pickImageFromGallery(SignupCubit controller) async {
    controller.uploadImageXFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (controller.uploadImageXFile == null) {
      return;
    }
    controller.uploadImageFile = File(controller.uploadImageXFile!.path);
    controller.updateUserImage();
  }

  Future _pickImageFromCamera(SignupCubit controller) async {
    controller.uploadImageXFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (controller.uploadImageXFile == null) {
      return;
    }
    controller.uploadImageFile = File(controller.uploadImageXFile!.path);
    controller.updateUserImage();
  }
}
