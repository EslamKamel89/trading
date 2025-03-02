import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trading/core/const-strings/app_images.dart';
import 'package:trading/core/routing/app_routes_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 2))
        .then((value) => Navigator.of(context).pushNamedAndRemoveUntil(AppRoutesNames.signin, (route) => true));
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.splashScreen),
        ),
      ),
    );
  }
}
