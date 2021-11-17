import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:vegetarian/Screens/MainScreen/main_screen.dart';
import 'package:vegetarian/Screens/Recipes/all_recipes_screen.dart';
import 'package:vegetarian/Screens/Recipes/user_recipes_screen.dart';
import 'package:vegetarian/Screens/UserProfile/generate_weekly_menu_screen.dart';
import 'package:vegetarian/Screens/UserProfile/profile_menu_screen.dart';
import 'package:vegetarian/Screens/UserProfile/user_liked_screen.dart';
import 'package:vegetarian/Screens/UserProfile/user_weekly_menu_screen.dart';
import 'package:vegetarian/Screens/for_visitor/visit_profile.dart';
import 'package:vegetarian/blocs/all_recipes_bloc.dart';
import 'package:vegetarian/blocs/home_blocs.dart';
import 'package:vegetarian/blocs/liked_bloc.dart';
import 'package:vegetarian/blocs/profile_menu_blocs.dart';
import 'package:vegetarian/blocs/recipe_blocs.dart';
import 'package:vegetarian/blocs/user_recipes_bloc.dart';
import 'package:vegetarian/blocs/user_weekly_menu_bloc.dart';
import 'package:vegetarian/blocs/visitor_profile_bloc.dart';
import 'package:vegetarian/blocs/weekly_menu_bloc.dart';
import 'package:vegetarian/constants/constants.dart';
import 'package:vegetarian/events/all_recipes_events.dart';
import 'package:vegetarian/events/home_events.dart';
import 'package:vegetarian/events/liked_events.dart';
import 'package:vegetarian/events/profile_menu_events.dart';
import 'package:vegetarian/events/recipe_event.dart';
import 'package:vegetarian/events/user_recipes_events.dart';
import 'package:vegetarian/events/user_weekly_menu_event.dart';
import 'package:vegetarian/events/visitor_profile_event.dart';
import 'package:vegetarian/events/weekly_menu_event.dart';
import 'package:vegetarian/repositories/local_data.dart';
import 'package:vegetarian/states/recipes_state.dart';

class RecipeScreen extends StatefulWidget {
  @override
  State<RecipeScreen> createState() => _ProfileState();
}

