import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:vegetarian/Screens/Login/login_screen.dart';
import 'package:vegetarian/blocs/forgot_password_bloc.dart';
import 'package:vegetarian/blocs/login_blocs.dart';
import 'package:vegetarian/events/forgot_password_event.dart';
import 'package:vegetarian/events/login_events.dart';
import 'package:vegetarian/states/forgot_password_state.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key, required this.token}) : super(key: key);
  final String token;
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late ForgotPasswordBloc _ForgotPasswordBloc;
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpassController = TextEditingController();
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
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60))),
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
                                controller: _passwordController,
                                decoration: InputDecoration(
                                    hintText: "Input new password",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                              ),

                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                      BorderSide(color: Colors.grey.shade200))),
                              child: TextField(
                                controller: _confirmpassController,
                                decoration: InputDecoration(
                                    hintText: "Input confirm password",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                              ),

                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                            builder: (context, state) {
                              if(state is ForgotPasswordStateFetchSuccess){
                                print(state.email+"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
                                return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
                                  listener: (context, state) {
                                    print(state);
                                    if (state is ForgotPasswordStateFailure) {
                                      return _displayTopMotionToast(context, state.errorMessage);
                                    }
                                    if (state is ForgotPasswordStateSuccess) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => BlocProvider(
                                                create: (context) =>
                                                LoginBloc()..add(LoginFetchEvent()),
                                                child: LoginScreen(),
                                              )));
                                    }
                                  },
                                  child: InkWell(
                                    onTap: () async  {
                                      _ForgotPasswordBloc.add(ForgotPasswordResetEvent(_passwordController.value.text,_confirmpassController.text,state.email));
                                    },
                                    child: Container(
                                      height: 50,
                                      margin: EdgeInsets.symmetric(horizontal: 50),
                                      decoration: BoxDecoration(
                                          color: Colors.green[200],
                                          borderRadius: BorderRadius.circular(10)),
                                      child: Center(
                                        child: Text(
                                          "Reset Password",
                                          style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return SizedBox();
                            }
                        )

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
        MotionToast.error(
          title: "ERROR",
          titleStyle: TextStyle(fontWeight: FontWeight.bold),
          description: msg,
          animationType: ANIMATION.FROM_BOTTOM,
          position: MOTION_TOAST_POSITION.BOTTOM,
          width: 300,
        ).show(context);


  }

}
