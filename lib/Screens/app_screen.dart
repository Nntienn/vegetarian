import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetarian/blocs/bottom_navigation_bloc.dart';
import 'package:vegetarian/events/bottom_navigation_event.dart';
import 'package:vegetarian/states/bottom_navigation_state.dart';

import 'bottom_navigation/first_page.dart';
import 'bottom_navigation/second_page.dart';



class AppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Navigation with BLoC'),
      ),
      body: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (BuildContext context, BottomNavigationState state) {
          if (state is PageLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is FirstPageLoaded) {
            return FirstPage(token: state.token,recipes: state.recipes, Bestecipes: state.Bestecipes, blogs: state.blogs, videos: state.videos,recommends: state.recommends, user: state.user);
          }
          if (state is SecondPageLoaded) {
            return SecondPage(user: state.user,);
          }
          return Container();
        },
      ),
      bottomNavigationBar:
          BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
              builder: (BuildContext context, BottomNavigationState state) {
        return BottomNavigationBar(
          currentIndex:
              context.select((BottomNavigationBloc bloc) => bloc.currentIndex),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black),
              label: 'First',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.all_inclusive, color: Colors.black),
              label: 'Second',
            ),
          ],
          onTap: (index) => context
              .read<BottomNavigationBloc>()
              .add(PageTapped(index: index)),
        );
      }),
    );
  }
}
