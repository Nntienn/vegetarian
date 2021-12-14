import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vegetarian/Screens/MainScreen/main_screen.dart';
import 'package:vegetarian/Screens/UserProfile/check_nutrition_screen.dart';
import 'package:vegetarian/blocs/check_nutrition_bloc.dart';
import 'package:vegetarian/blocs/home_blocs.dart';
import 'package:vegetarian/blocs/weekly_menu_bloc.dart';
import 'package:vegetarian/constants/constants.dart';
import 'package:vegetarian/events/check_nutrition_events.dart';
import 'package:vegetarian/events/home_events.dart';
import 'package:vegetarian/events/weekly_menu_event.dart';
import 'package:vegetarian/models/recipe.dart';
import 'package:vegetarian/states/weekly_menu_state.dart';

class WeeklyMenuScreen extends StatefulWidget {
  @override
  State<WeeklyMenuScreen> createState() => _WeeklyMenuState();
}

class _WeeklyMenuState extends State<WeeklyMenuScreen> {
  late WeeklyMenuBloc _WeeklyMenuBloc;
  TextEditingController _texteditFieldController = TextEditingController();
  int page = 0;

  @override
  void initState() {
    _WeeklyMenuBloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: kPrimaryButtonTextColor,
        foregroundColor: Colors.black,
        title: Text('Weekly Menu'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
          },
        ),
        // leading: TextButton(onPressed: logout, child: Text('out'),),
      ),
      body: BlocConsumer<WeeklyMenuBloc, WeeklyMenuState>(
          listener: (context, state) {
        if (state is SaveWeeklyMenuStateSuccess) {
          CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            text: "Save successful!",
            onConfirmBtnTap: () {
              Navigator.pop(context);
            },
          );
        }
        if (state is WeeklyMenuCreateStateFailure) {
          _WeeklyMenuBloc.add(WeeklyMenuGenerateEvent(5));
        }
      }, builder: (context, state) {
        if (state is WeeklyMenuStateSuccess) {
          Future<void> _displayTextInputDialog(BuildContext context) async {
            return showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Number of Recipe per day'),
                    content: Container(
                      height: MediaQuery.of(context).size.height / 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(60),
                                  ),
                                  color: kPrimaryButtonColor),
                              child: TextButton(
                                  onPressed: () {
                                    _WeeklyMenuBloc.add(
                                        WeeklyMenuGenerateEvent(3));
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "3 Recipes",
                                    style: TextStyle(color: Colors.white),
                                  ))),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(60),
                                  ),
                                  color: kPrimaryButtonColor),
                              child: TextButton(
                                  onPressed: () {
                                    _WeeklyMenuBloc.add(
                                        WeeklyMenuGenerateEvent(4));
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "4 Recipes",
                                    style: TextStyle(color: Colors.white),
                                  ))),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(60),
                                  ),
                                  color: kPrimaryButtonColor),
                              child: TextButton(
                                  onPressed: () {
                                    _WeeklyMenuBloc.add(
                                        WeeklyMenuGenerateEvent(5));
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "5 Recipes",
                                    style: TextStyle(color: Colors.white),
                                  ))),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(60),
                                  ),
                                  color: kPrimaryButtonColor),
                              child: TextButton(
                                  onPressed: () {
                                    _WeeklyMenuBloc.add(
                                        WeeklyMenuGenerateEvent(6));
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "6 Recipes",
                                    style: TextStyle(color: Colors.white),
                                  ))),
                        ],
                      ),
                    ),
                  );
                });
          }

          print("ra ne");
          return Column(
            children: [
              Expanded(
                child: Column(children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          //                   <--- left side
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Row(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: IconButton(
                                onPressed: () {
                                  if (page > 0) {
                                    setState(() {
                                      page--;
                                    });
                                  } else if (page == 0) {
                                    setState(() {
                                      page = page;
                                    });
                                  }
                                },
                                icon: Icon(
                                  Icons.keyboard_arrow_left,
                                  size: MediaQuery.of(context).size.width * 0.1,
                                ))),
                        Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              DateFormat('dd-MM-yyyy').format(
                                state.weeklyMenu.menu[page].date,
                              ),
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.075),
                            )),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: IconButton(
                                onPressed: () {
                                  if (page < 6) {
                                    setState(() {
                                      page++;
                                    });
                                  } else if (page == 6) {
                                    setState(() {
                                      page = page;
                                    });
                                  }
                                },
                                icon: Icon(
                                  Icons.keyboard_arrow_right,
                                  size: MediaQuery.of(context).size.width * 0.1,
                                ))),
                      ],
                    ),
                  ),
                  Expanded(
                      // height: MediaQuery.of(context).size.height * 0.7,
                      child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(10),
                    child: ListView(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Breakfast",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    "/" +
                                        state.weeklyMenu.menu[page]
                                            .listWeeklyRecipe[0].calo
                                            .toString() +
                                        " Calories",
                                    style: TextStyle(fontSize: 17)),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Stack(children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width / 3.5,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(state
                                        .weeklyMenu
                                        .menu[page]
                                        .listWeeklyRecipe[0]
                                        .recipeThumbnail),
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
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width / 3.5,
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
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    width:
                                        MediaQuery.of(context).size.width / 3.5,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.weeklyMenu.menu[page]
                                              .listWeeklyRecipe[0].recipeTitle,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 12),
                                          overflow: TextOverflow.clip,
                                        ),
                                        Text(
                                          "Main Dish",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                          overflow: TextOverflow.clip,
                                        ),
                                        Text(
                                          state.weeklyMenu.menu[page]
                                                  .listWeeklyRecipe[0].calo
                                                  .toString() +
                                              " Calories",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              "Lunch",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            state.weeklyMenu.menu[page].listSnack.length >= 1
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          "/" +
                                              (state
                                                          .weeklyMenu
                                                          .menu[page]
                                                          .listWeeklyRecipe[1]
                                                          .calo +
                                                      state
                                                          .weeklyMenu
                                                          .menu[page]
                                                          .listSnack[0]
                                                          .calo)
                                                  .toString() +
                                              " Calories",
                                          style: TextStyle(fontSize: 17)),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          "/" +
                                              state.weeklyMenu.menu[page]
                                                  .listWeeklyRecipe[0].calo
                                                  .toString() +
                                              " Calories",
                                          style: TextStyle(fontSize: 17)),
                                    ],
                                  ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Stack(children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width / 3.5,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(state
                                        .weeklyMenu
                                        .menu[page]
                                        .listWeeklyRecipe[1]
                                        .recipeThumbnail),
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
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width / 3.5,
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
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    width:
                                        MediaQuery.of(context).size.width / 3.5,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.weeklyMenu.menu[page]
                                              .listWeeklyRecipe[1].recipeTitle
                                              .trim(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 12),
                                          overflow: TextOverflow.clip,
                                        ),
                                        Text(
                                          "Main Dish",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                          overflow: TextOverflow.clip,
                                        ),
                                        Text(
                                          state.weeklyMenu.menu[page]
                                                  .listWeeklyRecipe[1].calo
                                                  .toString() +
                                              " Calories",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                            SizedBox(
                              width: 10,
                            ),
                            state.weeklyMenu.menu[page].listSnack.length >= 1
                                ? Stack(children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.175,
                                      width: MediaQuery.of(context).size.width /
                                          3.5,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(state
                                              .weeklyMenu
                                              .menu[page]
                                              .listSnack[0]
                                              .recipeThumbnail),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 0.0,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.175,
                                      width: MediaQuery.of(context).size.width /
                                          3.5,
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 6, 10, 10),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.175,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.5,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state.weeklyMenu.menu[page]
                                                    .listSnack[0].recipeTitle
                                                    .trim(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 12),
                                                overflow: TextOverflow.clip,
                                              ),
                                              Text(
                                                "Side dishes / snacks",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                                overflow: TextOverflow.clip,
                                              ),
                                              Text(
                                                state.weeklyMenu.menu[page]
                                                        .listSnack[0].calo
                                                        .toString() +
                                                    " Calories",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ])
                                : SizedBox(),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              "Dinner",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            state.weeklyMenu.menu[page].listSnack.length == 2
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          "/" +
                                              (state
                                                          .weeklyMenu
                                                          .menu[page]
                                                          .listWeeklyRecipe[2]
                                                          .calo +
                                                      state
                                                          .weeklyMenu
                                                          .menu[page]
                                                          .listSnack[0]
                                                          .calo +
                                                      state
                                                          .weeklyMenu
                                                          .menu[page]
                                                          .listSnack[1]
                                                          .calo)
                                                  .toString() +
                                              " Calories",
                                          style: TextStyle(fontSize: 17)),
                                    ],
                                  )
                                : state.weeklyMenu.menu[page].listSnack
                                            .length ==
                                        3
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              "/" +
                                                  (state
                                                              .weeklyMenu
                                                              .menu[page]
                                                              .listWeeklyRecipe[
                                                                  2]
                                                              .calo +
                                                          state
                                                              .weeklyMenu
                                                              .menu[page]
                                                              .listSnack[0]
                                                              .calo +
                                                          state
                                                              .weeklyMenu
                                                              .menu[page]
                                                              .listSnack[1]
                                                              .calo +
                                                          state
                                                              .weeklyMenu
                                                              .menu[page]
                                                              .listSnack[2]
                                                              .calo)
                                                      .toString() +
                                                  " Calories",
                                              style: TextStyle(fontSize: 17)),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              "/" +
                                                  state.weeklyMenu.menu[page]
                                                      .listWeeklyRecipe[0].calo
                                                      .toString() +
                                                  " Calories",
                                              style: TextStyle(fontSize: 17)),
                                        ],
                                      ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Stack(children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width / 3.5,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(state
                                        .weeklyMenu
                                        .menu[page]
                                        .listWeeklyRecipe[2]
                                        .recipeThumbnail),
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
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width / 3.5,
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
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    width:
                                        MediaQuery.of(context).size.width / 3.5,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.weeklyMenu.menu[page]
                                              .listWeeklyRecipe[2].recipeTitle,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 12),
                                          overflow: TextOverflow.clip,
                                        ),
                                        Text(
                                          "Main Dish",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                          overflow: TextOverflow.clip,
                                        ),
                                        Text(
                                          state.weeklyMenu.menu[page]
                                                  .listWeeklyRecipe[2].calo
                                                  .toString() +
                                              " Calories",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                            SizedBox(
                              width: 10,
                            ),
                            state.weeklyMenu.menu[page].listSnack.length >= 2
                                ? Stack(children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.175,
                                      width: MediaQuery.of(context).size.width /
                                          3.5,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(state
                                              .weeklyMenu
                                              .menu[page]
                                              .listSnack[1]
                                              .recipeThumbnail),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 0.0,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.175,
                                      width: MediaQuery.of(context).size.width /
                                          3.5,
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 6, 10, 10),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.175,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.5,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state.weeklyMenu.menu[page]
                                                    .listSnack[1].recipeTitle
                                                    .trim(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 12),
                                                overflow: TextOverflow.clip,
                                              ),
                                              Text(
                                                "Side dishes / snacks",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                                overflow: TextOverflow.clip,
                                              ),
                                              Text(
                                                state.weeklyMenu.menu[page]
                                                        .listSnack[1].calo
                                                        .toString() +
                                                    " Calories",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ])
                                : SizedBox(),
                            SizedBox(
                              width: 10,
                            ),
                            state.weeklyMenu.menu[page].listSnack.length == 3
                                ? Stack(children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.175,
                                      width: MediaQuery.of(context).size.width /
                                          3.5,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(state
                                              .weeklyMenu
                                              .menu[page]
                                              .listSnack[2]
                                              .recipeThumbnail),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 0.0,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.175,
                                      width: MediaQuery.of(context).size.width /
                                          3.5,
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 6, 10, 10),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.175,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.5,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state.weeklyMenu.menu[page]
                                                    .listSnack[2].recipeTitle
                                                    .trim(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 12),
                                                overflow: TextOverflow.clip,
                                              ),
                                              Text(
                                                "Side dishes / snacks",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                                overflow: TextOverflow.clip,
                                              ),
                                              Text(
                                                state.weeklyMenu.menu[page]
                                                        .listSnack[2].calo
                                                        .toString() +
                                                    " Calories",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ])
                                : SizedBox(),
                          ],
                        ),
                      ],
                    ),
                  )),
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width,
                    color: kPrimaryButtonColor2,
                    child: Text(
                      state.weeklyMenu.menu[page].listSnack.length == 0
                          ? "Total calories: " +
                              (state.weeklyMenu.menu[page].listWeeklyRecipe[0]
                                          .calo +
                                      state.weeklyMenu.menu[page]
                                          .listWeeklyRecipe[1].calo +
                                      state.weeklyMenu.menu[page]
                                          .listWeeklyRecipe[2].calo)
                                  .toString()
                          : state.weeklyMenu.menu[page].listSnack.length == 1
                              ? "Total calories: " +
                                  (state.weeklyMenu.menu[page]
                                              .listWeeklyRecipe[0].calo +
                                          state.weeklyMenu.menu[page]
                                              .listWeeklyRecipe[1].calo +
                                          state.weeklyMenu.menu[page]
                                              .listWeeklyRecipe[2].calo +
                                          state.weeklyMenu.menu[page]
                                              .listSnack[0].calo)
                                      .toString()
                              : "Total calories: " +
                                  (state.weeklyMenu.menu[page]
                                              .listWeeklyRecipe[0].calo +
                                          state.weeklyMenu.menu[page]
                                              .listWeeklyRecipe[1].calo +
                                          state.weeklyMenu.menu[page]
                                              .listWeeklyRecipe[2].calo +
                                          state.weeklyMenu.menu[page]
                                              .listSnack[0].calo +
                                          state.weeklyMenu.menu[page]
                                              .listSnack[1].calo)
                                      .toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ]),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: kPrimaryButtonColor),
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width / 3,
                      child: TextButton(
                          onPressed: () {
                            _displayTextInputDialog(context);
                          },
                          child: Text(
                            "Generate",
                            style: TextStyle(
                                color: kPrimaryButtonTextColor,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: state.isNew != false
                              ? kPrimaryButtonColor3
                              : Colors.black12),
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width / 3,
                      child: TextButton(
                        onPressed: () {
                          _WeeklyMenuBloc.add(WeeklyMenuFetchEvent());
                        },
                        child: Text(
                          "Load",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: state.isNew != false
                              ? kPrimaryButtonColor3
                              : Colors.black12),
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width / 3,
                      child: TextButton(
                          onPressed: () {
                            state.isNew != false
                                ? _WeeklyMenuBloc.add(
                                    WeeklyMenuAddEvent(state.weeklyMenu))
                                : null;
                          },
                          child: Text(
                            "Save",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        if (state is SaveWeeklyMenuStateSuccess) {
          print("ra ne");
          int val = 1;
          Future<void> _displayTextInputDialog(BuildContext context) async {
            return showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Number of Recipe per day'),
                    content: Container(
                      height: MediaQuery.of(context).size.height / 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(60),
                                  ),
                                  color: kPrimaryButtonColor),
                              child: TextButton(
                                  onPressed: () {
                                    _WeeklyMenuBloc.add(
                                        WeeklyMenuGenerateEvent(3));
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "3 Recipes",
                                    style: TextStyle(color: Colors.white),
                                  ))),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(60),
                                  ),
                                  color: kPrimaryButtonColor),
                              child: TextButton(
                                  onPressed: () {
                                    _WeeklyMenuBloc.add(
                                        WeeklyMenuGenerateEvent(4));
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "4 Recipes",
                                    style: TextStyle(color: Colors.white),
                                  ))),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(60),
                                  ),
                                  color: kPrimaryButtonColor),
                              child: TextButton(
                                  onPressed: () {
                                    _WeeklyMenuBloc.add(
                                        WeeklyMenuGenerateEvent(5));
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "5 Recipes",
                                    style: TextStyle(color: Colors.white),
                                  ))),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(60),
                                  ),
                                  color: kPrimaryButtonColor),
                              child: TextButton(
                                  onPressed: () {
                                    _WeeklyMenuBloc.add(
                                        WeeklyMenuGenerateEvent(6));
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "6 Recipes",
                                    style: TextStyle(color: Colors.white),
                                  ))),
                        ],
                      ),
                    ),
                  );
                });
          }

          return Column(
            children: [
              Expanded(
                child: Column(children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          //                   <--- left side
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Row(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: IconButton(
                                onPressed: () {
                                  if (page > 0) {
                                    setState(() {
                                      page--;
                                    });
                                  } else if (page == 0) {
                                    setState(() {
                                      page = page;
                                    });
                                  }
                                },
                                icon: Icon(
                                  Icons.keyboard_arrow_left,
                                  size: MediaQuery.of(context).size.width * 0.1,
                                ))),
                        Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              DateFormat('dd-MM-yyyy').format(
                                state.weeklyMenu.menu[page].date,
                              ),
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.075),
                            )),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: IconButton(
                                onPressed: () {
                                  if (page < 6) {
                                    setState(() {
                                      page++;
                                    });
                                  } else if (page == 6) {
                                    setState(() {
                                      page = page;
                                    });
                                  }
                                },
                                icon: Icon(
                                  Icons.keyboard_arrow_right,
                                  size: MediaQuery.of(context).size.width * 0.1,
                                ))),
                      ],
                    ),
                  ),
                  Expanded(
                    // height: MediaQuery.of(context).size.height * 0.7,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(10),
                        child: ListView(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Breakfast",
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        "/" +
                                            state.weeklyMenu.menu[page]
                                                .listWeeklyRecipe[0].calo
                                                .toString() +
                                            " Calories",
                                        style: TextStyle(fontSize: 17)),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Stack(children: [
                                  Container(
                                    height:
                                    MediaQuery.of(context).size.height * 0.2,
                                    width: MediaQuery.of(context).size.width / 3.5,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(state
                                            .weeklyMenu
                                            .menu[page]
                                            .listWeeklyRecipe[0]
                                            .recipeThumbnail),
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
                                    height:
                                    MediaQuery.of(context).size.height * 0.2,
                                    width: MediaQuery.of(context).size.width / 3.5,
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
                                        height: MediaQuery.of(context).size.height *
                                            0.2,
                                        width:
                                        MediaQuery.of(context).size.width / 3.5,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              state.weeklyMenu.menu[page]
                                                  .listWeeklyRecipe[0].recipeTitle,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 12),
                                              overflow: TextOverflow.clip,
                                            ),
                                            Text(
                                              "Main Dish",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                              overflow: TextOverflow.clip,
                                            ),
                                            Text(
                                              state.weeklyMenu.menu[page]
                                                  .listWeeklyRecipe[0].calo
                                                  .toString() +
                                                  " Calories",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  "Lunch",
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                state.weeklyMenu.menu[page].listSnack.length >= 1
                                    ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        "/" +
                                            (state
                                                .weeklyMenu
                                                .menu[page]
                                                .listWeeklyRecipe[1]
                                                .calo +
                                                state
                                                    .weeklyMenu
                                                    .menu[page]
                                                    .listSnack[0]
                                                    .calo)
                                                .toString() +
                                            " Calories",
                                        style: TextStyle(fontSize: 17)),
                                  ],
                                )
                                    : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        "/" +
                                            state.weeklyMenu.menu[page]
                                                .listWeeklyRecipe[0].calo
                                                .toString() +
                                            " Calories",
                                        style: TextStyle(fontSize: 17)),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Stack(children: [
                                  Container(
                                    height:
                                    MediaQuery.of(context).size.height * 0.2,
                                    width: MediaQuery.of(context).size.width / 3.5,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(state
                                            .weeklyMenu
                                            .menu[page]
                                            .listWeeklyRecipe[1]
                                            .recipeThumbnail),
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
                                    height:
                                    MediaQuery.of(context).size.height * 0.2,
                                    width: MediaQuery.of(context).size.width / 3.5,
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
                                        height: MediaQuery.of(context).size.height *
                                            0.2,
                                        width:
                                        MediaQuery.of(context).size.width / 3.5,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              state.weeklyMenu.menu[page]
                                                  .listWeeklyRecipe[1].recipeTitle
                                                  .trim(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 12),
                                              overflow: TextOverflow.clip,
                                            ),
                                            Text(
                                              "Main Dish",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                              overflow: TextOverflow.clip,
                                            ),
                                            Text(
                                              state.weeklyMenu.menu[page]
                                                  .listWeeklyRecipe[1].calo
                                                  .toString() +
                                                  " Calories",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                                SizedBox(
                                  width: 10,
                                ),
                                state.weeklyMenu.menu[page].listSnack.length >= 1
                                    ? Stack(children: [
                                  Container(
                                    height:
                                    MediaQuery.of(context).size.height *
                                        0.175,
                                    width: MediaQuery.of(context).size.width /
                                        3.5,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(state
                                            .weeklyMenu
                                            .menu[page]
                                            .listSnack[0]
                                            .recipeThumbnail),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 0.0,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height:
                                    MediaQuery.of(context).size.height *
                                        0.175,
                                    width: MediaQuery.of(context).size.width /
                                        3.5,
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 6, 10, 10),
                                        height: MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.175,
                                        width: MediaQuery.of(context)
                                            .size
                                            .width /
                                            3.5,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              state.weeklyMenu.menu[page]
                                                  .listSnack[0].recipeTitle
                                                  .trim(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 12),
                                              overflow: TextOverflow.clip,
                                            ),
                                            Text(
                                              "Side dishes / snacks",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                              overflow: TextOverflow.clip,
                                            ),
                                            Text(
                                              state.weeklyMenu.menu[page]
                                                  .listSnack[0].calo
                                                  .toString() +
                                                  " Calories",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ])
                                    : SizedBox(),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Dinner",
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                state.weeklyMenu.menu[page].listSnack.length == 2
                                    ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        "/" +
                                            (state
                                                .weeklyMenu
                                                .menu[page]
                                                .listWeeklyRecipe[2]
                                                .calo +
                                                state
                                                    .weeklyMenu
                                                    .menu[page]
                                                    .listSnack[0]
                                                    .calo +
                                                state
                                                    .weeklyMenu
                                                    .menu[page]
                                                    .listSnack[1]
                                                    .calo)
                                                .toString() +
                                            " Calories",
                                        style: TextStyle(fontSize: 17)),
                                  ],
                                )
                                    : state.weeklyMenu.menu[page].listSnack
                                    .length ==
                                    3
                                    ? Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        "/" +
                                            (state
                                                .weeklyMenu
                                                .menu[page]
                                                .listWeeklyRecipe[
                                            2]
                                                .calo +
                                                state
                                                    .weeklyMenu
                                                    .menu[page]
                                                    .listSnack[0]
                                                    .calo +
                                                state
                                                    .weeklyMenu
                                                    .menu[page]
                                                    .listSnack[1]
                                                    .calo +
                                                state
                                                    .weeklyMenu
                                                    .menu[page]
                                                    .listSnack[2]
                                                    .calo)
                                                .toString() +
                                            " Calories",
                                        style: TextStyle(fontSize: 17)),
                                  ],
                                )
                                    : Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        "/" +
                                            state.weeklyMenu.menu[page]
                                                .listWeeklyRecipe[0].calo
                                                .toString() +
                                            " Calories",
                                        style: TextStyle(fontSize: 17)),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Stack(children: [
                                  Container(
                                    height:
                                    MediaQuery.of(context).size.height * 0.2,
                                    width: MediaQuery.of(context).size.width / 3.5,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(state
                                            .weeklyMenu
                                            .menu[page]
                                            .listWeeklyRecipe[2]
                                            .recipeThumbnail),
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
                                    height:
                                    MediaQuery.of(context).size.height * 0.2,
                                    width: MediaQuery.of(context).size.width / 3.5,
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
                                        height: MediaQuery.of(context).size.height *
                                            0.2,
                                        width:
                                        MediaQuery.of(context).size.width / 3.5,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              state.weeklyMenu.menu[page]
                                                  .listWeeklyRecipe[2].recipeTitle,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 12),
                                              overflow: TextOverflow.clip,
                                            ),
                                            Text(
                                              "Main Dish",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                              overflow: TextOverflow.clip,
                                            ),
                                            Text(
                                              state.weeklyMenu.menu[page]
                                                  .listWeeklyRecipe[2].calo
                                                  .toString() +
                                                  " Calories",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                                SizedBox(
                                  width: 10,
                                ),
                                state.weeklyMenu.menu[page].listSnack.length >= 2
                                    ? Stack(children: [
                                  Container(
                                    height:
                                    MediaQuery.of(context).size.height *
                                        0.175,
                                    width: MediaQuery.of(context).size.width /
                                        3.5,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(state
                                            .weeklyMenu
                                            .menu[page]
                                            .listSnack[1]
                                            .recipeThumbnail),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 0.0,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height:
                                    MediaQuery.of(context).size.height *
                                        0.175,
                                    width: MediaQuery.of(context).size.width /
                                        3.5,
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 6, 10, 10),
                                        height: MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.175,
                                        width: MediaQuery.of(context)
                                            .size
                                            .width /
                                            3.5,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              state.weeklyMenu.menu[page]
                                                  .listSnack[1].recipeTitle
                                                  .trim(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 12),
                                              overflow: TextOverflow.clip,
                                            ),
                                            Text(
                                              "Side dishes / snacks",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                              overflow: TextOverflow.clip,
                                            ),
                                            Text(
                                              state.weeklyMenu.menu[page]
                                                  .listSnack[1].calo
                                                  .toString() +
                                                  " Calories",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ])
                                    : SizedBox(),
                                SizedBox(
                                  width: 10,
                                ),
                                state.weeklyMenu.menu[page].listSnack.length == 3
                                    ? Stack(children: [
                                  Container(
                                    height:
                                    MediaQuery.of(context).size.height *
                                        0.175,
                                    width: MediaQuery.of(context).size.width /
                                        3.5,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(state
                                            .weeklyMenu
                                            .menu[page]
                                            .listSnack[2]
                                            .recipeThumbnail),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 0.0,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height:
                                    MediaQuery.of(context).size.height *
                                        0.175,
                                    width: MediaQuery.of(context).size.width /
                                        3.5,
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 6, 10, 10),
                                        height: MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.175,
                                        width: MediaQuery.of(context)
                                            .size
                                            .width /
                                            3.5,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              state.weeklyMenu.menu[page]
                                                  .listSnack[2].recipeTitle
                                                  .trim(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 12),
                                              overflow: TextOverflow.clip,
                                            ),
                                            Text(
                                              "Side dishes / snacks",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                              overflow: TextOverflow.clip,
                                            ),
                                            Text(
                                              state.weeklyMenu.menu[page]
                                                  .listSnack[2].calo
                                                  .toString() +
                                                  " Calories",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ])
                                    : SizedBox(),
                              ],
                            ),
                          ],
                        ),
                      )),
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width,
                    color: kPrimaryButtonColor2,
                    child: Text(
                      state.weeklyMenu.menu[page].listSnack.length == 0
                          ? "Total calories: " +
                          (state.weeklyMenu.menu[page].listWeeklyRecipe[0]
                              .calo +
                              state.weeklyMenu.menu[page]
                                  .listWeeklyRecipe[1].calo +
                              state.weeklyMenu.menu[page]
                                  .listWeeklyRecipe[2].calo)
                              .toString()
                          : state.weeklyMenu.menu[page].listSnack.length == 1
                          ? "Total calories: " +
                          (state.weeklyMenu.menu[page]
                              .listWeeklyRecipe[0].calo +
                              state.weeklyMenu.menu[page]
                                  .listWeeklyRecipe[1].calo +
                              state.weeklyMenu.menu[page]
                                  .listWeeklyRecipe[2].calo +
                              state.weeklyMenu.menu[page]
                                  .listSnack[0].calo)
                              .toString()
                          : "Total calories: " +
                          (state.weeklyMenu.menu[page]
                              .listWeeklyRecipe[0].calo +
                              state.weeklyMenu.menu[page]
                                  .listWeeklyRecipe[1].calo +
                              state.weeklyMenu.menu[page]
                                  .listWeeklyRecipe[2].calo +
                              state.weeklyMenu.menu[page]
                                  .listSnack[0].calo +
                              state.weeklyMenu.menu[page]
                                  .listSnack[1].calo)
                              .toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ]),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: kPrimaryButtonColor),
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width / 3,
                      child: TextButton(
                          onPressed: () {
                            _displayTextInputDialog(context);
                          },
                          child: Text(
                            "Generate",
                            style: TextStyle(
                                color: kPrimaryButtonTextColor,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: state.isNew != false
                              ? kPrimaryButtonColor3
                              : Colors.black12),
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width / 3,
                      child: TextButton(
                        onPressed: () {
                          _WeeklyMenuBloc.add(WeeklyMenuFetchEvent());
                        },
                        child: Text(
                          "Load",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: state.isNew != false
                              ? kPrimaryButtonColor3
                              : Colors.black12),
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width / 3,
                      child: TextButton(
                          onPressed: () {
                            state.isNew != false
                                ? _WeeklyMenuBloc.add(
                                WeeklyMenuAddEvent(state.weeklyMenu))
                                : null;
                          },
                          child: Text(
                            "Save",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        if (state is WeeklyMenuStateLackInfo) {
          return Center(
            child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider(
                                create: (context) => CheckNutritionBloc()
                                  ..add(CheckNutritionFetchEvent()),
                                child: CheckNutritionScreen(),
                              )));
                },
                child: Text(
                    "Complete your health profile to receive tailored meal plans")),
          );
        }
        if (state is WeeklyMenuStateEmpty) {
          Future<void> _displayTextInputDialog(BuildContext context) async {
            return showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Number of Recipe per day'),
                    content: Container(
                      height: MediaQuery.of(context).size.height / 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(60),
                                  ),
                                  color: kPrimaryButtonColor),
                              child: TextButton(
                                  onPressed: () {
                                    _WeeklyMenuBloc.add(
                                        WeeklyMenuGenerateEvent(3));
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "3 Recipes",
                                    style: TextStyle(color: Colors.white),
                                  ))),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(60),
                                  ),
                                  color: kPrimaryButtonColor),
                              child: TextButton(
                                  onPressed: () {
                                    _WeeklyMenuBloc.add(
                                        WeeklyMenuGenerateEvent(4));
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "4 Recipes",
                                    style: TextStyle(color: Colors.white),
                                  ))),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(60),
                                  ),
                                  color: kPrimaryButtonColor),
                              child: TextButton(
                                  onPressed: () {
                                    _WeeklyMenuBloc.add(
                                        WeeklyMenuGenerateEvent(5));
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "5 Recipes",
                                    style: TextStyle(color: Colors.white),
                                  ))),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(60),
                                  ),
                                  color: kPrimaryButtonColor),
                              child: TextButton(
                                  onPressed: () {
                                    _WeeklyMenuBloc.add(
                                        WeeklyMenuGenerateEvent(6));
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "6 Recipes",
                                    style: TextStyle(color: Colors.white),
                                  ))),
                        ],
                      ),
                    ),
                  );
                });
          }

          return Column(
            children: [
              Expanded(
                  child:
                      Center(child: Text("Let's make your first Wekkly Menu"))),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: kPrimaryButtonColor),
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width / 3,
                      child: TextButton(
                          onPressed: () {
                            _displayTextInputDialog(context);
                          },
                          child: Text(
                            "Generate",
                            style: TextStyle(
                                color: kPrimaryButtonTextColor,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    Container(
                      decoration: BoxDecoration(color: Colors.black12),
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width / 3,
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Load",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                    ),
                    Container(
                      decoration: BoxDecoration(color: Colors.black12),
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width / 3,
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Save",
                            style: TextStyle(
                                color: kPrimaryButtonTextColor,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        if (state is WeeklyMenuStateFailure) {
          {
            final _heightController = TextEditingController();
            final _weightController = TextEditingController();
            final _typeWorkoutController = TextEditingController();
            final _genderController = TextEditingController();
            Nutrition? nutri;
            List<String> workRoutine = [
              'Low intensity - office work or similar, no workout.',
              'Average intensity - manual labor and/or semi-regular workouts.',
              'High intensity - hobbyist athlete and/or daily workouts.',
              'Extreme intensity - professional athlete.'
            ];

            calculateAge(DateTime birthDate) {
              DateTime currentDate = DateTime.now();
              int age = currentDate.year - birthDate.year;
              int month1 = currentDate.month;
              int month2 = birthDate.month;
              if (month2 > month1) {
                age--;
              } else if (month1 == month2) {
                int day1 = currentDate.day;
                int day2 = birthDate.day;
                if (day2 > day1) {
                  age--;
                }
              }
              return age;
            }

            _weightController.text = state.user.weight.toString();
            _weightController.selection = TextSelection.fromPosition(
                TextPosition(offset: _weightController.text.length));
            _heightController.text = '${state.user.height}';
            _heightController.selection = TextSelection.fromPosition(
                TextPosition(offset: _heightController.text.length));
            _genderController.text = state.user.gender.toString();
            _genderController.selection = TextSelection.fromPosition(
                TextPosition(offset: _genderController.text.length));
            _typeWorkoutController.text = state.user.workoutRoutine.toString();
            _typeWorkoutController.selection = TextSelection.fromPosition(
                TextPosition(offset: _typeWorkoutController.text.length));
            var format = DateFormat('dd-MM-yyyy');
            DateTime selectedDate = state.user.birthDate;
            final _birthDayController = TextEditingController(
                text: format.format(state.user.birthDate));
            _selectDate(BuildContext context) async {
              DateTime? newSelectedDate = await showDatePicker(
                context: context,
                initialDate:
                    selectedDate != null ? selectedDate : DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2040),
              );

              if (newSelectedDate != null) {
                selectedDate = newSelectedDate;
                _birthDayController
                  ..text =
                      // DateFormat.yMMMd().format(_selectedDate)
                      format.format(selectedDate)
                  ..selection = TextSelection.fromPosition(TextPosition(
                      offset: _birthDayController.text.length,
                      affinity: TextAffinity.upstream));
              }
            }

            int age = calculateAge(selectedDate);
            return Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Text(
                    "Input These Info To Generate Weekly Menu",
                    style:
                        TextStyle(fontSize: 17.5, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Height',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey.shade200))),
                    child: TextField(
                      controller: _heightController,
                      onSubmitted: (value) {
                        setState(() {
                          state.user.height = int.parse(value);
                          // _heightController.text = value;
                          print(state.user.weight.toString());
                        });
                      },
                      decoration: InputDecoration(
                          hintText: "Input height",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Weight',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey.shade200))),
                    child: TextField(
                      controller: _weightController,
                      onSubmitted: (value) {
                        setState(() {
                          state.user.weight = double.parse(value);
                          // _heightController.text = value;
                          print(state.user.weight.toString());
                        });
                      },
                      decoration: InputDecoration(
                          hintText: "Input weight",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Gender',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey.shade200))),
                    child: TextField(
                      controller: _genderController,
                      decoration: InputDecoration(
                          hintText: "Input gender",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Workout Routine',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: state.user.workoutRoutine != 0
                                ? workRoutine[state.user.workoutRoutine - 1]
                                : workRoutine[0],
                            icon: Icon(Icons.keyboard_arrow_down),
                            items: workRoutine.map((String items) {
                              return DropdownMenuItem(
                                  value: items,
                                  child: Container(
                                      color: Colors.white,
                                      margin: EdgeInsets.only(left: 15),
                                      width: MediaQuery.of(context).size.width *
                                          0.76,
                                      child: Text(
                                        items.toString(),
                                        overflow: TextOverflow.ellipsis,
                                      )));
                            }).toList(),
                            onChanged: (value) => setState(() {
                              state.user.workoutRoutine =
                                  workRoutine.indexOf(value!) + 1;
                            }),
                          ),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(width: 1.0, color: Colors.white70)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Age',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: TextField(
                            focusNode: AlwaysDisabledFocusNode(),
                            readOnly: true,
                            controller: _birthDayController,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 17.0,
                            ),
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              hintText: format.format(selectedDate),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                            onTap: () {
                              _selectDate(context);
                            },
                            maxLines: 1,
                            // overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Divider(),
                        Container(
                          child: Text(
                            "Age: " + age.toString(),
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.black54,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          color: Colors.lightBlueAccent),
                      child: TextButton(
                          onPressed: () async {
                            _WeeklyMenuBloc.add(WeeklyMenuUpdateInfoEvent(
                                state.user,
                                int.parse(_heightController.text),
                                double.parse(_weightController.text),
                                int.parse(_typeWorkoutController.text),
                                selectedDate,
                                _genderController.text));
                          },
                          child: Text(
                            "Create Weekly menu",
                            style: TextStyle(color: Colors.white),
                          ))),
                ],
              ),
            );
          }
        }
        return SizedBox();
      }),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
