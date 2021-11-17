import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetarian/Screens/UserProfile/profile_menu_screen.dart';
import 'package:vegetarian/blocs/edit_body_bloc.dart';
import 'package:vegetarian/blocs/profile_menu_blocs.dart';
import 'package:vegetarian/events/edit_body_event.dart';
import 'package:vegetarian/events/profile_menu_events.dart';
import 'package:vegetarian/states/edit_body_state.dart';

class EditBodyScreen extends StatefulWidget {
  @override
  State<EditBodyScreen> createState() => _EditBodyState();
}

class _EditBodyState extends State<EditBodyScreen> {
  late EditBodyBloc _EditBodyBloc;
  final _heightController = TextEditingController();
  final _weightNameController = TextEditingController();
  final _workRoutineController = TextEditingController();
  List<String> workRoutine = [
    'Low intensity - office work or similar, no workout.',
    'Average intensity - manual labor and/or semi-regular workouts.',
    'High intensity - hobbyist athlete and/or daily workouts.'
  ];

  @override
  void initState() {
    super.initState();
    _EditBodyBloc = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            'Edit Basic Profile',
            style: TextStyle(color: Colors.amber),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
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
                                ProfileMenuBloc()..add(ProfileMenuFetchEvent("",-1)),
                            child: ProfileMenuScreen(),
                          )));
            },
          ),
          // leading: TextButton(onPressed: logout, child: Text('out'),),
        ),
        body:
            profileView() // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Widget profileView() {
    return BlocConsumer<EditBodyBloc, EditBodyState>(
        listener: (context, state) {
      if (state is EditBodyStateSuccess) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: "Edit Profile successful!",
          onConfirmBtnTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider(
                          create: (context) =>
                              ProfileMenuBloc()..add(ProfileMenuFetchEvent("",-1)),
                          child: ProfileMenuScreen(),
                        )));
          },
        );
      }
      // do stuff here based on BlocA's state
    }, builder: (context, state) {
      // return widget here based on BlocA's state
      if (state is EditBodyStateFetchSuccess) {
        final _birthDayController =
            _heightController.text = state.user.height.toString();
        _heightController.selection = TextSelection.fromPosition(
            TextPosition(offset: _heightController.text.length));
        _weightNameController.text = state.user.weight.toString();
        _weightNameController.selection = TextSelection.fromPosition(
            TextPosition(offset: _weightNameController.text.length));
        _workRoutineController.text = state.user.workoutRoutine.toString();
        _workRoutineController.selection = TextSelection.fromPosition(
            TextPosition(offset: _workRoutineController.text.length));
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
              child: Stack(
                children: <Widget>[
                  CircleAvatar(
                    radius: 70,
                    child: ClipOval(
                      child: Image.network(
                        state.user.profileImage,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 1,
                      right: 1,
                      child: Container(
                        height: 40,
                        width: 40,
                        child: Icon(
                          Icons.add_a_photo,
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ))
                ],
              ),
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Colors.black54, Color.fromRGBO(0, 41, 102, 1)])),
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Height",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Quicksand",
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: TextFormField(
                                      onFieldSubmitted: (value) {
                                        setState(() {
                                          state.user.height = int.parse(value);
                                          // _heightController.text = value;
                                          print(state.user.aboutMe);
                                        });
                                      },
                                      style: TextStyle(color: Colors.white),
                                      controller: _heightController,
                                      decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              left: 15, right: 15),
                                          hintText: "Height"),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(
                                        width: 1.0, color: Colors.white70)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Weight",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Quicksand",
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: TextFormField(
                                      onFieldSubmitted: (value) {
                                        setState(() {
                                          state.user.weight =
                                              double.parse(value);
                                          // _heightController.text = value;
                                        });
                                      },
                                      style: TextStyle(color: Colors.white),
                                      controller: _weightNameController,
                                      decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              left: 15, right: 15),
                                          hintText: "First Name"),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(
                                        width: 1.0, color: Colors.white70)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Work Routine",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Quicksand",
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value:state.user.workoutRoutine != 0? workRoutine[
                                            state.user.workoutRoutine - 1]:workRoutine[
                                        0],
                                        icon: Icon(Icons.keyboard_arrow_down),
                                        items: workRoutine.map((String items) {
                                          return DropdownMenuItem(
                                              value: items,
                                              child: Container(
                                                color: Colors.white,
                                                margin: EdgeInsets.only(left: 15),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.76,
                                                  child: Text(
                                                    items.toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )));
                                        }).toList(),
                                        onChanged: (value) => setState(() {
                                          state.user.workoutRoutine = workRoutine.indexOf(value!) +1;
                                        }),
                                      ),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(
                                        width: 1.0, color: Colors.white70)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          _EditBodyBloc.add(EditBodyEvent(state.user.height, state.user.weight, state.user.workoutRoutine));
                        },
                        child: Container(
                          height: 70,
                          width: 200,
                          child: Align(
                            child: Text(
                              'Save',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 20),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                              )),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ))
          ],
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }

  Widget editProfile(
      TextEditingController controller, String hint, TextInputType type) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hint,
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Quicksand",
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: controller,
                  decoration: new InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15, right: 15),
                      hintText: hint),
                ),
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(width: 1.0, color: Colors.white70)),
          ),
        ],
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
