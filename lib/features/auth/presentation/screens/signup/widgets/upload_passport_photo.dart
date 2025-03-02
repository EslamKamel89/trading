// ignore_for_file: unused_element

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/features/auth/presentation/blocs/signup-cubit/signup_cubit.dart';
import 'package:trading/features/auth/presentation/screens/signup/widgets/upload_image_button.dart';

class UploadPassportPhoto extends StatelessWidget {
  const UploadPassportPhoto({
    super.key,
    required this.scaffoldKey,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  Widget build(BuildContext context) {
    SignupCubit controller = context.read<SignupCubit>();
    return Row(
      children: [
        Txt.displayMeduim("UPLOAD_PASSPORT_PHOTO".tr(context)),
        SizedBox(width: 5.w),
        InkWell(
          onTap: () {
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
    required SignupCubit controller,
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
            child: Txt.headlineMeduim(
              "CHOOSE_PASSPORT_PERSONAL_ID".tr(context),
              textAlign: TextAlign.center,
              showFullText: true,
            ),
          ),
          SizedBox(height: 5.h),
          const ChooseUploadDocumentType(),
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
            child: InkWell(
              onTap: () async {
                await _pickImageFromCamera(
                  context,
                  controller: controller,
                  uploadDocOne: true,
                );
                if (!controller.isUploadPassport) {
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
            ),
          ),
        ],
      ),
    );
  }

  Future _pickImageFromGallery(
    BuildContext context, {
    required SignupCubit controller,
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
    required SignupCubit controller,
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

class ChooseUploadDocumentType extends StatefulWidget {
  const ChooseUploadDocumentType({super.key});

  @override
  State<ChooseUploadDocumentType> createState() => _ChooseUploadDocumentTypeState();
}

class _ChooseUploadDocumentTypeState extends State<ChooseUploadDocumentType> {
  @override
  Widget build(BuildContext context) {
    SignupCubit controller = context.read<SignupCubit>();
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Txt.displayMeduim("PERSONAL_ID".tr(context)),
              SizedBox(width: 5.w),
              Switch(
                value: controller.isUploadPassport,
                onChanged: (value) {
                  controller.isUploadPassport = value;
                  setState(() {});
                },
                activeColor: const Color(0xFFE9C874),
                inactiveThumbColor: const Color(0xFFE9C874),
                inactiveTrackColor: const Color(0xFFA34343),
              ),
              SizedBox(width: 5.w),
              Txt.displayMeduim("PASSPORT".tr(context)),
            ],
          ),
          controller.isUploadPassport
              ? Txt.displayMeduim(
                  "UPLOAD_ONE_PHOTO".tr(context),
                  textAlign: TextAlign.center,
                )
              : Txt.bodyMeduim(
                  "UPLOAD_TWO_PHOTO".tr(context),
                  textAlign: TextAlign.center,
                )
        ],
      ),
    );
  }
}
