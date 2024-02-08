part of 'cart_bloc.dart';

sealed class CartEvent {}

class ResetTotalPriceEvent extends CartEvent {}

class IncrementTotalPriceEvent extends CartEvent {
  final int increment;

  IncrementTotalPriceEvent({required this.increment});
}

class DecrementTotalPriceEvent extends CartEvent {
  final int decrement;

  DecrementTotalPriceEvent({required this.decrement});
}
