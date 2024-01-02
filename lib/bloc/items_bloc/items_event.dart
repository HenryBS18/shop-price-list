part of 'items_bloc.dart';

sealed class ItemsEvent {}

class FetchItemsEvent extends ItemsEvent {}

class FetchItemsLikeEvent extends ItemsEvent {
  final String input;

  FetchItemsLikeEvent({required this.input});
}
