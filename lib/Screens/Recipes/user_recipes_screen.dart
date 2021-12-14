import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:vegetarian/Screens/MainScreen/main_screen.dart';
import 'package:vegetarian/Screens/Recipes/create_recipe_screen.dart';
import 'package:vegetarian/Screens/Recipes/edit_recipe_screen.dart';
import 'package:vegetarian/Screens/Recipes/recipe_screen.dart';
import 'package:vegetarian/blocs/create_recipe_bloc.dart';
import 'package:vegetarian/blocs/edit_recipe_bloc.dart';
import 'package:vegetarian/blocs/home_blocs.dart';
import 'package:vegetarian/blocs/recipe_blocs.dart';
import 'package:vegetarian/blocs/user_recipes_bloc.dart';
import 'package:vegetarian/constants/constants.dart';
import 'package:vegetarian/events/create_recipe_events.dart';
import 'package:vegetarian/events/edit_recipe_events.dart';
import 'package:vegetarian/events/home_events.dart';
import 'package:vegetarian/events/recipe_event.dart';
import 'package:vegetarian/events/user_recipes_events.dart';
import 'package:vegetarian/states/user_recipes_state.dart';
import 'package:timeago/timeago.dart' as timeago;

class UserRecipesScreen extends StatefulWidget {
  UserRecipesScreen({Key? key}) : super(key: key);

  @override
  _UserRecipesScreenState createState() => _UserRecipesScreenState();
}

class _UserRecipesScreenState extends State<UserRecipesScreen> {
  final _searchController = TextEditingController();
  late UserRecipesBloc _UserRecipesBloc;

  @override
  void initState() {
    _UserRecipesBloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: kPrimaryButtonTextColor,
          foregroundColor: Colors.black,
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
          title: Text('Your Recipes'),
          actions: <Widget>[
            Container(
              child: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider(
                                create: (context) => CreateRecipeBloc()
                                  ..add(CreateRecipeFetchEvent()),
                                child: CreateRecipeScreen(),
                              )));
                },
              ),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(color: kPrimaryBackgroundColor),
          child: Column(
            children: [

              Container(
                decoration: BoxDecoration(color: Colors.white),
                margin: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.01, 0, MediaQuery.of(context).size.height * 0.01),
                height: MediaQuery.of(context).size.height * 0.87,
                child: BlocConsumer<UserRecipesBloc, UserRecipeState>(
                    listener: (context, state) {
                  if (state is UserRecipeDeleteStateSuccess) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) => UserRecipesBloc()
                                    ..add(UserRecipesFetchEvent()),
                                  child: UserRecipesScreen(),
                                )));
                  }
                }, builder: (context, state) {
                  if (state is UserRecipeStateSuccess) {
                    showAlertDialog(BuildContext context, int id) {
                      // set up the buttons
                      Widget cancelButton = TextButton(
                        child: Text("Cancel"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      );
                      Widget continueButton = TextButton(
                        child: Text("Delete"),
                        onPressed: () {
                          _UserRecipesBloc.add(UserRecipesDeleteEvent(state.recipes[id].recipeId));
                          Navigator.of(context).pop();
                        },
                      ); // set up the AlertDialog
                      AlertDialog alert = AlertDialog(
                        title: Text("Confirm"),
                        content: Text("Would you like to delete this recipe?"),
                        actions: [
                          cancelButton,
                          continueButton,
                        ],
                      ); // show the dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    }

                    return GestureDetector(
                      onVerticalDragDown: (details) {
                        print(details)
;                      },
                      child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        itemCount:
                            (state.recipes != null) ? state.recipes.length : 0,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Slidable(
                          actionPane: SlidableDrawerActionPane(),
                          secondaryActions: <Widget>[
                            IconSlideAction(
                              caption: 'Delete',
                              color: kPrimaryButtonColor3,
                              icon: Icons.delete,
                              onTap: () {
                                showAlertDialog(context, index);
                              },
                            ),
                            IconSlideAction(
                              caption: 'Edit',
                              color: kPrimaryButtonColor,
                              icon: Icons.edit,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                          create: (context) => EditRecipeBloc()
                                            ..add(EditRecipeFetchEvent(state.recipes[index].recipeId)),
                                          child: EditRecipeScreen(),
                                        )));
                              },
                            ),
                            IconSlideAction(
                              caption: state.recipes[index].status ==1 ?"public":"private",
                              color: kPrimaryButtonColor2,
                              icon:state.recipes[index].status ==1 ? FontAwesomeIcons.eye :FontAwesomeIcons.eyeSlash,
                              onTap: () {
                                _UserRecipesBloc.add(SetPrivateEvent(state.recipes[index].recipeId));
                              },
                            ),
                          ],
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                            create: (context) => RecipeBloc()
                                              ..add(RecipeFetchEvent(
                                                  state.recipes[index].recipeId,"userrecipe")),
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
                                          Row(
                                            children: [
                                              Text(
                                                state.recipes[index].firstName +
                                                    ' ' +
                                                    state.recipes[index].lastName,
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              Spacer(),
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
                                            ],
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
                                          ),
                                          state.recipes[index].status == 1 ? Text("Pending",style: TextStyle(color: Colors.yellow),)
                                              : state.recipes[index].status == 2? Text("Aprroved",style: TextStyle(color: Colors.lightGreen),)
                                              : Text("Rejected",style: TextStyle(color: Colors.redAccent),)
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
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
