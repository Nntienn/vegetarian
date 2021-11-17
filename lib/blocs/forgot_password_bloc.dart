import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetarian/events/forgot_password_event.dart';
import 'package:vegetarian/repositories/users_repository.dart';
import 'package:vegetarian/states/forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordBloc, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordStateInitial());

  @override
  Stream<ForgotPasswordState> mapEventToState(ForgotPasswordBloc event) async* {
    if(event is ForgotPasswordFetchEvent){
      yield ForgotPasswordStateFetchSuccess(event.mail);
    }
    if(event is ForgotPasswordConfirmFetchEvent){
      yield ForgotPasswordVerifyStateFetchSuccess(event.mail);
    }
    if (event is ForgotPasswordInputMailEvent) {
      try {
        bool? mail = await forgotPassword(event.mail);
        if(mail!){
          yield ForgotPasswordMailStateSuccess(event.mail);
        }else{
          yield ForgotPasswordMailStateFailure(errorMessage: "this mail doesn't exist");
        }
      } catch (exception) {
        print('State error: ' + exception.toString());

      }
    }else if(event is ForgotPasswordVerifyEvent){
     String? respond = await verifyResetPassword(event.code);
     if(respond!.contains("Moving") ){
       yield ForgotPasswordVerifyStateSuccess(event.mail);
     }else{
       yield ForgotPasswordVerifyStateFailure(errorMessage: respond);
     }
    }
    else if(event is ForgotPasswordResetEvent){
      String? respond = await resetPassword( event.newPassword, event.confirmnewPassword,event.email,);
      if(respond!.contains("successfully")){
        yield ForgotPasswordStateSuccess();
      }else {
        yield ForgotPasswordStateFailure(errorMessage: respond);
      }
    }else if(event is ForgotPasswordResendCodeEvent){
      bool? mail = await forgotPasswordresend(event.mail);

    }
  }
}
