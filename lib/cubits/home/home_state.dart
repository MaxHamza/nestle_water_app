part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class CompanyLoading extends HomeState {}
final class CompanyFailure extends HomeState {
  final String message;
  CompanyFailure(this.message);
}
final class CompanySuccess extends HomeState {
  final List<CompanyModel> companies;
  CompanySuccess(this.companies);
}

