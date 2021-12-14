import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vegetarian/events/login_events.dart';
import 'package:vegetarian/models/user.dart';
import 'package:vegetarian/repositories/google_sign_in_api.dart';
import 'package:vegetarian/repositories/local_data.dart';
import 'package:vegetarian/repositories/login_repository.dart';
import 'package:vegetarian/repositories/users_repository.dart';
import 'package:vegetarian/states/login_states.dart';

class LoginBloc extends Bloc<LoginBloc, LoginState> {
  LoginBloc() : super(LoginStateInitial());

  @override
  Stream<LoginState> mapEventToState(LoginBloc event) async* {
    if (event is LoginFetchEvent) {
      yield LoginStateInitial();
    }
    if (event is LoginEvent) {
      if (event.email.trim().isEmpty || event.password.trim().isEmpty) {
        yield LoginEmptyState(
            errorMessage: 'Empty email or password'
        );
      } else {
        // try {
        String? isLogin = await login(event.email, event.password);
        if (isLogin == "success") {
          // String? phone = await LocalData().getPhone();
          String? token = await LocalData().getToken();
          yield LoginStateSuccess();
        }else if(isLogin == "Wrong Email or Password"){
          yield LoginStateWrong(errorMessage: isLogin!);
        } else {
          yield LoginStateFailure(errorMessage: isLogin.toString());
        }
      }
      //   catch (exception) {
      //   print(exception);
      //   yield LoginStateFailure(errorMessage: 'Incorrect email or password');
      // }
    }else if(event is LoginWithGoogleEvent){
      bool isLogin = await  await googlelogin(event.email, event.firstName, event.lastName,event.image);
      if(isLogin){
        yield LoginStateSuccess();
      }else{
        yield LoginStateFailure(errorMessage: 'Incorrect email or password');
      }
    }
  }
}
