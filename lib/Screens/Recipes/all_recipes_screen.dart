import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:vegetarian/Screens/MainScreen/main_screen.dart';
import 'package:vegetarian/Screens/Recipes/recipe_screen.dart';
import 'package:vegetarian/blocs/all_recipes_bloc.dart';
import 'package:vegetarian/blocs/home_blocs.dart';
import 'package:vegetarian/blocs/recipe_blocs.dart';
import 'package:vegetarian/constants/constants.dart';
import 'package:vegetarian/events/home_events.dart';
import 'package:vegetarian/events/recipe_event.dart';
import 'package:vegetarian/states/all_recipes_state.dart';
import 'package:timeago/timeago.dart' as timeago;

class AllRecipesScreen extends StatefulWidget {
  AllRecipesScreen({Key? key}) : super(key: key);

  @override
  _AllRecipesScreenState createState() => _AllRecipesScreenState();
}

class _AllRecipesScreenState extends State<AllRecipesScreen> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: kPrimaryButtonTextColor,
          foregroundColor: Colors.black,
          title: Text('All Recipes'),
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider(
                              create: (context) =>
                                  HomeBloc()..add(HomeFetchEvent()),
                              child: MyHomePage(
                                token: '123',
                              ),
                            )));
              }),
        ),
        body: Container(
          // height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: kPrimaryBackgroundColor),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.005, 0, MediaQuery.of(context).size.height * 0.005),
                decoration: BoxDecoration(color: Colors.white),
                height: MediaQuery.of(context).size.height * 0.89,
                child: BlocBuilder<AllRecipesBloc, AllRecipesState>(
                    builder: (context, state) {
                  if (state is AllRecipesStateSuccess) {
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
                                              state.recipes[index].recipeId,
                                              "allrecipe")),
                                        child: RecipeScreen(),
                                      )));
                        },
                        child: Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 131.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          state.recipes[index].recipeThumbnail),
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
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(state.recipes[index].recipeTitle,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: "Quicksand",
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.fade),
                                      Text(
                                        state.recipes[index].firstName +
                                            ' ' +
                                            state.recipes[index].lastName,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Text(
                                        DateTime.now()
                                            .difference(state
                                            .recipes[index]
                                            .timeCreated)
                                            .inDays <
                                            1
                                            ? timeago.format(
                                            state.recipes[index]
                                                .timeCreated,
                                            locale: 'en')
                                            : DateFormat('dd-MM-yyyy')
                                            .format(state.recipes[index]
                                            .timeCreated),
                                        // state.blogs[index].timeCreated,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            child: Text(
                                              state.recipes[index].totalLike
                                                  .toString(),
                                              style: TextStyle(
                                                  fontFamily: "Quicksand",
                                                  color: Colors.black,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          state.recipes[index].isLike == true
                                              ? Icon(
                                            FontAwesomeIcons
                                                .solidHeart,
                                            color: Colors.red,
                                            size: 15,
                                          )
                                              : Icon(
                                            FontAwesomeIcons.heart,
                                            color: Colors.black,
                                            size: 15,
                                          )
                                        ],
                                      )
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
        ));
  }
}
