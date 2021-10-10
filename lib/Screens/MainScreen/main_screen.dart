import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetarian/Screens/BlogScreen/all_blogs_screen.dart';
import 'package:vegetarian/Screens/BlogScreen/blog_screen.dart';
import 'package:vegetarian/Screens/Login/login_screen.dart';
import 'package:vegetarian/Screens/Recipes/all_recipes_screen.dart';
import 'package:vegetarian/Screens/Recipes/recipe_screen.dart';
import 'package:vegetarian/Screens/UserProfile/profile_menu_screen.dart';
import 'package:vegetarian/blocs/all_blogs_bloc.dart';
import 'package:vegetarian/blocs/all_recipes_bloc.dart';
import 'package:vegetarian/blocs/blog_bloc.dart';
import 'package:vegetarian/blocs/home_blocs.dart';
import 'package:vegetarian/blocs/login_blocs.dart';
import 'package:vegetarian/blocs/profile_menu_blocs.dart';
import 'package:vegetarian/blocs/recipe_blocs.dart';
import 'package:vegetarian/constants/constants.dart';
import 'package:vegetarian/events/all_blogs_event.dart';
import 'package:vegetarian/events/all_recipes_events.dart';
import 'package:vegetarian/events/blog_event.dart';
import 'package:vegetarian/events/login_events.dart';
import 'package:vegetarian/events/profile_menu_events.dart';
import 'package:vegetarian/events/recipe_event.dart';
import 'package:vegetarian/states/home_states.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.token}) : super(key: key);

  final String token;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String token = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          Container(
            child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
              if (state is HomeStateSuccess) {
                return IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                    create: (context) => ProfileMenuBloc()
                                      ..add(ProfileMenuFetchEvent()),
                                    child: ProfileMenuScreen(),
                                  )));
                    },
                    icon: Icon(Icons.account_circle_outlined));
              }
              return IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) =>
                                      LoginBloc()..add(LoginFetchEvent()),
                                  child: LoginScreen(),
                                )));
                  },
                  icon: Icon(Icons.power_settings_new_outlined));
            }
                //
                ),
          )
        ],
        title: TextField(),
        backgroundColor: kPrimaryAppBarColor,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: kPrimaryBackgroundColor),
        child: ListView(
          children: <Widget>[
            BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
              if (state is HomeStateInitial) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is HomeStateSuccess) {
                final double width = MediaQuery.of(context).size.width;
                return Container(
                    child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    enlargeCenterPage: false,
                    viewportFraction: 1.0,
                  ),
                  items: state.Bestecipes.map((item) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                        create: (context) => RecipeBloc()
                                          ..add(
                                              RecipeFetchEvent(item.recipeId)),
                                        child: RecipeScreen(),
                                      )));
                        },
                        child: Container(
                          child: Stack(
                            children: [
                              Container(
                                child: Image.network(
                                  item.recipeThumbnail,
                                  fit: BoxFit.cover,
                                  width: width,
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 5, 20, 5),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.7),
                                      Colors.black.withOpacity(0.0),
                                    ],
                                  ),
                                ),
                                height: MediaQuery.of(context).size.height *
                                    0.32,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: width,
                                      child: Text(
                                        item.recipeTitle,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      width: width,
                                      child: Text(
                                        item.firstName +
                                            ' ' +
                                            item.lastName,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          color: kPrimaryAppBarColor,
                        ),
                      )).toList(),
                ));
              } else if (state is HomeStateUnLogged) {
                final double width = MediaQuery.of(context).size.width;
                return Container(
                    child: CarouselSlider(
                  options: CarouselOptions(

                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 5),
                    enlargeCenterPage: false,
                    viewportFraction: 1.0,
                  ),
                  items: state.Bestecipes.map((item) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                        create: (context) => RecipeBloc()
                                          ..add(
                                              RecipeFetchEvent(item.recipeId)),
                                        child: RecipeScreen(),
                                      )));
                        },
                        child: Container(
                          child: Stack(
                            children: [
                              Container(
                                child: Image.network(
                                  item.recipeThumbnail,
                                  fit: BoxFit.cover,
                                  width: width,
                                ),
                              ),
                              Container(
                                padding:
                                const EdgeInsets.fromLTRB(20, 5, 20, 5),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.7),
                                      // Colors.black.withOpacity(0.25),
                                      Colors.black.withOpacity(0.0),
                                      // Colors.black.withOpacity(0.1),
                                      // Colors.black.withOpacity(0.0)
                                    ],
                                  ),
                                ),
                                height: MediaQuery.of(context).size.height *
                                    0.32,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: width,
                                      child: Text(
                                        item.recipeTitle,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      width: width,
                                      child: Text(
                                        item.firstName +
                                            ' ' +
                                            item.lastName,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          color: kPrimaryAppBarColor,
                        ),
                      )).toList(),
                ));
              } else {
                return Text('không có gì car');
              }
            }),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 5),
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              height: MediaQuery.of(context).size.height * 0.29,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(
                          'Lastest Recipes',
                          style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Spacer(),
                      Container(
                          height: 30,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                              create: (context) =>
                                                  AllRecipesBloc()
                                                    ..add(
                                                        AllRecipesFetchEvent()),
                                              child: AllRecipesScreen(),
                                            )));
                              },
                              child: Text('See All')))
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    height: MediaQuery.of(context).size.height * 0.23,
                    child: BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                      if (state is HomeStateInitial) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (state is HomeStateSuccess) {
                        return ListView.builder(
                          itemCount: (state.recipes != null)
                              ? state.recipes.length
                              : 0,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                            create: (context) => RecipeBloc()
                                              ..add(RecipeFetchEvent(state
                                                  .recipes[index].recipeId)),
                                            child: RecipeScreen(),
                                          )));
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width * 0.26,
                              margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              // decoration: BoxDecoration(border: Border.all(color: kPrimaryBoderColor)),
                              child: Stack(children: [
                                Container(
                                  height: MediaQuery.of(context).size.height,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          state.recipes[index].recipeThumbnail),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 0.0,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.7),
                                        // Colors.black.withOpacity(0.25),
                                        Colors.black.withOpacity(0.0),
                                        // Colors.black.withOpacity(0.1),
                                        // Colors.black.withOpacity(0.0)
                                      ],
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 6, 10, 10),
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.recipes[index].recipeTitle,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 12),
                                            overflow: TextOverflow.clip,
                                          ),
                                          Text(
                                            state.recipes[index].firstName +
                                                ' ' +
                                                state.recipes[index].lastName,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                            ),
                          ),
                        );
                      } else if (state is HomeStateUnLogged) {
                        return ListView.builder(
                          itemCount: (state.recipes != null)
                              ? state.recipes.length
                              : 0,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                            create: (context) => RecipeBloc()
                                              ..add(RecipeFetchEvent(state
                                                  .recipes[index].recipeId)),
                                            child: RecipeScreen(),
                                          )));
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width * 0.26,
                              margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              // decoration: BoxDecoration(border: Border.all(color: kPrimaryBoderColor)),
                              child: Stack(children: [
                                Container(
                                  height: MediaQuery.of(context).size.height,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          state.recipes[index].recipeThumbnail),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 0.0,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.7),
                                        // Colors.black.withOpacity(0.25),
                                        Colors.black.withOpacity(0.0),
                                        // Colors.black.withOpacity(0.1),
                                        // Colors.black.withOpacity(0.0)
                                      ],
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 6, 10, 10),
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.recipes[index].recipeTitle,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 12),
                                            overflow: TextOverflow.clip,
                                          ),
                                          Text(
                                            state.recipes[index].firstName +
                                                ' ' +
                                                state.recipes[index].lastName,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                            ),
                          ),
                        );
                      }
                      return Text('không có gì car');
                    }),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          'Lastest Blogs',
                          style: TextStyle(
                              color: Colors.black45, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Spacer(),
                      Container(
                          height: 30,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                          create: (context) =>
                                          AllBlogsBloc()
                                            ..add(
                                                AllBlogsFetchEvent()),
                                          child: AllBlogsScreen(),
                                        )));
                              },
                              child: Text('See All')))
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                      if (state is HomeStateInitial) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (state is HomeStateSuccess) {
                        return ListView.separated(
                          physics: ClampingScrollPhysics(),
                          itemCount:
                              (state.blogs != null) ? state.blogs.length : 0,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                            create: (context) => BlogBloc()
                                              ..add(BlogFetchEvent(
                                                  state.blogs[index].blogId)),
                                            child: BlogScreen(),
                                          )));
                            },
                            child: Container(
                                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 131.0,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              state.blogs[index].blogThumbnail),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.58,
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(state.blogs[index].blogTitle,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.fade),
                                          Text(
                                            state.blogs[index].firstName +
                                                ' ' +
                                                state.blogs[index].lastName,
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                        );
                      } else if (state is HomeStateUnLogged) {
                        return ListView.builder(
                          physics: ClampingScrollPhysics(),
                          itemCount:
                              (state.blogs != null) ? state.blogs.length : 0,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                            create: (context) => BlogBloc()
                                              ..add(BlogFetchEvent(
                                                  state.blogs[index].blogId)),
                                            child: BlogScreen(),
                                          )));
                            },
                            child: Container(
                                margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: kPrimaryBoderColor)),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 139.0,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              state.blogs[index].blogThumbnail),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 5.0,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.58,
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(state.blogs[index].blogTitle,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.fade),
                                          Text(
                                            state.blogs[index].firstName +
                                                ' ' +
                                                state.blogs[index].lastName,
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        );
                      }
                      return Text('không có gì car');
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
