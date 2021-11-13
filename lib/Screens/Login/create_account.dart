
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:vegetarian/Screens/Login/verify_account.dart';
import 'package:vegetarian/blocs/login_blocs.dart';
import 'package:vegetarian/blocs/register_blocs.dart';
import 'package:vegetarian/blocs/verify_account_bloc.dart';
import 'package:vegetarian/events/login_events.dart';
import 'package:vegetarian/events/register_events.dart';
import 'package:vegetarian/events/verify_account_event.dart';
import 'package:vegetarian/states/register_states.dart';

import 'login_screen.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  late RegisterBloc _registerBloc;
  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';
  String confirm = '';

  @override
  void initState() {
    _registerBloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.green[300],
        ),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image(
                      image: AssetImage('assets/vegetarian-logos_white.png'),
                      height: 150,
                      width: 150,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60))),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              "Create new Account",
                              style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200))),
                            child: BlocBuilder<RegisterBloc, RegisterState>(
                              bloc: _registerBloc,
                              builder: (context, state) {
                                return TextField(
                                  onChanged: (value) {
                                    firstName = value;
                                  },
                                  onSubmitted: (value) {
                                    _registerBloc.add(
                                        RegisterOnSubmitfirstNameEvent(
                                            firstName: value));
                                  },
                                  decoration: InputDecoration(
                                      errorText: state.firstName,
                                      hintText: "Your First Name",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                );
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200))),
                            child: BlocBuilder<RegisterBloc, RegisterState>(
                              bloc: _registerBloc,
                              builder: (context, state) {
                                return TextField(
                                  onChanged: (value) {
                                    lastName = value;
                                  },
                                  onSubmitted: (value) {
                                    _registerBloc.add(
                                        RegisterOnSubmitlastNameEvent(
                                            lastName: value));
                                  },
                                  decoration: InputDecoration(
                                      errorText: state.lastName,
                                      hintText: "Your Last Name",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                );
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200))),
                            child: BlocBuilder<RegisterBloc, RegisterState>(
                              bloc: _registerBloc,
                              builder: (context, state) {
                                return TextField(
                                  onChanged: (value) {
                                    email = value;
                                  },
                                  onSubmitted: (value) {
                                    _registerBloc.add(
                                        RegisterOnSubmitEmailEvent(
                                            email: value));
                                  },
                                  decoration: InputDecoration(
                                      errorText: state.lastName,
                                      hintText: "Your email",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                );
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200))),
                            child: BlocBuilder<RegisterBloc, RegisterState>(
                              bloc: _registerBloc,
                              builder: (context, state) {
                                return TextField(
                                  obscureText: true,
                                  onChanged: (value) {
                                    password = value;
                                  },
                                  onSubmitted: (value) {
                                    _registerBloc.add(
                                        RegisterOnSubmitPasswordEvent(
                                            password: value));
                                  },
                                  decoration: InputDecoration(
                                      errorText: state.password,
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                );
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200))),
                            child: BlocBuilder<RegisterBloc, RegisterState>(
                              bloc: _registerBloc,
                              builder: (context, state) {
                                return TextField(
                                  obscureText: true,
                                  onChanged: (value) {
                                    confirm = value;
                                  },
                                  onSubmitted: (value) {
                                    _registerBloc.add(
                                        RegisterOnSubmitConfirmEvent(
                                            password: password,
                                            confirm: value));
                                  },
                                  decoration: InputDecoration(
                                      errorText: state.confirm,
                                      hintText: "Confirm password",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocListener<RegisterBloc, RegisterState>(
          bloc: _registerBloc,
          listener: (context, state) {
            if (state is RegisterStateSuccess) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider(
                            create: (context) =>
                                VerifyBloc()..add(VerifyFetchEvent()),
                            child: VerifyScreen(),
                          )));
            }
            if (state is RegisterStateFailure) {
              if (!state.status!) {
                if (state.email != null) {
                  _displayTopMotionToast(context, '0');
                }
              } else {
                _displayTopMotionToast(context, '1');
              }
            }
          },
          child: InkWell(
            onTap: () {
              _registerBloc.add(RegisterEvent(
                  firstName: firstName,
                  lastName: lastName,
                  email: email,
                  password: password,
                  confirm: confirm));
            },
            child: Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 50),
              decoration: BoxDecoration(
                  color: Colors.green[300],
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  "Create",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _displayTopMotionToast(BuildContext context, String msg) {
    switch (msg) {
      case "0":
        MotionToast.error(
          title: "ERROR",
          titleStyle: TextStyle(fontWeight: FontWeight.bold),
          description: "Unable to connect to the system.",
          animationType: ANIMATION.FROM_TOP,
          position: MOTION_TOAST_POSITION.CENTER,
          width: 300,
        ).show(context);
        break;
      case "1":
        MotionToast.error(
          title: "ERROR",
          titleStyle: TextStyle(fontWeight: FontWeight.bold),
          description: "Phone number not available.",
          animationType: ANIMATION.FROM_TOP,
          position: MOTION_TOAST_POSITION.CENTER,
          width: 300,
        ).show(context);
        break;
    }
  }
}
