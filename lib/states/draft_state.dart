
import 'package:vegetarian/models/draft.dart';


class DraftState {
  const DraftState();
}

class DraftStateInitial extends DraftState {}

class DraftStateFailure extends DraftState {}

class DraftStateSuccess extends DraftState {

  final Draft result;

  DraftStateSuccess(this.result);
}
class DraftDeleteStateSuccess extends DraftState {
}

