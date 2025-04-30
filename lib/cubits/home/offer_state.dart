part of 'offer_cubit.dart';

sealed class OfferState {}

final class OfferInitial extends OfferState {}
final class OffersLoading extends OfferState {}
final class OffersFailure extends OfferState {
  final String message;
  OffersFailure(this.message);
}
final class OffersSuccess extends OfferState {
  final List<Offers>offer;
  OffersSuccess(this.offer);
}