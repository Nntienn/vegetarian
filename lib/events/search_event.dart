
import 'package:vegetarian/blocs/search_bloc.dart';

class SearchFetchEvent extends SearchBloc{
  final String keyword;
  SearchFetchEvent(this.keyword);

}

class SearchEvent extends SearchBloc{
  final String? sort;
  final String keyword;
  final String? type;
  final String? diff;
  final String? category;
  final String? prepTime;

  SearchEvent(this.keyword, this.type, this.diff, this.category, this.prepTime, this.sort);
}