import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:vegetarian/events/draft_event.dart';
import 'package:vegetarian/events/user_recipes_events.dart';
import 'package:vegetarian/models/draft.dart';
import 'package:vegetarian/models/recipes_card.dart';
import 'package:vegetarian/repositories/local_data.dart';
import 'package:vegetarian/repositories/recipes_repository.dart';
import 'package:vegetarian/repositories/users_repository.dart';
import 'package:vegetarian/states/draft_state.dart';
import 'package:vegetarian/states/user_recipes_state.dart';

class DraftBloc extends Bloc<DraftBloc, DraftState> {
  DraftBloc() :super(DraftStateInitial());

  @override
  Stream<DraftState> mapEventToState(DraftBloc event) async* {
    if (event is DraftFetchEvent) {
      String? token = await LocalData().getToken();
      // int userId = event.userId;
      Draft? tenRecipes = await getUserDraft();
      if (tenRecipes != null) {
        yield DraftStateSuccess(tenRecipes );
      }
    }
    if (event is SetPublicEvent) {
      String? token = await LocalData().getToken();
      Map<String?, dynamic> payload = Jwt.parseJwt(token!);
      int userId = payload['id'];
      bool like = await privateRecipes(event.recipeID);
      if (like) {
        yield DraftDeleteStateSuccess();
      }
    }
    if(event is DraftDeleteEvent){
      String? token = await LocalData().getToken();
      Map<String?, dynamic> payload = Jwt.parseJwt(token!);
      int userId = payload['id'];
      if(event.type == 'recipe') {
        bool delete = await deleteRecipe(event.recipeId);
        if(delete){
          yield DraftDeleteStateSuccess();
        }
      }else{

      }

    }
  }
}