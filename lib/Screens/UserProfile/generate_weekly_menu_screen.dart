import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vegetarian/Screens/MainScreen/main_screen.dart';
import 'package:vegetarian/Screens/Recipes/recipe_screen.dart';
import 'package:vegetarian/blocs/home_blocs.dart';
import 'package:vegetarian/blocs/recipe_blocs.dart';
import 'package:vegetarian/blocs/weekly_menu_bloc.dart';
import 'package:vegetarian/events/home_events.dart';
import 'package:vegetarian/events/recipe_event.dart';
import 'package:vegetarian/events/weekly_menu_event.dart';
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
        title: Text('Generate Weekly Menu'),
        backgroundColor: Colors.green[300],
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            BlocConsumer<WeeklyMenuBloc, WeeklyMenuState>(
              listener: (context, state) {
                if(state is SaveWeeklyMenuStateSuccess){
                  CoolAlert.show(
                    context: context,
                    type: CoolAlertType.success,
                    text: "Save menu successful!",
                    onConfirmBtnTap: (){
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => BlocProvider(
                        create: (context) =>
                        HomeBloc()..add(HomeFetchEvent()),
                        child: MyHomePage(token: '123',
                        ),
                      )));
                    },
                  );
                }
              },
                builder: (context, state) {
              if (state is WeeklyMenuStateSuccess) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Column(
                    children: [
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
                                      size: MediaQuery.of(context).size.width *
                                          0.1,
                                    ))),
                            Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(
                                  DateFormat('dd-MM-yyyy').format(
                                    state.weeklyMenu.menu[page].date,
                                  ),
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
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
                                      size: MediaQuery.of(context).size.width *
                                          0.1,
                                    ))),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: ListView.separated(
                          physics: ClampingScrollPhysics(),
                          itemCount: (state.weeklyMenu != null)
                              ? state
                                  .weeklyMenu.menu[page].listWeeklyRecipe.length
                              : 0,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                            create: (context) => RecipeBloc()
                                              ..add(RecipeFetchEvent(state
                                                  .weeklyMenu
                                                  .menu[page]
                                                  .listWeeklyRecipe[index]
                                                  .recipeId,"weeklymenu")),
                                            child: RecipeScreen(),
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
                                          image: NetworkImage(state
                                              .weeklyMenu
                                              .menu[page]
                                              .listWeeklyRecipe[index]
                                              .recipeThumbnail),
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
                                          Text(
                                              state
                                                  .weeklyMenu
                                                  .menu[page]
                                                  .listWeeklyRecipe[index]
                                                  .recipeTitle,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.fade),
                                          Text(
                                            state
                                                .weeklyMenu
                                                .menu[page]
                                                .listWeeklyRecipe[index]
                                                .mealOfDay,
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                            state.weeklyMenu.menu[page]
                                                .listWeeklyRecipe[index].calo
                                                .toString(),
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
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.lightGreen,
                        child: Text(
                          "Total calories: " +
                              (state.weeklyMenu.menu[page].listWeeklyRecipe[0]
                                          .calo +
                                      state.weeklyMenu.menu[page]
                                          .listWeeklyRecipe[1].calo +
                                      state.weeklyMenu.menu[page]
                                          .listWeeklyRecipe[2].calo)
                                  .toString(),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width,
                        child: TextButton(onPressed: (){

                          _WeeklyMenuBloc.add(WeeklyMenuAddEvent(
                            state.weeklyMenu
                          ));
                        }, child: Text("Save Menu")),
                      ),
                    ],
                  ),
                );
              }
              return SizedBox();
            }),

          ],
        ),
      ),
    );
  }
}
