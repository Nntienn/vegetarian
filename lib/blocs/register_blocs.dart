import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetarian/events/register_events.dart';
import 'package:vegetarian/repositories/users_repository.dart';
import 'package:vegetarian/states/register_states.dart';


class RegisterBloc extends Bloc<RegisterBloc, RegisterState> {
  RegisterBloc():super(RegisterStateInitial());

  @override
  Stream<RegisterState> mapEventToState(RegisterBloc event) async* {
    if (event is RegisterOnSubmitEmailEvent) {
      try {
        if (event.email.trim().isEmpty) {
          yield RegisterStateFailure(firstName: null, lastName: null,email: 'Email is not blank', password: null, confirm: null, status: false);
        }
        else {
          yield RegisterStateFailure(firstName: null, lastName: null,email: null, password: null, confirm: null, status: false);
        }
      } catch (exception) {
        print('State error: ' + exception.toString());
        yield RegisterStateFailure(firstName: null, lastName: null,email: 'Email is not blank', password: null, confirm: null, status: false);
      }
    }
    if (event is RegisterOnSubmitPasswordEvent) {
      try {
        if (event.password.isEmpty) {
          yield RegisterStateFailure(firstName: null, lastName: null,email: null, password: 'Password is not blank', confirm: null, status: false);
        }
        else {
          yield RegisterStateFailure(firstName: null, lastName: null,email: null, password: null, confirm: null, status: false);
        }
      } catch (exception) {
        print('State error: ' + exception.toString());
        yield RegisterStateFailure(firstName: null, lastName: null,email: null, password: 'Password is not blank', confirm: null, status: false);
      }
    }
    if (event is RegisterOnSubmitConfirmEvent) {
      try {
        if (event.confirm.isEmpty) {
          yield RegisterStateFailure(firstName: null, lastName: null,email: null, password: null, confirm: 'Password is not blank', status: false);
        } else if (event.confirm.compareTo(event.password) != 0) {
          yield RegisterStateFailure(firstName: null, lastName: null,email: null, password: null, confirm: 'Incorrect', status: false);
        } else {
          yield RegisterStateFailure(firstName: null, lastName: null,email: null, password: null, confirm: null, status: false);
        }
      } catch (exception) {
        print('State error: ' + exception.toString());
        yield RegisterStateFailure(firstName: null, lastName: null,email: null, password: null, confirm: null, status: false);
      }
    }
    if (event is RegisterOnSubmitfirstNameEvent) {
      try {
        if (event.firstName.trim().isEmpty) {
          yield RegisterStateFailure(firstName: "First Name is not blank", lastName: null,email: null, password: null, confirm: null, status: false);
        } else {
          yield RegisterStateFailure(firstName: null, lastName: null,email: null, password: null, confirm: null, status: false);
        }
      } catch (exception) {
        print('State error: ' + exception.toString());
        yield RegisterStateFailure(firstName: null, lastName: null,email: null, password: null, confirm: null, status: false);
      }
    }
    if (event is RegisterOnSubmitlastNameEvent) {
      try {
        if (event.lastName.trim().isEmpty) {
          yield RegisterStateFailure(firstName: null, lastName: 'Last Name is not blank',email: null, password: null, confirm: null, status: false);
        } else {
          yield RegisterStateFailure(firstName: null, lastName: null,email: null, password: null, confirm: null, status: false);
        }
      } catch (exception) {
        print('State error: ' + exception.toString());
        yield RegisterStateFailure(firstName: null, lastName: null,email: null, password: null, confirm: null, status: false);
      }
    }
    if (event is RegisterEvent) {
      try {
        if (event.email.trim().isEmpty) {
          yield RegisterStateFailure(firstName: null, lastName: null,email: 'Email is not blank', password: null, confirm: null, status: false);
        } else if (event.password.isEmpty) {
          yield RegisterStateFailure(firstName: null, lastName: null,email: null, password: 'Password is not blank', confirm: null, status: false);
        } else if (event.confirm.isEmpty) {
          yield RegisterStateFailure(firstName: null, lastName: null,email: null, password: null, confirm: 'Password is not blank', status: false);
        } else if (event.confirm.compareTo(event.password) != 0) {
          yield RegisterStateFailure(firstName: null, lastName: null,email: null, password: null, confirm: 'Incorrect', status: false);
        } else if (event.firstName.trim().isEmpty) {
          yield RegisterStateFailure(firstName: "First Name is not blank", lastName: null,email: null, password: null, confirm: null, status: false);
        } else if (event.lastName.trim().isEmpty) {
          yield RegisterStateFailure(firstName: null, lastName: "Last Name is not blank",email: null, password: null, confirm: null, status: false);
        } else {
          // String dob = event.dob.split(' ')[0];
          // DateTime date = DateTime.parse(dob);
          // String formatDate = DateFormat('yyyy/MM/dd').format(date);
          // print(formatDate);
          String register = await createUser(event.email, event.password, event.firstName, event.lastName);
          switch (register) {
            case '0': yield RegisterStateFailure(firstName: null, lastName: null,email: null, password: null, confirm: null, status: false); break;
            case 'true': yield RegisterStateSuccess(); break;
            case 'doubly': yield RegisterStateFailure(firstName: null, lastName: null,email: 'email is registed', password: null, confirm: null, status: false); break;
          }
        }
      } catch (exception) {
        print('State error: ' + exception.toString());
        yield RegisterStateFailure(firstName: null, lastName: null,email: null, password: null, confirm: null, status: false);
      }
    }
  }
}