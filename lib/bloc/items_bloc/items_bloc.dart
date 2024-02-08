import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_price_list/db/database.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  ItemsBloc() : super(ItemsInitial()) {
    on<FetchItemsEvent>((event, emit) async {
      emit(ItemsLoading());

      final AppDb db = AppDb();
      final response = await db.getAllItemsRepo();

      emit(ItemsSuccess(items: response));
    });

    on<FetchItemsLikeEvent>((event, emit) async {
      final AppDb db = AppDb();
      final response = await db.getItemsLikeRepo(event.input);

      emit(ItemsSuccess(items: response));
    });
  }
}
