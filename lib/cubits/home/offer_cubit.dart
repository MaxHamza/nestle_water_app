import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/offers.dart';

part 'offer_state.dart';

class OfferCubit extends Cubit<OfferState> {
  OfferCubit(this.dio) : super(OfferInitial());
final Dio dio;
  Future<void>fetchOffer()async {
    emit(OffersLoading());
    try {
      final response = await dio.get(
          'https://zamzaam.onrender.com/offers/?skip=0&limit=100');
      List<Offers>offer = (response.data as List)
          .map((e) => Offers.data(e))
          .toList();
      emit(OffersSuccess(offer));
    }
    catch(e){
      emit(OffersFailure(e.toString()));
    }
  }

}
