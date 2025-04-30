import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nestle_waters_project/data/data_source/app_images.dart';
part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial()){
    pageController=PageController();
  }
  late PageController pageController;
  int currentPage=0;
@override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
void  next(BuildContext context) {
    currentPage++;
      pageController.animateToPage(
          currentPage, duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut);

      //when this work it will make update directly
  }

  void onPageChanged(int index){
   currentPage=index;
   emit(OnboardingChanged(currentPage));
  }
  void  back(BuildContext context) {
    currentPage--;
    pageController.animateToPage(
        currentPage, duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut);

    //when this work it will make update directly
  }
}