class _ProfileState extends State<RecipeScreen> {
  late RecipeBloc _recipeBloc;
  TextEditingController _comments = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _recipeBloc = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Recipe'),
        leading:
            BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
          if (state is RecipeStateSuccess) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                print(state.path.last);
                if(state.path.last == "home"){
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BlocProvider(
                                create: (context) =>
                                HomeBloc()
                                  ..add(HomeFetchEvent()),
                                child: MyHomePage(
                                  token: '123',
                                ),
                              )));

                }
                if(state.path.last == "userlike"){
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BlocProvider(
                                create: (context) =>
                                LikedBloc()
                                  ..add(LikedFetchEvent()),
                                child: UserLikedScreen(
                                ),
                              )));
                }
                if(state.path.last == "allrecipe"){
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BlocProvider(
                                create: (context) =>
                                AllRecipesBloc()
                                  ..add(AllRecipesFetchEvent()),
                                child: AllRecipesScreen(
                                ),
                              )));
                }
                if(state.path.last == "weeklymenu"){
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BlocProvider(
                                create: (context) =>
                                WeeklyMenuBloc()
                                  ..add(WeeklyMenuFetchEvent()),
                                child: WeeklyMenuScreen(
                                ),
                              )));
                }
                if(state.path.last == "userrecipe"){
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BlocProvider(
                                create: (context) =>
                                UserRecipesBloc()
                                  ..add(UserRecipesFetchEvent(state.userID)),
                                child: UserRecipesScreen(
                                ),
                              )));
                }
                if(state.path.last == "visitor"){
                  print("cai lone gi v");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) =>
                            VisitorProfileBloc()
                              ..add(
                                  VisitorProfileFetchEvent(
                                      state.author.id,
                                      "author",
                                      state.recipe
                                          .recipeId)),
                            child: VisitorProfileScreen(),
                          )));

                }
                if(state.path.last == "backtorecipe"){
                  state.path.removeLast();
                  if(state.path.last == "home"){
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BlocProvider(
                                  create: (context) =>
                                  HomeBloc()
                                    ..add(HomeFetchEvent()),
                                  child: MyHomePage(
                                    token: '123',
                                  ),
                                )));

                  }

                  if(state.path.last == "userlike"){
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BlocProvider(
                                  create: (context) =>
                                  LikedBloc()
                                    ..add(LikedFetchEvent()),
                                  child: UserLikedScreen(
                                  ),
                                )));
                  }
                  if(state.path.last == "allrecipe"){
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BlocProvider(
                                  create: (context) =>
                                  AllRecipesBloc()
                                    ..add(AllRecipesFetchEvent()),
                                  child: AllRecipesScreen(
                                  ),
                                )));
                  }
                  if(state.path.last == "weeklymenu"){
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BlocProvider(
                                  create: (context) =>
                                  WeeklyMenuBloc()
                                    ..add(WeeklyMenuFetchEvent()),
                                  child: WeeklyMenuScreen(
                                  ),
                                )));
                  }
                  if(state.path.last == "userrecipe"){
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BlocProvider(
                                  create: (context) =>
                                  UserRecipesBloc()
                                    ..add(UserRecipesFetchEvent(state.userID)),
                                  child: UserRecipesScreen(
                                  ),
                                )));
                  }
                }
                if(state.path.last == "profile"){
                  state.path.removeLast();
                  if(state.path.last == "home"){
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BlocProvider(
                                  create: (context) =>
                                  HomeBloc()
                                    ..add(HomeFetchEvent()),
                                  child: MyHomePage(
                                    token: '123',
                                  ),
                                )));

                  }

                  if(state.path.last == "userlike"){
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BlocProvider(
                                  create: (context) =>
                                  LikedBloc()
                                    ..add(LikedFetchEvent()),
                                  child: UserLikedScreen(
                                  ),
                                )));
                  }
                  if(state.path.last == "allrecipe"){
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BlocProvider(
                                  create: (context) =>
                                  AllRecipesBloc()
                                    ..add(AllRecipesFetchEvent()),
                                  child: AllRecipesScreen(
                                  ),
                                )));
                  }
                  if(state.path.last == "weeklymenu"){
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BlocProvider(
                                  create: (context) =>
                                  WeeklyMenuBloc()
                                    ..add(WeeklyMenuFetchEvent()),
                                  child: WeeklyMenuScreen(
                                  ),
                                )));
                  }
                  if(state.path.last == "userrecipe"){
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BlocProvider(
                                  create: (context) =>
                                  UserRecipesBloc()
                                    ..add(UserRecipesFetchEvent(state.userID)),
                                  child: UserRecipesScreen(
                                  ),
                                )));
                  }
                }
                state.path.removeLast();
                LocalData().savePath(state.path);
              },
            );
          }
          return SizedBox();
        }),
      ),
      body: SafeArea(
        child: BlocConsumer<RecipeBloc, RecipeState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is RecipeStateInitial) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is RecipeStateFailure) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                "...",
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              if (state is RecipeStateSuccess) {
                String listIngredient = "";
                String listStep = "";
                for (int i = 0; i < state.recipe.steps.length; i++) {
                  listStep = listStep +
                      '<h2> Step ' +
                      (state.recipe.steps[i].stepIndex + 1).toString() +
                      '</h2>' +
                      '<p>' +
                      state.recipe.steps[i].stepContent +
                      '</p>';
                }
                ;
                for (int i = 0; i < state.recipe.ingredients.length; i++) {
                  if (i == state.recipe.ingredients.length - 1) {
                    listIngredient = listIngredient +
                        state.recipe.ingredients[i].amountInMg.toString() +
                        "Mg " +
                        state.recipe.ingredients[i].ingredientName;
                  } else {
                    listIngredient = listIngredient +
                        state.recipe.ingredients[i].amountInMg.toString() +
                        "Mg " +
                        state.recipe.ingredients[i].ingredientName +
                        ", ";
                  }
                }
                return Container(
                  height: MediaQuery.of(context).size.height,
                  // padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: kPrimaryBlogBoderColor),
                      color: Colors.white),
                  child: ListView(children: [
                    Stack(children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(state.recipe.recipeThumbnail),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                          child: Container(
                            decoration: new BoxDecoration(
                                color: Colors.black.withOpacity(0.2)),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        height: MediaQuery.of(context).size.height * 0.2,
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                  child: Text(
                                    state.recipe.recipeTitle,
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                Text(
                                  "Time Created: " +
                                      DateFormat('dd-MM-yyyy')
                                          .format(state.recipe.timeCreated),
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(state.recipe.totalLike.toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                IconButton(
                                    onPressed: () {
                                      _recipeBloc.add(RecipeLikeEvent(
                                          state.recipe.recipeId));
                                    },
                                    icon: state.isLiked == true
                                        ? Icon(
                                            FontAwesomeIcons.solidHeart,
                                            color: Colors.red,
                                          )
                                        : Icon(
                                            FontAwesomeIcons.heart,
                                            color: Colors.white,
                                          ))
                              ],
                            ),
                          ],
                        ),
                      )
                    ]),
                    SizedBox(height: screenSize.height / 50),
                    Container(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              state.userID == state.author.id?  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BlocProvider(
                                            create: (context) =>
                                            ProfileMenuBloc()
                                              ..add(
                                                  ProfileMenuFetchEvent("recipe",state.recipe
                                                      .recipeId)),
                                            child: ProfileMenuScreen(),
                                          ))) : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                            create: (context) =>
                                                VisitorProfileBloc()
                                                  ..add(
                                                      VisitorProfileFetchEvent(
                                                          state.author.id,
                                                          "recipe",
                                                          state.recipe
                                                              .recipeId)),
                                            child: VisitorProfileScreen(),
                                          )));
                            },
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  child: ClipOval(
                                    child: state.author.profileImage == ""
                                        ? Image.network(
                                            "https://www.donkey.bike/wp-content/uploads/2020/12/user-member-avatar-face-profile-icon-vector-22965342-e1608640557889.jpg",
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.network(
                                            state.author.profileImage,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                                Text(
                                  "  " +
                                      state.author.firstName +
                                      " " +
                                      state.author.lastName,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          Text(
                            'Difficulty: ' +
                                state.recipe.recipeDifficulty.toString(),
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                          Text(
                            'Portion: ' +
                                state.recipe.portionSize.toString() +
                                " " +
                                (state.recipe.portionType == "1"
                                    ? "Serving"
                                    : "Pieces"),
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                          Text(
                            'PrepTime: ' +
                                state.recipe.prepTimeMinutes.toString() +
                                "Minutes",
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                          Text(
                            'BakingTime: ' +
                                state.recipe.bakingTimeMinutes.toString() +
                                "Minutes",
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                          Text(
                            'RestTime: ' +
                                state.recipe.restingTimeMinutes.toString() +
                                "Minutes",
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                          Text(
                            'Recipe: ' + listIngredient,
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                          Text(
                            'Nutrition: ',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                          state.recipe.nutrition.calories != 0.0
                              ? Text(' - Calories: ' +
                                  state.recipe.nutrition.calories.toString())
                              : SizedBox(
                                  height: 0,
                                ),
                          state.recipe.nutrition.protein != 0.0
                              ? Text(' - Protein: ' +
                                  state.recipe.nutrition.protein.toString())
                              : SizedBox(
                                  height: 0,
                                ),
                          state.recipe.nutrition.fat != 0.0
                              ? Text(' - Fat: ' +
                                  state.recipe.nutrition.fat.toString())
                              : SizedBox(
                                  height: 0,
                                ),
                          state.recipe.nutrition.carb != 0.0
                              ? Text(' - Carb: ' +
                                  state.recipe.nutrition.carb.toString())
                              : SizedBox(
                                  height: 0,
                                ),
                          SizedBox(height: screenSize.height / 50),
                          Container(
                            height: 2.0,
                            color: Colors.black54.withOpacity(0.3),
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                          ),
                          Container(
                              // height: MediaQuery.of(context).size.height * 0.40,
                              child: Html(
                            data: listStep,
                          )),
                        ],
                      ),
                    ),
                    Container(
                      height: 45,
                      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(width: 1, color: Colors.black12)),
                      child: TextFormField(
                        controller: _comments,
                        onFieldSubmitted: (value) {
                          _comments.text = value;
                          _recipeBloc.add(RecipeCommentEvent(
                              _comments.text, state.recipe.recipeId));
                          _comments.text = '';
                        },
                        decoration: InputDecoration.collapsed(
                          hintText: "Comment",
                        ),
                      ),
                    ),
                    Container(
                      height: 300,
                      child: ListView.builder(
                        itemCount: state.comments.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                    width: 1, color: Colors.black12)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  state.comments[index].firstName +
                                      " " +
                                      state.comments[index].lastName,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(state.comments[index].content),
                                state.userID == state.comments[index].userId
                                    ? Row(
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 30,
                                            child: TextButton(
                                                onPressed: () {},
                                                child: Text('Edit')),
                                          ),
                                          Container(
                                            width: 60,
                                            height: 30,
                                            child: TextButton(
                                                onPressed: () {
                                                  _recipeBloc.add(
                                                      RecipeDeleteCommentEvent(
                                                          state.comments[index]
                                                              .id,
                                                          state.recipe
                                                              .recipeId));
                                                },
                                                child: Text('Delete')),
                                          ),
                                        ],
                                      )
                                    : SizedBox(
                                        height: 1,
                                      )
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ]),
                );
              }
              return SizedBox();
            }),
      ),
    );
  }
}
