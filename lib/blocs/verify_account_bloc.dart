import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vegetarian/events/login_events.dart';
import 'package:vegetarian/events/verify_account_event.dart';
import 'package:vegetarian/models/user.dart';
import 'package:vegetarian/repositories/google_sign_in_api.dart';
import 'package:vegetarian/repositories/local_data.dart';
import 'package:vegetarian/repositories/login_repository.dart';
import 'package:vegetarian/repositories/users_repository.dart';
import 'package:vegetarian/states/login_states.dart';
import 'package:vegetarian/states/verify_account_state.dart';

class VerifyBloc extends Bloc<VerifyBloc, VerifyState> {
  VerifyBloc() : super(VerifyStateInitial());

  @override
  Stream<VerifyState> mapEventToState(VerifyBloc event) async* {
    if (event is LoginFetchEvent) {
      yield VerifyStateInitial();
    }
    if (event is VerifyEvent) {
        bool isVerify = await verifyUser(event.code);
        if (isVerify) {
          // String? phone = await LocalData().getPhone();
          String? token = await LocalData().getToken();
          yield VerifyStateSuccess();
        } else {
          yield VerifyStateFailure(errorMessage: 'Incorrect Code');
        }

    }
  }
}
