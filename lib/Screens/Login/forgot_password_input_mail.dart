import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:vegetarian/Screens/Login/confirm_reset_password.dart';
import 'package:vegetarian/blocs/forgot_password_bloc.dart';
import 'package:vegetarian/events/forgot_password_event.dart';
import 'package:vegetarian/repositories/google_sign_in_api.dart';
import 'package:vegetarian/states/forgot_password_state.dart';

class InputMailScreen extends StatefulWidget {
  const InputMailScreen({Key? key}) : super(key: key);

  @override
  _InputMailScreenState createState() => _InputMailScreenState();
}

class _InputMailScreenState extends State<InputMailScreen> {
  late ForgotPasswordBloc _ForgotPasswordBloc;
  final _codeController = TextEditingController();
  late bool isLogin = false;

  // late ProgressDialog progressDialog;

  @override
  void initState() {
    _ForgotPasswordBloc = BlocProvider.of(context);
    super.initState();
  } //end initialize

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal,customBody: Text('Loading'));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.green[200],
        ),
        child: ListView(
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
                      image: AssetImage('assets/logo.png'),
                      height: 200,
                      width: 200,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // Center(
            //   child: Text(
            //     "Vegetarian Application",
            //     style: TextStyle(color: Colors.white, fontSize: 18),
            //   ),
            // ),
            // SizedBox(
            //   height: 30,
            // ),
            Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(60))),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Center(
                              child: Text(
                                "Input Mail",
                                style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                      BorderSide(color: Colors.grey.shade200))),
                              child: TextField(
                                controller: _codeController,
                                decoration: InputDecoration(
                                    hintText: "Input Mail",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
                          listener: (context, state) {
                            print(state);
                            if (state is ForgotPasswordMailStateFailure) {
                              return _displayTopMotionToast(context, "fail");
                            }
                            if (state is ForgotPasswordMailStateSuccess) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                        create: (context) =>
                                        ForgotPasswordBloc()..add(ForgotPasswordConfirmFetchEvent(state.email)),
                                        child: ResetPasswordConfirmScreen(token: state.email,
                                        ),
                                      )));
                            }
                          },
                          child: InkWell(
                            onTap: () async  {
                              _ForgotPasswordBloc.add(ForgotPasswordInputMailEvent(_codeController.value.text));
                            },
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              decoration: BoxDecoration(
                                  color: Colors.green[200],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  "Send Code",
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  _displayTopMotionToast(BuildContext context, String msg) {
    switch (msg) {
      case "fail":
        MotionToast.error(
          title: "ERROR",
          titleStyle: TextStyle(fontWeight: FontWeight.bold),
          description: "Username and password is invalid",
          animationType: ANIMATION.FROM_BOTTOM,
          position: MOTION_TOAST_POSITION.BOTTOM,
          width: 300,
        ).show(context);
        break;
      case "empty":
        MotionToast.warning(
          title: "WARNING",
          titleStyle: TextStyle(fontWeight: FontWeight.bold),
          description: "Username and password is not blank",
          animationType: ANIMATION.FROM_BOTTOM,
          position: MOTION_TOAST_POSITION.BOTTOM,
          width: 300,
        ).show(context);
        break;
    }
  }

  Future signIn() async {
    final user = await GoogleSignInApi.login();
    if (user == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Sign In Failed')));
    } else {
      final _googleSignIn = GoogleSignIn();
      _googleSignIn.signIn().then((result) {
        result!.authentication.then((googleKey) {
          print(googleKey.accessToken);
          // print(googleKey.idToken);
          print(_googleSignIn.currentUser!.displayName);
        }).catchError((err) {
          print('inner error');
        });
      }).catchError((err) {
        print('error occured');
      });
      String firstName = user.displayName!.split(" ")[0];
      String lastName = "";
      for(int i = 1; i<user.displayName!.split(" ").length;i++){
        lastName = lastName+" " + user.displayName!.split(" ")[i];
      }

    }
  }
}
