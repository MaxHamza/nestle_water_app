import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nestle_waters_project/data/data_source/app_images.dart';
import '../../../cubits/onboarding_cubit.dart';
class OnBoardingList extends StatelessWidget {
  const OnBoardingList({super.key});
  @override
  Widget build(BuildContext context) {
    final currentPage = context.watch<OnboardingCubit>().currentPage;
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(AppImages.onBoardingImages.length, (index) {
            return AnimatedContainer(
                margin:const EdgeInsets.only(right: 10),
                duration:const Duration(milliseconds: 100),// i use animatedController for duration
                child: Container(
                  height:currentPage==index? 13:11,
                  width: currentPage==index?13:11,
                  decoration:const BoxDecoration(
                    color:  Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ));}
          )] );
  }
}
