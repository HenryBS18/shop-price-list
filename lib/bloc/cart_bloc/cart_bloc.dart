import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, int> {
  CartBloc() : super(0) {
    on<IncrementTotalPriceEvent>((event, emit) {
      emit(state + event.increment);
    });

    on<DecrementTotalPriceEvent>((event, emit) {
      emit(state - event.decrement);
    });

    on<ResetTotalPriceEvent>((event, emit) {
      emit(0);
    });
  }
}
