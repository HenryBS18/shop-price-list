part of 'items_bloc.dart';

sealed class ItemsState {}

final class ItemsInitial extends ItemsState {}

final class ItemsLoading extends ItemsState {}

final class ItemsSuccess extends ItemsState {
  final List<Item> items;

  ItemsSuccess({required this.items});
}
