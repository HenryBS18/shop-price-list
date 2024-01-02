part of 'search_bloc.dart';

sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchValue extends SearchState {
  final String input;

  SearchValue({required this.input});
}
