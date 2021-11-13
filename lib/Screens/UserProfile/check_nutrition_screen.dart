import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vegetarian/blocs/check_nutrition_bloc.dart';
import 'package:vegetarian/events/check_nutrition_events.dart';
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
      ),
      body: Center(
          child: BlocConsumer<CheckNutritionBloc, CheckNutritionState>(
              listener: (context, state) {

        // do stuff here based on BlocA's state
      }, builder: (context, state) {
        if (state is CheckNutritionStateInitial) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is CheckNutritionStateFetchSuccess) {
          _weightController.text = state.user.weight.toString();
          _weightController.selection = TextSelection.fromPosition(TextPosition(offset: _weightController.text.length));
          _heightController.text = '${state.user.height}';
          _heightController.selection = TextSelection.fromPosition(TextPosition(offset: _heightController.text.length));
          _genderController.text = state.user.gender.toString();
          _genderController.selection = TextSelection.fromPosition(TextPosition(offset: _genderController.text.length));
          _typeWorkoutController.text = state.user.workoutRoutine.toString();
          _typeWorkoutController.selection = TextSelection.fromPosition(TextPosition(offset: _typeWorkoutController.text.length));
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
                    onSubmitted: (value){
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
                    onSubmitted: (value){
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
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey.shade200))),
                  child: TextField(
                    controller: _typeWorkoutController,
                    decoration: InputDecoration(
                        hintText: "Your workout routine",
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
        }if(state is CheckNutritionStateFailure){
          return Center(
            child: Text("ngu"),
          );
        }
        if (state is CheckNutritionStateSuccess) {
          nutri = state.nutri;
          return Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black12, width: 1),
                borderRadius:
                BorderRadius.all(Radius.circular(10))),
            child: Column(
              children: [
                Text(
                  "Daily Nutrition",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Protein: "+ state.nutri.protein.toStringAsFixed(2)), Text("Fat: "+ state.nutri.fat.toStringAsFixed(2))],
                    ),
                    Divider(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Carb: "+ state.nutri.carb.toStringAsFixed(2)),
                        Text("Calories: "+ state.nutri.calories.toStringAsFixed(2))
                      ],
                    )
                  ],
                )
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
