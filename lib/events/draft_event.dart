import 'package:vegetarian/blocs/draft_bloc.dart';
import 'package:vegetarian/blocs/user_recipes_bloc.dart';

class DraftFetchEvent extends DraftBloc{
  // final int userId;
  // DraftFetchEvent(this.userId);
}
class DraftDeleteEvent extends DraftBloc{
  final String type;
  final int recipeId;
  DraftDeleteEvent(this.recipeId, this.type);
}
class SetPublicEvent extends DraftBloc{
  final int recipeID;
  SetPublicEvent(this.recipeID);
}