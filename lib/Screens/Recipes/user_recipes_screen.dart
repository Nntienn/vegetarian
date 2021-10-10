import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetarian/Screens/Recipes/create_recipe_screen.dart';
import 'package:vegetarian/Screens/Recipes/recipe_screen.dart';
import 'package:vegetarian/Screens/UserProfile/profile_menu_screen.dart';
import 'package:vegetarian/blocs/create_recipe_bloc.dart';
import 'package:vegetarian/blocs/profile_menu_blocs.dart';
import 'package:vegetarian/blocs/recipe_blocs.dart';
import 'package:vegetarian/blocs/user_recipes_bloc.dart';
import 'package:vegetarian/constants/constants.dart';
import 'package:vegetarian/events/create_recipe_events.dart';
import 'package:vegetarian/events/profile_menu_events.dart';
import 'package:vegetarian/events/recipe_event.dart';
import 'package:vegetarian/events/user_recipes_events.dart';
import 'package:vegetarian/states/user_recipes_state.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back), onPressed: () { Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => ProfileMenuBloc()
                      ..add(ProfileMenuFetchEvent()),
                    child: ProfileMenuScreen(),
                  ))); },
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
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black12),
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                    color: Colors.white),
                child: Row(
                  children: [
                    Container(
                      child: Icon(
                        Icons.search,
                        color: Colors.black45,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                            hintText: "Search",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Text(
                          'Filter by',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black45),
                        )),
                    Container(
                        height: 35,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: TextButton(
                          child: Column(
                            children: [
                              Text(
                                'Most liked',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: kPrimaryTextColor),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                          onPressed: () {},
                        )),
                    Container(
                        height: 35,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: TextButton(
                          child: Column(
                            children: [
                              Text(
                                'Most recent',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: kPrimaryTextColor),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                          onPressed: () {},
                        ))
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(color: Colors.white),
                height: MediaQuery.of(context).size.height * 0.7,
                child: BlocConsumer<UserRecipesBloc, UserRecipeState>(
                    listener: (context, state) {
                  if (state is UserRecipeDeleteStateSuccess) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) => UserRecipesBloc()
                                    ..add(UserRecipesFetchEvent(state.userId)),
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

                    return ListView.builder(
                      physics: ClampingScrollPhysics(),
                      itemCount:
                          (state.recipes != null) ? state.recipes.length : 0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            caption: 'Delete',
                            color: Colors.red,
                            icon: Icons.delete,
                            onTap: () {
                              showAlertDialog(context, index);
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
                                                state.recipes[index].recipeId)),
                                          child: RecipeScreen(),
                                        )));
                          },
                          child: Container(
                              margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: kPrimaryBoderColor)),
                              child: Row(
                                children: [
                                  Container(
                                    width: 131.0,
                                    height: 100.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(state
                                            .recipes[index].recipeThumbnail),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
