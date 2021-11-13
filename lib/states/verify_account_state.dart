
class VerifyState {
}

class VerifyStateInitial extends VerifyState {
}
class VerifyStateFailure extends VerifyState {
  final String errorMessage;
  VerifyStateFailure({required this.errorMessage});
}
class VerifyEmptyState extends VerifyState {
  final String errorMessage;
  VerifyEmptyState({required this.errorMessage});
}
class VerifyStateSuccess extends VerifyState {
}