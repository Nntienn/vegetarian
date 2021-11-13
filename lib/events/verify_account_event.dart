
import 'package:vegetarian/blocs/login_blocs.dart';
import 'package:vegetarian/blocs/verify_account_bloc.dart';

class VerifyFetchEvent extends VerifyBloc {}

class VerifyEvent extends VerifyBloc {
  final String code;

  VerifyEvent(this.code);
}
