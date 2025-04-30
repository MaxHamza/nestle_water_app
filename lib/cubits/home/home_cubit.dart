import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nestle_waters_project/data/models/companies_model.dart';

import '../../data/models/offers.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.dio) : super(HomeInitial());
 final Dio dio;

  Future<void>fetchCompanyName ()async{
emit(CompanyLoading());
try {
  final response = await dio.get('https://zamzaam.onrender.com/companies/?skip=0&limit=100');
  List<CompanyModel> companies = (response.data as List)
      .map((e) => CompanyModel.data(e))
      .toList();
  emit(CompanySuccess(companies));
} catch (e) {
  emit(CompanyFailure(e.toString()));
}
  }

}
