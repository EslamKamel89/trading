import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/features/auth/presentation/screens/signup/widgets/upload_image_button.dart';
import 'package:trading/features/referrals/presentation/blocs/add_refferals_cubit/add_referrals_cubit.dart';
import 'package:trading/features/referrals/presentation/screens/add-referrals/widgets/choose_upload_document_type_referrals.dart';

class UploadPassportPhotoReferrals extends StatelessWidget {
  const UploadPassportPhotoReferrals({
    super.key,
    required this.scaffoldKey,
    required this.controller,
  });
  final GlobalKey<ScaffoldState> scaffoldKey;
  final AddReferralsCubit controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Txt.displayMeduim("UPLOAD_PASSPORT_PHOTO".tr(context)),
        SizedBox(width: 5.w),
        InkWell(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            scaffoldKey.currentState!.showBottomSheet(
              (context) {
                return _pickImageFromGalleryOrCamera(
                  context,
                  controller: controller,
                );
              },
            );
          },
          child: UploadImageButton(buttonTitle: "UPLOAD_DOCUMENT".tr(context)),
        ),
      ],
    );
  }

  Container _pickImageFromGalleryOrCamera(
    BuildContext context, {
    required AddReferralsCubit controller,
  }) {
    return Container(
      width: double.infinity,
      height: 430.h,
      decoration: const BoxDecoration(
        color: Color(0x00000eee),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Align(
          //   alignment: Alignment.topRight,
          //   child: IconButton(
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //     icon: const Icon(Icons.close),
          //   ),
          // ),
          SizedBox(height: 30.h),
          Center(
            child: Txt.headlineMeduim(
              "CHOOSE_PASSPORT_PERSONAL_ID".tr(context),
              textAlign: TextAlign.center,
              showFullText: true,
            ),
          ),
          SizedBox(height: 5.h),
          const ChooseUploadDocumentTypeReferrals(),
          SizedBox(height: 20.h),
          Center(
            child: Txt.headlineMeduim(
              "CHOOSE_GALLERY_CAMERA".tr(context),
              showFullText: true,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 5.h),
          Center(
            child: InkWell(
              onTap: () async {
                await _pickImageFromGallery(
                  context,
                  controller: controller,
                  uploadDocOne: true,
                );
                if (!controller.isUploadPassport) {
                  // if (true) {
                  await _pickImageFromGallery(
                    context,
                    controller: controller,
                    uploadDocTwo: true,
                  );
                }
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
            child: BlocBuilder<AddReferralsCubit, AddReferralsState>(
              builder: (context, state) {
                return InkWell(
                  onTap: () async {
                    await _pickImageFromCamera(
                      context,
                      controller: controller,
                      uploadDocOne: true,
                    );
                    if (!controller.isUploadPassport) {
                      // if (true) {
                      await _pickImageFromCamera(
                        context,
                        controller: controller,
                        uploadDocTwo: true,
                      );
                    }
                    Navigator.of(context).maybePop();
                  },
                  child: UploadImageButton(
                    buttonTitle: "CAMERA".tr(context),
                    width: 200.w,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future _pickImageFromGallery(
    BuildContext context, {
    required AddReferralsCubit controller,
    bool? uploadDocOne,
    bool? uploadDocTwo,
  }) async {
    if (uploadDocOne == true) {
      controller.uploadIdDoucmentXFileOne = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (controller.uploadIdDoucmentXFileOne == null) {
        return;
      }
      controller.uploadIdDocumentFileOne = File(controller.uploadIdDoucmentXFileOne!.path);
      controller.updateDocumentImage();
    } else if (uploadDocTwo == true) {
      controller.uploadIdDoucmentXFileTwo = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (controller.uploadIdDoucmentXFileTwo == null) {
        return;
      }
      controller.uploadIdDocumentFileTwo = File(controller.uploadIdDoucmentXFileTwo!.path);
      controller.updateDocumentImage();
    }
  }

  Future _pickImageFromCamera(
    BuildContext context, {
    required AddReferralsCubit controller,
    bool? uploadDocOne,
    bool? uploadDocTwo,
  }) async {
    if (uploadDocOne == true) {
      controller.uploadIdDoucmentXFileOne = await ImagePicker().pickImage(source: ImageSource.camera);
      if (controller.uploadIdDoucmentXFileOne == null) {
        return;
      }
      controller.uploadIdDocumentFileOne = File(controller.uploadIdDoucmentXFileOne!.path);
      controller.updateDocumentImage();
    } else if (uploadDocTwo == true) {
      controller.uploadIdDoucmentXFileTwo = await ImagePicker().pickImage(source: ImageSource.camera);
      if (controller.uploadIdDoucmentXFileTwo == null) {
        return;
      }
      controller.uploadIdDocumentFileTwo = File(controller.uploadIdDoucmentXFileTwo!.path);
      controller.updateDocumentImage();
    }
  }
}
