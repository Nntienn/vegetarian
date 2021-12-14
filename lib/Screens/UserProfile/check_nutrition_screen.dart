import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vegetarian/Screens/MainScreen/main_screen.dart';
import 'package:vegetarian/Screens/UserProfile/generate_weekly_menu_screen.dart';
import 'package:vegetarian/blocs/check_nutrition_bloc.dart';
import 'package:vegetarian/blocs/home_blocs.dart';
import 'package:vegetarian/blocs/weekly_menu_bloc.dart';
import 'package:vegetarian/events/check_nutrition_events.dart';
import 'package:vegetarian/events/home_events.dart';
import 'package:vegetarian/events/weekly_menu_event.dart';
import 'package:vegetarian/models/recipe.dart';
import 'package:vegetarian/states/check_nutrition_state.dart';

class CheckNutritionScreen extends StatefulWidget {
  const CheckNutritionScreen({Key? key}) : super(key: key);

  @override
  State<CheckNutritionScreen> createState() => _CheckNutritionState();
}

class _CheckNutritionState extends State<CheckNutritionScreen> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _typeWorkoutController = TextEditingController();
  final _genderController = TextEditingController();
  Nutrition? nutri;
  late CheckNutritionBloc _CheckNutritionBloc;
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

  @override
  void initState() {
    super.initState();
    _CheckNutritionBloc = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Check Your Nutrition"),
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
      ),
      body: Center(
          child: BlocConsumer<CheckNutritionBloc, CheckNutritionState>(
              listener: (context, state) {
        if (state is CheckNutritionStateSuccess) {
          nutri = state.nutri;
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Daily Needed Nutrition'),
                  content: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      children: [
                        Text(
                          "Daily Nutrition",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Divider(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Protein: " +
                                  state.nutri.protein.toStringAsFixed(2),
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Fat: " + state.nutri.fat.toStringAsFixed(2),
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Carb: " +
                                  state.nutri.carb.toStringAsFixed(2),
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Calories: " +
                                  state.nutri.calories.toStringAsFixed(2),
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      color: Colors.green,
                      textColor: Colors.white,
                      child: Text('Create Weekly Menu'),
                      onPressed: () {Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) =>
                                WeeklyMenuBloc()
                                  ..add(WeeklyMenuFetchEvent()),
                                child: WeeklyMenuScreen(),
                              )));},
                    ),
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

                  ],
                );
              });
        }
        // do stuff here based on BlocA's state
      }, builder: (context, state) {
        if (state is CheckNutritionStateInitial) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is CheckNutritionStateFetchSuccess) {
          _weightController.text = state.user.weight.toString();
          _weightController.selection = TextSelection.fromPosition(
              TextPosition(offset: _weightController.text.length));
          _heightController.text = state.user.height.toString();
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
          final _birthDayController =
              TextEditingController(text: format.format(state.user.birthDate));
          _selectDate(BuildContext context) async {
            DateTime? newSelectedDate = await showDatePicker(
              context: context,
              initialDate: selectedDate != null ? selectedDate : DateTime.now(),
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
              children: <Widget>[
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
                    keyboardType: TextInputType.number,
                    controller: _heightController,
                    onChanged: (value){
                      setState(() {
                        // _heightController.text = value;
                        state.user.height = int.parse(value);
                        print(state.user.height);
                      });
                      print(value);
                    },
                    // onSubmitted: (value) {
                    //   setState(() {
                    //     state.user.height = int.parse(value);
                    //     // _heightController.text = value;
                    //     print(state.user.weight.toString());
                    //   });
                    // },
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
                    keyboardType: TextInputType.number,
                    onChanged: (value){
                      // setState(() {
                        state.user.weight = double.parse(value);
                        print(state.user.weight);
                      // });
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
                    onSubmitted: (value){
                      setState(() {
                        state.user.gender = value;
                      });
                    },
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
                // Container(
                //   padding: EdgeInsets.all(10),
                //   decoration: BoxDecoration(
                //       border: Border(
                //           bottom: BorderSide(color: Colors.grey.shade200))),
                //   child: TextField(
                //     controller: _typeWorkoutController,
                //     decoration: InputDecoration(
                //         hintText: "Your workout routine",
                //         hintStyle: TextStyle(color: Colors.grey),
                //         border: InputBorder.none),
                //   ),
                // ),
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
                            age = calculateAge(selectedDate);
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
                          _CheckNutritionBloc.add(CheckNutritionEvent(
                              state.user,
                              int.parse(_heightController.text),
                              double.parse(_weightController.text),
                              int.parse(_typeWorkoutController.text),
                              selectedDate,
                              _genderController.text));
                        },
                        child: Text(
                          "Check Daily Needed Nutrion",
                          style: TextStyle(color: Colors.white),
                        ))),
              ],
            ),
          );
        }
        if (state is CheckNutritionStateFailure) {
          return Center(
            child: Text("ngu"),
          );
        }
        if(state is CheckNutritionStateSuccess){
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
          final _birthDayController =
          TextEditingController(text: format.format(state.user.birthDate));
          _selectDate(BuildContext context) async {
            DateTime? newSelectedDate = await showDatePicker(
              context: context,
              initialDate: selectedDate != null ? selectedDate : DateTime.now(),
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
              children: <Widget>[
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
                    onChanged: (value){
                      setState(() {
                        // _heightController.text = value;
                        state.user.height = int.parse(value);
                        print(state.user.height);
                      });
                      print(value);
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
                    onChanged: (value){
                      // setState(() {
                      state.user.weight = double.parse(value);
                      print(state.user.weight);
                      // });
                    },
                    // onSubmitted: (value) {
                    //   setState(() {
                    //     state.user.weight = double.parse(value);
                    //     // _heightController.text = value;
                    //     print(state.user.weight.toString());
                    //   });
                    // },
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
                // Container(
                //   padding: EdgeInsets.all(10),
                //   decoration: BoxDecoration(
                //       border: Border(
                //           bottom: BorderSide(color: Colors.grey.shade200))),
                //   child: TextField(
                //     controller: _typeWorkoutController,
                //     decoration: InputDecoration(
                //         hintText: "Your workout routine",
                //         hintStyle: TextStyle(color: Colors.grey),
                //         border: InputBorder.none),
                //   ),
                // ),
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
                            setState(() {
                              _selectDate(context);
                              int age = calculateAge(selectedDate);
                            });

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
                          _CheckNutritionBloc.add(CheckNutritionEvent(
                              state.user,
                              int.parse(_heightController.text),
                              double.parse(_weightController.text),
                              int.parse(_typeWorkoutController.text),
                              selectedDate,
                              _genderController.text));
                        },
                        child: Text(
                          "Check Daily Needed Nutrion",
                          style: TextStyle(color: Colors.white),
                        ))),
              ],
            ),
          );
        }
        return Center(
          child: Text("System Crash"),
        );
      })), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
