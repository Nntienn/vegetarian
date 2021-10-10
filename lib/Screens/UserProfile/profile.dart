import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vegetarian/Screens/UserProfile/profile_menu_screen.dart';

import 'package:vegetarian/blocs/profile_blocs.dart';
import 'package:vegetarian/blocs/profile_menu_blocs.dart';
import 'package:vegetarian/events/profile_events.dart';
import 'package:vegetarian/events/profile_menu_events.dart';
import 'package:vegetarian/states/profile_states.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late ProfileBloc _profileBloc;
  bool readLegal = false;
  final _aboutmeController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _countryController = TextEditingController();
  final _facebookController = TextEditingController();
  final _instagramController = TextEditingController();

  int id = 0;
  String profileImage = '';
  String gender = '';
  DateTime selectedDate = DateTime.now();
  var format = DateFormat('yyyy-MM-dd');

  String readTimestamp(int timestamp) {
    var now = new DateTime.now();
    var format = new DateFormat('dd-MM-yyy');
    var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
    var diff = date.difference(now);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + 'DAY AGO';
      } else {
        time = diff.inDays.toString() + 'DAYS AGO';
      }
    }

    return time;
  }

  @override
  void initState() {
    super.initState();
    _profileBloc = BlocProvider.of(context);
  }

  Widget _buildCoverImage(Size screenSize) {
    return Container(
        height: screenSize.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/2004723.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        ));
  }

  // Widget _buildProfileImage(String img) {
  //   return Center(
  //     child: Container(
  //       width: 150.0,
  //       height: 150.0,
  //       decoration: BoxDecoration(
  //         image: DecorationImage(
  //           image: NetworkImage(img),
  //           fit: BoxFit.cover,
  //         ),
  //         borderRadius: BorderRadius.circular(80.0),
  //         border: Border.all(
  //           color: Colors.white,
  //           width: 5.0,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildProfileImagestate() {
  //   return BlocBuilder<ProfileBloc, ProfileState>(
  //     builder: (context, state) {
  //       if (state is ProfileStateInitial) {
  //         return _buildProfileImage("assets/disease.png");
  //       }
  //       if (state is ProfileStateFailure) {
  //         return _buildProfileImage("assets/disease.png");
  //       }
  //       if (state is ProfileStateSuccess) {
  //         if (state.user.profileImage.isEmpty) {
  //           return _buildProfileImage("assets/disease.png");
  //         }
  //         return _buildProfileImage("${state.user.profileImage}");
  //       }
  //       return _buildProfileImage("assets/disease.png");
  //     },
  //   );
  // }

  // Widget _buildFullName() {
  //   TextStyle _nameTextStyle = TextStyle(
  //     fontFamily: 'Roboto',
  //     color: Colors.black,
  //     fontSize: 28.0,
  //     fontWeight: FontWeight.w700,
  //   );
  //
  //   return Container(
  //     margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
  //     child: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
  //       if (state is ProfileStateInitial) {
  //         return CircularProgressIndicator();
  //       }
  //       if (state is ProfileStateFailure) {
  //         return Center(
  //           child: Container(
  //             child: Text(
  //               "...",
  //               style: _nameTextStyle,
  //               softWrap: true,
  //               overflow: TextOverflow.ellipsis,
  //             ),
  //           ),
  //         );
  //       }
  //       if (state is ProfileStateSuccess) {
  //         return Center(
  //           child: Container(
  //             child: Text(
  //               "${state.user.firstName} ${state.user.lastName}",
  //               style: _nameTextStyle,
  //               softWrap: true,
  //               overflow: TextOverflow.ellipsis,
  //             ),
  //           ),
  //         );
  //       }
  //       return SizedBox();
  //     }),
  //   );
  // }

  Widget _buildStatContainer(String title, String hintValue, bool read,
      TextEditingController editingController) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      height: 40.0,
      margin: EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        color: Color(0xFFEFF4F7),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(this.context).size.width * 0.2,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Spacer(),
          Container(
            width: MediaQuery.of(this.context).size.width * 0.7,
            child: TextField(
              readOnly: read,
              controller: editingController,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                hintText: hintValue,
              ),
              onTap: () {
                editingController..text = hintValue;
              },
              onSubmitted: (value) {
                editingController..text = value;
              },
              maxLines: 1,
              // overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  DateTime toDate(int timestamp) {
    var format = new DateFormat('yyyy-MM-dd');
    DateTime date = new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
    return date;
  }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.6,
      height: 2.0,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 4.0),
    );
  }

  Widget _buildlogoutButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Color(0xFF404A5C),
                ),
                child: Center(
                  child: Text(
                    "Edit",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Colors.green[300],
      ),
      body: Stack(
        children: <Widget>[
          _buildCoverImage(screenSize),
          SafeArea(
            child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
              if (state is ProfileStateInitial) {
                return CircularProgressIndicator();
              }
              if (state is ProfileStateFailure) {
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
              if (state is ProfileStateSuccess) {
                final _birthDayController = TextEditingController(text: format.format(state.user.birthDate) );
                gender = state.user.gender;
                id = state.user.id;
                profileImage = state.user.profileImage;
                selectedDate = state.user.birthDate;
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

                ;
                return Column(
                  children: [
                    SizedBox(height: screenSize.height / 15),
                    SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          _buildStatContainer("Email", state.user.email, true,
                              _emailController),
                          _buildStatContainer("FirstName", state.user.firstName,
                              false, _firstNameController),
                          _buildStatContainer("LastName", state.user.lastName,
                              false, _lastNameController),
                          _buildStatContainer("About me", state.user.aboutMe,
                              false, _aboutmeController),
                          _buildStatContainer("Phone", state.user.phoneNumber,
                              false, _phoneController),
                          _buildStatContainer("Country", state.user.country,
                              false, _countryController),
                          _buildStatContainer(
                              "Facebook",
                              state.user.facebookLink,
                              false,
                              _facebookController),
                          _buildStatContainer(
                              "Instagram",
                              state.user.instagramLink,
                              false,
                              _instagramController),
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            height: 40.0,
                            margin: EdgeInsets.only(top: 8.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFEFF4F7),
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(this.context).size.width *
                                          0.2,
                                  child: Text(
                                    "Birth Day",
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  width:
                                      MediaQuery.of(this.context).size.width *
                                          0.7,
                                  child: TextField(
                                    focusNode: AlwaysDisabledFocusNode(),
                                    readOnly: true,
                                    controller: _birthDayController,
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.left,
                                    decoration: InputDecoration(
                                      hintText: format.format(selectedDate),
                                    ),
                                    onTap: () {
                                      _selectDate(context);
                                    },
                                    maxLines: 1,
                                    // overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _buildSeparator(screenSize),
                          // _buildGetInTouch(context),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      _profileBloc.add(ProfileUpdateEvent(
                                          _aboutmeController.text,
                                          _phoneController.text,
                                          profileImage,
                                          _countryController.text,
                                          _facebookController.text,
                                          _instagramController.text,
                                          _birthDayController.text,
                                          gender,
                                          email: _emailController.text,
                                          id: id,
                                          firstName: _firstNameController.text,
                                          lastName: _lastNameController.text));
                                    },
                                    child: Container(
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                        color: Color(0xFF404A5C),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Edit",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return SizedBox();
            }),
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
