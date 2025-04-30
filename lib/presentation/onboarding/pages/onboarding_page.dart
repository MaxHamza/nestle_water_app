import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nestle_waters_project/core/constants/app_colors.dart';
import 'package:nestle_waters_project/cubits/authintication_cubits/sign_in_cubit.dart';
import 'package:nestle_waters_project/data/data_source/app_images.dart';
import 'package:nestle_waters_project/data/data_source/app_text.dart';
import 'package:nestle_waters_project/presentation/authintication/pages/sign_in.dart';
import 'package:nestle_waters_project/presentation/onboarding/widgets/onboarding_list.dart';
import '../../../cubits/onboarding_cubit.dart';
import '../../home/pages/choose_location.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    List myImages = AppImages.onBoardingImages;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocProvider<OnboardingCubit>(
      create: (context) => OnboardingCubit(),
      child: Builder(
        // 👈 هنا نستخدم Builder لتوفير context جديد داخل BlocProvider
        builder: (newContext) {
          return Scaffold(
            backgroundColor: const Color(0xFF0036AB),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.53, 0.47],
                  colors: [
                    const Color(0xffF8FAFC),
                    primaryColor,
                  ],
                ),
              ),
              width: width,
              height: height,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: height * 0.06),
                    width: width,
                    height: height * 0.87,
                    child: PageView.builder(
                      onPageChanged: (index) {
                        // 👇 نستخدم newContext اللي داخل BlocProvider
                        newContext.read<OnboardingCubit>().onPageChanged(index);
                      },
                      controller: BlocProvider.of<OnboardingCubit>(newContext)
                          .pageController,
                      itemCount: myImages.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Image.asset(
                              'assets/images/logo.png',
                              width: width * 0.25,
                            ),
                            SizedBox(height: height * 0.02),
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              child: Image.asset(
                                myImages[index],
                                width: width * 0.7,
                                fit: BoxFit.cover,
                                height: height * 0.45,
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Text(
                              AppText.onBoardingTitle[index],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: height * 0.01),
                            Text(
                              AppText.onBoardingBody[index],
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  BlocBuilder<OnboardingCubit, OnboardingState>(
                    builder: (context, state) {
                      int currentPage =
                          BlocProvider.of<OnboardingCubit>(context).currentPage;
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              currentPage == 0
                                  ? IconButton(
                                      onPressed: null,
                                      icon: Icon(
                                        Icons.arrow_back_ios_new,
                                        color: Colors.white.withOpacity(0.5),
                                      ))
                                  : IconButton(
                                      onPressed: () {
                                        BlocProvider.of<OnboardingCubit>(
                                                context)
                                            .back(context);
                                      },
                                      icon:
                                          const Icon(Icons.arrow_back_ios_new),
                                      color: Colors.white,
                                    ),
                              const Spacer(),
                              const OnBoardingList(),
                              const Spacer(),
                              currentPage == myImages.length - 1
                                  ? IconButton(
                                      onPressed: null,
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white.withOpacity(0.5),
                                      ))
                                  : IconButton(
                                      onPressed: () {
                                        context
                                            .read<OnboardingCubit>()
                                            .next(newContext);
                                      },
                                      icon: const Icon(Icons.arrow_forward_ios),
                                      color: Colors.white),
                            ],
                          ),
                          currentPage != myImages.length - 1
                              ? TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return SignIn();
                                    }));
                                  },
                                  child: const Text(
                                    'تخطي المقدمة',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.white,
                                      decorationThickness: 2,
                                      color: Colors.white,
                                    ),
                                  ))
                              : MaterialButton(
                                  minWidth: width * 0.6,
                                  color: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  onPressed: () {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return SignIn();
                                    }));
                                  },
                                  child: Text(
                                    'البدء',
                                    style: TextStyle(color: primaryColor),
                                  ),
                                )
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
