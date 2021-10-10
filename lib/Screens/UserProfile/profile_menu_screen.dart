import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vegetarian/Screens/BlogScreen/user_blogs_screen.dart';
import 'package:vegetarian/Screens/MainScreen/main_screen.dart';
import 'package:vegetarian/Screens/Recipes/user_recipes_screen.dart';
import 'package:vegetarian/Screens/UserProfile/profile.dart';
import 'package:vegetarian/Screens/UserProfile/user_liked_screen.dart';
import 'package:vegetarian/blocs/blog_bloc.dart';
import 'package:vegetarian/blocs/home_blocs.dart';
import 'package:vegetarian/blocs/liked_bloc.dart';
import 'package:vegetarian/blocs/profile_blocs.dart';
import 'package:vegetarian/blocs/profile_menu_blocs.dart';
import 'package:vegetarian/blocs/user_blogs_bloc.dart';
import 'package:vegetarian/blocs/user_recipes_bloc.dart';
import 'package:vegetarian/constants/constants.dart';
import 'package:vegetarian/events/home_events.dart';
import 'package:vegetarian/events/liked_events.dart';
import 'package:vegetarian/events/profile_events.dart';
import 'package:vegetarian/events/user_blogs_events.dart';
import 'package:vegetarian/events/user_recipes_events.dart';
import 'package:vegetarian/repositories/local_data.dart';
import 'package:vegetarian/states/blog_states.dart';
import 'package:vegetarian/states/profile_menu_state.dart';

class ProfileMenuScreen extends StatefulWidget {
  @override
  State<ProfileMenuScreen> createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenuScreen> {

    var format = new DateFormat('dd-MM-yyy');


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Profile Menu'),
        backgroundColor: Colors.green[300],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => BlocProvider(
            create: (context) =>
            HomeBloc()..add(HomeFetchEvent()),
            child: MyHomePage(token: '123',
            ),
          )));
        },
        ),
        // leading: TextButton(onPressed: logout, child: Text('out'),),
      ),
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            color: kPrimaryBackgroundColor,
          ),
        ),
        SafeArea(
          child: BlocBuilder<ProfileMenuBloc, ProfileMenuState>(
              builder: (context, state) {
            if (state is ProfileMenuStateSuccess) {
              return ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    decoration: BoxDecoration(
                        border: Border.all(color: kPrimaryBlogBoderColor),
                        color: Colors.white),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 60.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(state.user.profileImage),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(80.0),
                                border: Border.all(
                                  color: Colors.black.withOpacity(0.5),
                                  width: 2.0,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.user.firstName +
                                        ' ' +
                                        state.user.lastName,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'About me: ' + state.user.aboutMe,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Container(
                                height: 35,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: TextButton(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Logout',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  ),
                                  onPressed: logout,
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Email',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  Container(width: MediaQuery.of(context).size.width*0.4,child: Text(state.user.email))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Country',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  Container(width: MediaQuery.of(context).size.width*0.4,child: Text(state.user.country))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Instagram',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.4,
                                      child: Text(state.user.instagramLink, overflow: TextOverflow.ellipsis,))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Facebook',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  Container(width: MediaQuery.of(context).size.width*0.4,child: Text(state.user.facebookLink, overflow: TextOverflow.ellipsis,))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Phone',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  Container(width: MediaQuery.of(context).size.width*0.4,child: Text(state.user.phoneNumber))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Birthday',
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  Container(width: MediaQuery.of(context).size.width*0.4,child: Text(format.format(state.user.birthDate), overflow: TextOverflow.ellipsis,))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  height: 35,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black12),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: TextButton(
                                    child: Column(
                                      children: [
                                        Text(
                                          'Edit profile',
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                    ),
                                    onPressed: () {
                                      Navigator.
                                      push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => BlocProvider(
                                                create: (context) => ProfileBloc()
                                                  ..add(
                                                      ProfileFetchEvent()),
                                                child: Profile(),
                                              )));
                                    },
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: GridView.count(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      primary: false,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      crossAxisCount: 2,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                          create: (context) => UserRecipesBloc()
                                            ..add(UserRecipesFetchEvent(
                                                state.user.id)),
                                          child: UserRecipesScreen(),
                                        )));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: kPrimaryBlogBoderColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.white),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 80.0,
                                  height: 80.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/vegetable_icon.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Your Recipes',
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                          create: (context) => UserBlogsBloc()
                                            ..add(UserBlogsFetchEvent(
                                                state.user.id)),
                                          child: UserBlogsScreen(),
                                        )));
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: kPrimaryBlogBoderColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.white),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 80.0,
                                  height: 80.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/blog_icon.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Your Blogs',
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                          decoration: BoxDecoration(
                              border: Border.all(color: kPrimaryBlogBoderColor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 80.0,
                                height: 80.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/video_icon.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Your Videos',
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                      create: (context) => LikedBloc()
                                        ..add(LikedFetchEvent()),
                                      child: UserLikedScreen(),
                                    )));
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                            decoration: BoxDecoration(
                                border: Border.all(color: kPrimaryBlogBoderColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.white),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 80.0,
                                  height: 80.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/like_icon.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Liked',
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            }
            return Text('ahihi');
          }),
        ),
      ]),
    );
  }

  Future<void> logout() async {
    await LocalData().logOut();
    await Future.delayed(Duration(seconds: 1));
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) => BlocProvider(
            create: (context) => HomeBloc()..add(HomeFetchEvent()),
            child: MyHomePage(
              token: '123',
            )),
      ),
      (Route route) => false,
    );
  }
}
