import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:vegetarian/Screens/Login/create_account.dart';
import 'package:vegetarian/Screens/MainScreen/main_screen.dart';
import 'package:vegetarian/Screens/logged_in_page.dart';
import 'package:vegetarian/blocs/home_blocs.dart';
import 'package:vegetarian/blocs/login_blocs.dart';
import 'package:vegetarian/blocs/register_blocs.dart';
import 'package:vegetarian/events/home_events.dart';
import 'package:vegetarian/events/login_events.dart';
import 'package:vegetarian/repositories/google_sign_in_api.dart';
import 'package:vegetarian/states/login_states.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  late LoginBloc _loginBloc;
  late bool isLogin = false;
  // late ProgressDialog progressDialog;

  @override
  void initState() {
    _loginBloc = BlocProvider.of(context);
    super.initState();
  } //end initialize

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
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
                            "Login",
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
                            controller: _userController,
                            decoration: InputDecoration(
                                hintText: "Your email",
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
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: "password",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    BlocListener<LoginBloc, LoginState>(
                      listener: (context, state) {
                        print(state);
                        if (state is LoginStateFailure) {
                          return _displayTopMotionToast(context, "fail");
                        }
                        if (state is LoginEmptyState) {
                          return _displayTopMotionToast(context, "empty");
                        }
                        if (state is LoginStateSuccess) {
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => BlocProvider(
                            create: (context) =>
                            HomeBloc()..add(HomeFetchEvent()),
                            child: MyHomePage(token: '123',
                            ),
                          )));
                        }
                      },
                      child: InkWell(
                        onTap: () async {
                          _loginBloc.add(LoginEvent(
                              email: _userController.value.text,
                              password: _passwordController.value.text));
                        },
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          decoration: BoxDecoration(
                              color: Colors.green[200],
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              "login",
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      style:ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.black,
                        minimumSize: Size(double.infinity, 50),
                      ),
                      icon: FaIcon(
                        FontAwesomeIcons.google,
                        color: Colors.red,
                      ),
                      label: Text('Sign in with Goole'),
                      onPressed: signIn,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlocProvider(create: (context) => RegisterBloc(),child: CreateAccount(),)));
                      },
                      child: Text(
                        "Create new account?",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 20,),

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
    if(user == null){
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign In Failed')));
    }else{
       final _googleSignIn = GoogleSignIn();
      _googleSignIn.signIn().then((result){
        result!.authentication.then((googleKey){
          print(googleKey.accessToken);
          // print(googleKey.idToken);
          print(_googleSignIn.currentUser!.displayName);
        }).catchError((err){
          print('inner error');
        });
      }).catchError((err){
        print('error occured');
      });
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoggedInPage(user : user)));}
  }
}
