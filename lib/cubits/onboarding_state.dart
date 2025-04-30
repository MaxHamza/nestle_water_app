part of 'onboarding_cubit.dart';

sealed class OnboardingState {}

final class OnboardingInitial extends OnboardingState {}
final class OnboardingChanged extends OnboardingState {
  final int currentPage;
  OnboardingChanged(this.currentPage);
}