import 'package:vegetarian/models/category.dart';
import 'package:vegetarian/models/search_result.dart';

class SearchState {
  const SearchState();
}

class SearchStateInitial extends SearchState {}

class SearchStateFailure extends SearchState {}

class SearchStateSuccess extends SearchState {
  final String keyword;
  final Search result;
  final List<Category> category;
  SearchStateSuccess(this.result, this.category, this.keyword);
}

class SearchStateUnLogged extends SearchState {
  final Search result;

  SearchStateUnLogged(this.result);
}
