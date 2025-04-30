import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nestle_waters_project/core/constants/app_colors.dart';
import 'package:nestle_waters_project/presentation/onboarding/pages/onboarding_page.dart';
import 'package:nestle_waters_project/presentation/splash_pages/first_splash_screen.dart';
import 'package:video_player/video_player.dart';
import '../../cubits/splash_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    var controller = BlocProvider.of<SplashCubit>(context).controller;
    return BlocConsumer<SplashCubit, SplashState>(listener: (context, state) {
      if (state is SplashSuccess){
      BlocProvider.of<SplashCubit>(context).checkLoginState(context);
      }
    }, builder: (context, state) {
      if (state is SplashLoading) {
        return const  FirstSplashScreen();
      } else if (state is SplashInitial) {
        return Scaffold(
            body: Stack(
              children:[
                SizedBox.expand(
                        child: FittedBox(
              fit: BoxFit.fitHeight,
              child: SizedBox(
                width: controller.value.size.width,
                height: controller.value.size.height,
                child: VideoPlayer(controller),
              ),
                        ),
                      ),
                Container(
                  width: width,
                  padding: EdgeInsets.symmetric(vertical:height*0.08 ),
                  child: const Column(
                    children: [
                      Text(textAlign: TextAlign.center,'''PURE
HYDRATION''',style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),),
                      Text(textAlign: TextAlign.center,'''PURE CONVENIENCE''',style: TextStyle(
                          fontSize: 30,
                          color: Colors.red,
                          fontWeight: FontWeight.bold
                      ),),
                    ],
                  ),
                ),
            ]));
      } else {
        return Container();
      }
    });
  }
}
