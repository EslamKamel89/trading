import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:trading/core/api/api_consumer.dart';
import 'package:trading/core/api/end_points.dart';
import 'package:trading/core/dependency-injection-container/injection_container.dart';
import 'package:trading/core/errors/error_model.dart';
import 'package:trading/core/extensions/extensions.dart';
import 'package:trading/features/auth/data/repo/auth_repo_implement.dart';
import 'package:trading/features/auth/domain/models/user_model.dart';

abstract class FirebaseHelper {
  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    const t = "firebaseMessagingBackgroundHandler - FirebaseHelper";
    message.messageId.prm(t);
  }

  static Future<void> requestPermisson(BuildContext context) async {
    const t = "requestPermisson - FirebaseHelper";
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      sound: true,
      announcement: false,
      provisional: false,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      'User granted Permisson'.prm(t);
    } else {
      "User didn't give the application permisson".prm(t);
    }
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        String title = message.notification!.title.prm('$t firebase messaging listener - notification title');
        String body = message.notification!.body.prm('$t firebase messaging listener - notification body');
        notificationSnackBar(context: context, title: title, body: body);
      },
    );
  }

  static Future<void> getToken() async {
    const t = 'getToken - FirebaseHelper';
    String? token = await FirebaseMessaging.instance.getToken();
    token.prm(t);
    await syncFcmToken(token: token ?? '');
  }

  static Future<void> syncFcmToken({required String token}) async {
    const t = 'syncFcmToken - FirebaseHelper';
    try {
      final ApiConsumer dio = sl<ApiConsumer>();
      final AuthRepo authRepo = sl<AuthRepo>();
      UserModel? userModel = await authRepo.getChacedUserData();
      if (userModel == null || userModel.id == null) {
        "can't send the fcm token to the backend because the cached user is null or the user id is null".prm(t);
        return;
      }
      final response = await dio.post(EndPoint.addFcmToken, data: {
        'user_id': userModel.id,
        'token': token,
      });
      final ErrorModel? errorModel;
      errorModel = ErrorModel.checkResponse(jsonDecode(response));
      if (errorModel != null) {
        "Error generated from the backend:${errorModel.errorMessageEn} ".prm(t);
        return;
      }
      "$response".prm(t);
      "Saving the token into the database completed successfully ".prm(t);
    } on Exception catch (e) {
      "Exception thrown :${e.toString()} ".prm(t);
    }
  }

  static Future<void> deleteFcmToken() async {
    const t = 'deleteFcmToken - FirebaseHelper';
    try {
      final ApiConsumer dio = sl<ApiConsumer>();
      final AuthRepo authRepo = sl<AuthRepo>();
      UserModel? userModel = await authRepo.getChacedUserData();
      if (userModel == null || userModel.id == null) {
        "can't delete the fcm token from the backend because the cached user is null or the user id is null".prm(t);
        return;
      }
      final response = await dio.delete(
        "${EndPoint.deleteFcmToken}${userModel.id}",
      );
      final ErrorModel? errorModel;
      errorModel = ErrorModel.checkResponse(jsonDecode(response));
      if (errorModel != null) {
        "Error generated from the backend:${errorModel.errorMessageEn} ".prm(t);
        return;
      }
      "$response".prm(t);
      "Deleting the token from the database completed successfully ".prm(t);
    } on Exception catch (e) {
      "Exception thrown :${e.toString()} ".prm(t);
    }
  }
}

notificationSnackBar({
  required BuildContext context,
  required String title,
  required String body,
}) {
  showTopSnackBar(
    Overlay.of(context),
    GestureDetector(
      // onTap: () {
      //   context.push(notificationEntity.path ?? '',
      //       extra: notificationEntity.payload);
      // },
      child: CustomSnackBar.error(
        message: "$title \n$body",
        maxLines: 3,
      ),
    ),
  );
}
