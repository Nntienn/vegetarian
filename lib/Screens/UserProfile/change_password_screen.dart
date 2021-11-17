import 'package:cool_alert/cool_alert.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import 'package:vegetarian/Screens/UserProfile/profile_menu_screen.dart';
import 'package:vegetarian/blocs/change_password_bloc.dart';

import 'package:vegetarian/blocs/profile_menu_blocs.dart';
import 'package:vegetarian/events/change_password_event.dart';

import 'package:vegetarian/events/profile_menu_events.dart';
import 'package:vegetarian/states/change_password_state.dart';


class ChangePasswordScreen extends StatefulWidget {
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePasswordScreen> {
  late ChangePasswordBloc _ChangePasswordBloc;
  final _oldpassController = TextEditingController();
  final _newpassController = TextEditingController();
  final _confirmnewpassController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ChangePasswordBloc = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            'Change Password',
            style: TextStyle(color: Colors.amber),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          BlocProvider(
                            create: (context) =>
                            ProfileMenuBloc()
                              ..add(ProfileMenuFetchEvent("",-1)),
                            child: ProfileMenuScreen(),
                          )));
            },
          ),
          // leading: TextButton(onPressed: logout, child: Text('out'),),
        ),
        body:
        profileView() // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget profileView() {
    return
      Column(
        children: <Widget>[
          Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.black54,
                          Color.fromRGBO(0, 41, 102, 1)
                        ])),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.55,
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Old Password",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Quicksand",
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.05,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: TextFormField(
                                        onFieldSubmitted: (value) {
                                          setState(() {
                                            _oldpassController.text = value;
                                          });
                                        },
                                        style: TextStyle(color: Colors.white),
                                        controller: _oldpassController,
                                        decoration: new InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            contentPadding: EdgeInsets.only(
                                                left: 15, right: 15),
                                            hintText: "Old Password"),
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                      border: Border.all(
                                          width: 1.0, color: Colors.white70)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "New Password",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Quicksand",
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.05,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: TextFormField(
                                        onFieldSubmitted: (value) {
                                          setState(() {
                                            _newpassController.text = value;
                                          });
                                        },
                                        style: TextStyle(color: Colors.white),
                                        controller: _newpassController,
                                        decoration: new InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            contentPadding: EdgeInsets.only(
                                                left: 15, right: 15),
                                            hintText: "New Password"),
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                      border: Border.all(
                                          width: 1.0, color: Colors.white70)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Confirm New Password",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Quicksand",
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.05,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: TextFormField(
                                        onFieldSubmitted: (value) {
                                          setState(() {
                                            _confirmnewpassController.text =
                                                value;
                                          });
                                        },
                                        style: TextStyle(color: Colors.white),
                                        controller: _confirmnewpassController,
                                        decoration: new InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            contentPadding: EdgeInsets.only(
                                                left: 15, right: 15),
                                            hintText: "New Password"),
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                      border: Border.all(
                                          width: 1.0, color: Colors.white70)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child:
                        BlocListener<ChangePasswordBloc, ChangePasswordState>(
                          listener: (context, state) {
                            if (state is ChangePasswordStateSuccess) {
                              CoolAlert.show(
                                context: context,
                                type: CoolAlertType.success,
                                text: "Change Password Successful!",
                                onConfirmBtnTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BlocProvider(
                                                create: (context) =>
                                                ProfileMenuBloc()
                                                  ..add(
                                                      ProfileMenuFetchEvent("",-1)),
                                                child: ProfileMenuScreen(),
                                              )));
                                },
                              );
                            } else if (state is ChangePasswordStateFailure) {
                              return _displayTopMotionToast(
                                  context, state.errorMessage);
                            }
                            // do stuff here based on BlocA's state
                          },child: GestureDetector(
                          onTap: () {
                            _ChangePasswordBloc.add(ChangePasswordEvent(
                                _oldpassController.text,
                                _newpassController.text,
                                _confirmnewpassController.text));
                          },
                          child: Container(
                            height: 70,
                            width: 200,
                            child: Align(
                              child: Text(
                                'Save',
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 20),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.deepOrange,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                )),
                          ),
                        ),),

                      ),
                    )
                  ],
                ),
              ))
        ],
      );
  }
}

_displayTopMotionToast(BuildContext context, String msg) {
  return
    MotionToast.error(
      title: "ERROR",
      titleStyle: TextStyle(fontWeight: FontWeight.bold),
      description: msg,
      animationType: ANIMATION.FROM_BOTTOM,
      position: MOTION_TOAST_POSITION.BOTTOM,
      width: 300,
    ).show(context);
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
