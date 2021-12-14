import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetarian/events/search_event.dart';
import 'package:vegetarian/models/category.dart';
import 'package:vegetarian/models/search_result.dart';
import 'package:vegetarian/repositories/recipes_repository.dart';
import 'package:vegetarian/repositories/search_repository.dart';
import 'package:vegetarian/states/search_state.dart';

class SearchBloc extends Bloc<SearchBloc, SearchState> {
  SearchBloc() : super(SearchStateInitial());

  @override
  Stream<SearchState> mapEventToState(SearchBloc event) async* {
    if (event is SearchFetchEvent) {
      List<Category>? category = await getCategory();
      Search? result = await search(event.keyword, null, null, null, null, null);
      if(result!=null){
        print("1");
      }else{
        print("2");
      }
      yield SearchStateSuccess(result!,category,event.keyword);
    }
    if(event is SearchEvent){
      List<Category>? category = await getCategory();
      Search? result = await search(event.keyword, event.type, event.diff, event.category, event.prepTime, event.sort);
      yield SearchStateSuccess(result!,category,event.keyword);
    }
  }
}
