import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:nestle_waters_project/cubits/home/home_cubit.dart';
import 'package:nestle_waters_project/cubits/home/offer_cubit.dart';
import 'package:nestle_waters_project/presentation/home/pages/home_page.dart';
import 'package:nestle_waters_project/presentation/onboarding/pages/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../presentation/home/pages/main_list.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this.context) : super(SplashInitial());
  late VideoPlayerController controller;
 final BuildContext context;
  Future<void> initial() async {
    emit(SplashLoading());
    controller = VideoPlayerController.asset("assets/videos/splash.mp4");
    await controller.initialize(); // انتظر حتى اكتمال التهيئة
    controller.play();
    controller.setVolume(0);
    emit(SplashInitial());
    await Future.delayed(const Duration(seconds: 2));
    emit(SplashSuccess());
  }
  Future<void> checkLoginState(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingPage()),
      );
    }
  }

  @override
  Future<void> close() {
    controller.dispose();
    return super.close();
  }
}
