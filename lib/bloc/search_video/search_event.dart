part of 'search_bloc.dart';

@immutable
abstract class SearchPageEvent {}

class SearchTextChanged extends SearchPageEvent{
  final String searchTerm;

  SearchTextChanged(this.searchTerm);
}
