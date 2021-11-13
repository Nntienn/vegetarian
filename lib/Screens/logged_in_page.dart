import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vegetarian/Screens/Login/login_screen.dart';
import 'package:vegetarian/blocs/login_blocs.dart';
import 'package:vegetarian/events/login_events.dart';
import 'package:vegetarian/repositories/google_sign_in_api.dart';

class LoggedInPage extends StatelessWidget {
  final GoogleSignInAccount user;

  LoggedInPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logged In'),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () async {
                await GoogleSignInApi.logout();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) =>
                          LoginBloc()..add(LoginFetchEvent()),
                          child: LoginScreen(),
                        )));
              },
              child: Text('logout'))
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.blueGrey.shade900,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Profile',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(user.photoUrl!),
            ),
            Text(user.email),
            Text(user.displayName.toString()),
          ],
        ),
      ),
    );
  }
}
