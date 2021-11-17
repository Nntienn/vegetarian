import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetarian/Screens/BlogScreen/blog_screen.dart';
import 'package:vegetarian/Screens/MainScreen/main_screen.dart';
import 'package:vegetarian/Screens/Recipes/recipe_screen.dart';
import 'package:vegetarian/blocs/blog_bloc.dart';
import 'package:vegetarian/blocs/home_blocs.dart';
import 'package:vegetarian/blocs/liked_bloc.dart';
import 'package:vegetarian/blocs/recipe_blocs.dart';
import 'package:vegetarian/constants/constants.dart';
import 'package:vegetarian/events/blog_event.dart';
import 'package:vegetarian/events/home_events.dart';
import 'package:vegetarian/events/recipe_event.dart';
import 'package:vegetarian/states/liked_state.dart';

class UserLikedScreen extends StatefulWidget {
  UserLikedScreen({Key? key}) : super(key: key);

  @override
  _UserLikedScreenState createState() => _UserLikedScreenState();
}

class _UserLikedScreenState extends State<UserLikedScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
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
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.book)),
              Tab(icon: Icon(Icons.short_text_outlined)),
            ],
          ),
          title: const Text('What you liked'),
        ),
        body: TabBarView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(color: Colors.white),
              height: MediaQuery.of(context).size.height * 0.7652,
              child: BlocBuilder<LikedBloc, LikedState>(
                  builder: (context, state) {
                    if (state is LikedStateSuccess) {
                      return ListView.builder(
                        physics: ClampingScrollPhysics(),
                        itemCount:
                        (state.recipes != null) ? state.recipes.length : 0,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                      create: (context) => RecipeBloc()
                                        ..add(RecipeFetchEvent(
                                            state.recipes[index].recipeId,"userlike")),
                                      child: RecipeScreen(),
                                    )));
                          },
                          child: Container(
                              margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: kPrimaryBoderColor)),
                              child: Row(
                                children: [
                                  Container(
                                    width: 132.0,
                                    height: 100.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            state.recipes[index].recipeThumbnail),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                    MediaQuery.of(context).size.width * 0.6,
                                    padding:
                                    const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(state.recipes[index].recipeTitle,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: kPrimaryTextColor),
                                            overflow: TextOverflow.fade),
                                        Text(
                                          state.recipes[index].firstName +
                                              ' ' +
                                              state.recipes[index].lastName,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: kPrimaryTextColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      );
                    }
                    return Center(
                      child: Text('There is no recipe, lets make some'),
                    );
                  }),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(color: Colors.white),
              height: MediaQuery.of(context).size.height * 0.7652,
              child: BlocBuilder<LikedBloc, LikedState>(
                  builder: (context, state) {
                    if (state is LikedStateSuccess) {
                      return ListView.builder(
                        physics: ClampingScrollPhysics(),
                        itemCount:
                        (state.recipes != null) ? state.recipes.length : 0,
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
                                  border: Border.all(color: kPrimaryBoderColor)),
                              child: Row(
                                children: [
                                  Container(
                                    width: 132.0,
                                    height: 100.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            state.blogs[index].blogThumbnail),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                    MediaQuery.of(context).size.width * 0.6,
                                    padding:
                                    const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(state.blogs[index].blogTitle,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: kPrimaryTextColor),
                                            overflow: TextOverflow.fade),
                                        Text(
                                          state.blogs[index].firstName +
                                              ' ' +
                                              state.blogs[index].lastName,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: kPrimaryTextColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      );
                    }
                    return Center(
                      child: Text('There is no recipe, lets make some'),
                    );
                  }),
            ),

          ],
        ),
      ),
    );}
}
