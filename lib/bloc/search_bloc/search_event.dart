part of 'search_bloc.dart';

sealed class SearchEvent {}

class SearchChangeEvent extends SearchEvent {
  final String input;

  SearchChangeEvent({required this.input});
}
