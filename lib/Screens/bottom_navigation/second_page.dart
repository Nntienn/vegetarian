
import 'package:flutter/material.dart';
import 'package:vegetarian/models/user.dart';

class SecondPage extends StatelessWidget {
  final User user;
  SecondPage({ required this.user}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text( user.firstName),
      ),
    );
  }
}
