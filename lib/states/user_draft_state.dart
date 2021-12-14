import 'package:vegetarian/models/draft.dart';
import 'package:vegetarian/models/recipes_card.dart';

class UserDraftState {
  const UserDraftState();
}

class UserDraftStateInitial extends UserDraftState {
}
class UserDraftStateFailure extends UserDraftState {}
class UserDraftDeleteStateSuccess extends UserDraftState {
  final int userId;

  UserDraftDeleteStateSuccess(this.userId);
}
class UserDraftStateSuccess extends UserDraftState {

  final Draft draft;
  UserDraftStateSuccess(this.draft);
}