
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetarian/Screens/MainScreen/main_screen.dart';
import 'package:vegetarian/blocs/home_blocs.dart';
import 'package:vegetarian/events/home_events.dart';
import 'Screens/Login/login_screen.dart';
import 'blocs/login_blocs.dart';
import 'events/login_events.dart';


void main()  {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: BlocProvider(
        create: (context) => HomeBloc()..add(HomeFetchEvent()),
        child: MyHomePage(token: '123',),
      ),
    );
  }
}
