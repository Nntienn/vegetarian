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
import 'package:vegetarian/Screens/Login/login_screen.dart';
import 'package:vegetarian/Screens/MainScreen/main_screen.dart';
import 'package:vegetarian/Screens/Recipes/all_recipes_screen.dart';
import 'package:vegetarian/Screens/Recipes/user_recipes_screen.dart';
import 'package:vegetarian/Screens/UserProfile/generate_weekly_menu_screen.dart';
import 'package:vegetarian/Screens/UserProfile/profile_menu_screen.dart';
import 'package:vegetarian/Screens/UserProfile/user_draft_screen.dart';
import 'package:vegetarian/Screens/UserProfile/user_liked_screen.dart';
import 'package:vegetarian/Screens/for_visitor/visit_profile.dart';
import 'package:vegetarian/blocs/all_recipes_bloc.dart';
import 'package:vegetarian/blocs/draft_bloc.dart';
import 'package:vegetarian/blocs/home_blocs.dart';
import 'package:vegetarian/blocs/liked_bloc.dart';
import 'package:vegetarian/blocs/login_blocs.dart';
import 'package:vegetarian/blocs/profile_menu_blocs.dart';
import 'package:vegetarian/blocs/recipe_blocs.dart';
import 'package:vegetarian/blocs/user_recipes_bloc.dart';
import 'package:vegetarian/blocs/visitor_profile_bloc.dart';
import 'package:vegetarian/blocs/weekly_menu_bloc.dart';
import 'package:vegetarian/constants/constants.dart';
import 'package:vegetarian/events/all_recipes_events.dart';
import 'package:vegetarian/events/draft_event.dart';
import 'package:vegetarian/events/home_events.dart';
import 'package:vegetarian/events/liked_events.dart';
import 'package:vegetarian/events/login_events.dart';
import 'package:vegetarian/events/profile_menu_events.dart';
import 'package:vegetarian/events/recipe_event.dart';
import 'package:vegetarian/events/user_recipes_events.dart';
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
  TextEditingController _editCommentController = new TextEditingController();
  TextEditingController _commentController = new TextEditingController();
  List<String> diff = ["Beginner", "Novice", "Cook", "Chef", "Gordon Ramsay"];

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
        backgroundColor: kPrimaryButtonTextColor,
        foregroundColor: Colors.black,
        title: Text('Recipe'),
        actions: <Widget>[
          BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
            if (state is RecipeStateSuccess) {
              if(state.user != null) {
                if (state.user!.id == state.author.id) {
                  return IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.menu),
                  );
                }
              }
            }
            return SizedBox();
          })
        ],
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
                if (state.path.last == "home") {
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
                }
                if (state.path.last == "userlike") {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider(
                                create: (context) =>
                                    LikedBloc()..add(LikedFetchEvent()),
                                child: UserLikedScreen(),
                              )));
                }
                if (state.path.last == "allrecipe") {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider(
                                create: (context) => AllRecipesBloc()
                                  ..add(AllRecipesFetchEvent()),
                                child: AllRecipesScreen(),
                              )));
                }
                if (state.path.last == "weeklymenu") {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider(
                                create: (context) => WeeklyMenuBloc()
                                  ..add(WeeklyMenuFetchEvent()),
                                child: WeeklyMenuScreen(),
                              )));
                }
                if (state.path.last == "userrecipe") {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider(
                                create: (context) => UserRecipesBloc()
                                  ..add(UserRecipesFetchEvent()),
                                child: UserRecipesScreen(),
                              )));
                }
                if (state.path.last == "draft") {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => DraftBloc()
                              ..add(DraftFetchEvent()),
                            child: UserDraftScreen(),
                          )));
                }
                if (state.path.last == "visitor") {
                  print("cai lone gi v");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider(
                                create: (context) => VisitorProfileBloc()
                                  ..add(VisitorProfileFetchEvent(
                                      state.author.id,
                                      "author",
                                      state.recipe.recipeId)),
                                child: VisitorProfileScreen(),
                              )));
                }
                if (state.path.last == "backtorecipe") {
                  state.path.removeLast();
                  if (state.path.last == "home") {
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
                  }
                  if (state.path.last == "draft") {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => DraftBloc()
                                ..add(DraftFetchEvent()),
                              child: UserDraftScreen(),
                            )));
                  }
                  if (state.path.last == "userlike") {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) =>
                                      LikedBloc()..add(LikedFetchEvent()),
                                  child: UserLikedScreen(),
                                )));
                  }
                  if (state.path.last == "allrecipe") {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) => AllRecipesBloc()
                                    ..add(AllRecipesFetchEvent()),
                                  child: AllRecipesScreen(),
                                )));
                  }
                  if (state.path.last == "weeklymenu") {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) => WeeklyMenuBloc()
                                    ..add(WeeklyMenuFetchEvent()),
                                  child: WeeklyMenuScreen(),
                                )));
                  }
                  if (state.path.last == "userrecipe") {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) => UserRecipesBloc()
                                    ..add(UserRecipesFetchEvent()),
                                  child: UserRecipesScreen(),
                                )));
                  }
                }
                if (state.path.last == "profile") {
                  state.path.removeLast();
                  if (state.path.last == "home") {
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
                  }

                  if (state.path.last == "userlike") {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) =>
                                      LikedBloc()..add(LikedFetchEvent()),
                                  child: UserLikedScreen(),
                                )));
                  }
                  if (state.path.last == "allrecipe") {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) => AllRecipesBloc()
                                    ..add(AllRecipesFetchEvent()),
                                  child: AllRecipesScreen(),
                                )));
                  }
                  if (state.path.last == "weeklymenu") {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) => WeeklyMenuBloc()
                                    ..add(WeeklyMenuFetchEvent()),
                                  child: WeeklyMenuScreen(),
                                )));
                  }
                  if (state.path.last == "userrecipe") {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) => UserRecipesBloc()
                                    ..add(UserRecipesFetchEvent()),
                                  child: UserRecipesScreen(),
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
                Future<void> _displayTextInputDialog(
                    BuildContext context, int commentId, String content) async {
                  return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Edit Comment'),
                          content: TextField(
                            controller: _editCommentController,
                            decoration:
                                InputDecoration(hintText: "Comment ...."),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              color: Colors.red,
                              textColor: Colors.white,
                              child: Text('CANCEL'),
                              onPressed: () {
                                setState(() {
                                  Navigator.pop(context);
                                });
                              },
                            ),
                            FlatButton(
                              color: Colors.green,
                              textColor: Colors.white,
                              child: Text('OK'),
                              onPressed: () {
                                _recipeBloc.add(EditRecipeCommentEvent(
                                    _editCommentController.text,
                                    commentId,
                                    state.recipe.recipeId));
                                setState(() {
                                  Navigator.pop(context);
                                });
                              },
                            ),
                          ],
                        );
                      });
                }

                Future<void> _commentInputDialog(BuildContext context) async {
                  return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Comment'),
                          content: TextField(
                            controller: _commentController,
                            onSubmitted: (value) {
                              _commentController.text = value;

                              _commentController.text = '';
                            },
                            decoration:
                                InputDecoration(hintText: "Comment ...."),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              color: Colors.red,
                              textColor: Colors.white,
                              child: Text('Cancel'),
                              onPressed: () {
                                setState(() {
                                  Navigator.pop(context);
                                });
                              },
                            ),
                            FlatButton(
                              color: Colors.green,
                              textColor: Colors.white,
                              child: Text('Comment'),
                              onPressed: () {
                                _recipeBloc.add(RecipeCommentEvent(
                                    _commentController.text,
                                    state.recipe.recipeId));
                                _commentController.text = '';
                                setState(() {
                                  Navigator.pop(context);
                                });
                              },
                            ),
                          ],
                        );
                      });
                }

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
                                      DateFormat('dd-MM-yyyy hh:mm')
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
                                      state.user!.id == null
                                          ? Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BlocProvider(
                                                        create: (context) =>
                                                            LoginBloc()
                                                              ..add(
                                                                  LoginFetchEvent()),
                                                        child: LoginScreen(),
                                                      )))
                                          : _recipeBloc.add(RecipeLikeEvent(
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
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  state.user == null? Navigator.push(
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
                                          ))) :state.user!.id == state.author.id
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => BlocProvider(
                                                    create: (context) =>
                                                        ProfileMenuBloc()
                                                          ..add(
                                                              ProfileMenuFetchEvent(
                                                                  "recipe",
                                                                  state.recipe
                                                                      .recipeId)),
                                                    child: ProfileMenuScreen(),
                                                  )))
                                      : Navigator.push(
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
                              Spacer(),
                              state.user ==null ? SizedBox() :
                              state.user!.id == state.author.id?
                              IconButton(
                                  onPressed: () {
                                    state.user!.id == null
                                        ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BlocProvider(
                                                  create: (context) =>
                                                  LoginBloc()
                                                    ..add(
                                                        LoginFetchEvent()),
                                                  child: LoginScreen(),
                                                )))
                                        : _recipeBloc.add(RecipeprivateEvent(
                                        state.recipe.recipeId));
                                  },
                                  icon: state.recipe.isPrivate == false
                                      ? Icon(
                                    FontAwesomeIcons.eye,
                                    color: Colors.black26,
                                  )
                                      : Icon(
                                    FontAwesomeIcons.eyeSlash,
                                    color: Colors.black26,
                                  )) : SizedBox()
                            ],
                          ),
                          Container(
                            height: 2.0,
                            color: Colors.black54.withOpacity(0.3),
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                          ),
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.leaf,
                                size: MediaQuery.of(context).size.width * 0.025,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.01,
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.875,
                                child: Text(
                                  'Ingredients: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 0, bottom: 15),
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(8),
                                itemCount: state.recipe.ingredients.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                      width: 50,
                                      child: Text(state.recipe
                                              .ingredients[index].amountInMg
                                              .toString() +
                                          "g " +
                                          state.recipe.ingredients[index]
                                              .ingredientName));
                                }),
                          ),
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.fire,
                                size: MediaQuery.of(context).size.width * 0.025,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.01,
                              ),
                              Text(
                                'Difficulty: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                diff[state.recipe.recipeDifficulty - 1],
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.solidClock,
                                size: MediaQuery.of(context).size.width * 0.025,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.01,
                              ),
                              Text(
                                'Prepare  Time: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                state.recipe.prepTimeMinutes.toString() +
                                    " Minutes",
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.solidClock,
                                size: MediaQuery.of(context).size.width * 0.025,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.01,
                              ),
                              Text(
                                'Baking Time: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                state.recipe.bakingTimeMinutes.toString() +
                                    " Minutes",
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.solidClock,
                                size: MediaQuery.of(context).size.width * 0.025,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.01,
                              ),
                              Text(
                                'Rest Time: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                state.recipe.restingTimeMinutes.toString() +
                                    " Minutes",
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.solidChartBar,
                                  size:
                                      MediaQuery.of(context).size.width * 0.025,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.01,
                                ),
                                Text(
                                  'Nutrition per serving: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          state.recipe.nutrition.calories != 0.0
                              ? Text('  Calories: ' +
                                  state.recipe.nutrition.calories
                                      .toStringAsFixed(0))
                              : SizedBox(
                                  height: 0,
                                ),
                          state.recipe.nutrition.protein != 0.0
                              ? Text('  Protein: ' +
                                  state.recipe.nutrition.protein
                                      .toStringAsFixed(0))
                              : SizedBox(
                                  height: 0,
                                ),
                          state.recipe.nutrition.fat != 0.0
                              ? Text('  Fat: ' +
                                  state.recipe.nutrition.fat.toStringAsFixed(0))
                              : SizedBox(
                                  height: 0,
                                ),
                          state.recipe.nutrition.carb != 0.0
                              ? Text('  Carb: ' +
                                  state.recipe.nutrition.carb
                                      .toStringAsFixed(0))
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
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Text(
                              "How to cook",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          state.recipe.steps.length != 0
                              ? ListView.builder(
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.recipe.steps.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                      child: Column(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        children: [
                                          // Text(
                                          //   "Step " +
                                          //       (index + 1).toString() +
                                          //       ": ",
                                          //   style: TextStyle(
                                          //       fontSize: 17,
                                          //       fontWeight: FontWeight.bold),
                                          // ),

                                          Row(
                                            children: [
                                              Container(
                                                  width: MediaQuery.of(context).size.width*0.2,
                                                  child: Text(
                                                    (index + 1).toString() + "/" + state.recipe.steps.length.toString(),
                                                    style: TextStyle(
                                                        fontSize: 15, fontWeight: FontWeight.bold),
                                                  )),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width*0.8,
                                                child: Text(
                                                  state.recipe.steps[index]
                                                      .stepContent,
                                                  style: TextStyle(fontSize: 15,height: 1.6),
                                                ),
                                              )
                                            ],
                                          ),
                                          // Text(
                                          //   state.recipe.steps[index]
                                          //       .stepContent,
                                          //   style: TextStyle(fontSize: 15,height: 1.6),
                                          // )
                                        ],
                                      ),
                                    );
                                  })
                              : Text(
                                  "It seems there aren't any instructions for this recipe..."),
                          Container(
                            height: 2.0,
                            color: Colors.black54.withOpacity(0.3),
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                          ),
                          Container(
                            height: 45,
                            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                    width: 1, color: Colors.black12)),
                            child: TextButton(
                                onPressed: () {
                                  state.user == null
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BlocProvider(
                                                    create: (context) =>
                                                        LoginBloc()
                                                          ..add(
                                                              LoginFetchEvent()),
                                                    child: LoginScreen(),
                                                  )))
                                      : _commentInputDialog(context);
                                },
                                child: Text("Comment")),
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
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
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          state.commentImage[index],
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
                                    SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            state.user!.id ==
                                                    state.comments[index].userId
                                                ? Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            BlocProvider(
                                                              create: (context) =>
                                                                  ProfileMenuBloc()
                                                                    ..add(ProfileMenuFetchEvent(
                                                                        "recipe",
                                                                        state
                                                                            .recipe
                                                                            .recipeId)),
                                                              child:
                                                                  ProfileMenuScreen(),
                                                            )))
                                                : Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            BlocProvider(
                                                              create: (context) => VisitorProfileBloc()
                                                                ..add(VisitorProfileFetchEvent(
                                                                    state
                                                                        .comments[
                                                                            index]
                                                                        .userId,
                                                                    "recipe",
                                                                    state.recipe
                                                                        .recipeId)),
                                                              child:
                                                                  VisitorProfileScreen(),
                                                            )));
                                          },
                                          child: Text(
                                            state.comments[index].firstName +
                                                " " +
                                                state.comments[index].lastName,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(state.comments[index].content),
                                        state.user == null ? SizedBox(): state.user!.id ==
                                                state.comments[index].userId
                                            ? Row(
                                                children: [
                                                  Container(
                                                    width: 50,
                                                    height: 30,
                                                    child: TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            _editCommentController
                                                                    .text =
                                                                state
                                                                    .comments[
                                                                        index]
                                                                    .content;
                                                          });
                                                          _displayTextInputDialog(
                                                              context,
                                                              state
                                                                  .comments[
                                                                      index]
                                                                  .id,
                                                              state
                                                                  .comments[
                                                                      index]
                                                                  .content);
                                                        },
                                                        child: Text('Edit')),
                                                  ),
                                                  Container(
                                                    width: 60,
                                                    height: 30,
                                                    child: TextButton(
                                                        onPressed: () {
                                                          _recipeBloc.add(
                                                              RecipeDeleteCommentEvent(
                                                                  state
                                                                      .comments[
                                                                          index]
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
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ]),
                );
              }
              return SizedBox();
            }),
      ),
    );
  }
}
