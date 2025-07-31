part of 'search_cubit.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<Item> results;
  SearchSuccess(this.results);
}

class SearchFailure extends SearchState {
  final String message;
  SearchFailure(this.message);
}
