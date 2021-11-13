import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetarian/events/allergies_event.dart';
import 'package:vegetarian/models/list_ingredient_name.dart';
import 'package:vegetarian/repositories/users_repository.dart';
import 'package:vegetarian/states/allergies_state.dart';


class AllergiesBloc extends Bloc<AllergiesBloc, AllergiesState> {
  AllergiesBloc() :super(AllergiesStateInitial());

  @override
  Stream<AllergiesState> mapEventToState(AllergiesBloc event) async* {
    if (event is AllergiesFetchEvent) {
      ListIngredientName? list =await getAllergies();
      if (list != null) {
        yield AllergiesStateSuccess(list);
      }
    }
    if(event is AllergiesEditEvent){
      bool? updatelist = await updateAllergies(event.list);
      if(updatelist){
        ListIngredientName? list =await getAllergies();
        yield AllergiesStateSuccess(list!);
      }
    }
  }
}