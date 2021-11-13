import 'package:cool_alert/cool_alert.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vegetarian/Screens/UserProfile/profile_menu_screen.dart';
import 'package:vegetarian/blocs/edit_basic_profile_bloc.dart';
import 'package:vegetarian/blocs/profile_menu_blocs.dart';
import 'package:vegetarian/events/edit_basic_profile_event.dart';
import 'package:vegetarian/events/profile_menu_events.dart';
import 'package:vegetarian/states/edit_basic_profile_state.dart';

class EditBasicProfileScreen extends StatefulWidget {
  @override
  State<EditBasicProfileScreen> createState() => _EditBasicProfileState();
}

class _EditBasicProfileState extends State<EditBasicProfileScreen> {
  late EditProfileBloc _EditprofileBloc;
  final _aboutmeController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _genderController = TextEditingController();
  final _phoneController = TextEditingController();
  final _countryController = TextEditingController();
  final _facebookController = TextEditingController();
  final _instagramController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  var format = DateFormat('dd-MM-yyyy');
  @override
  void initState() {
    super.initState();
    _EditprofileBloc = BlocProvider.of(context);
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
                                ProfileMenuBloc()..add(ProfileMenuFetchEvent()),
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
    return BlocConsumer<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          if(state is EditProfileStateSuccess){
            CoolAlert.show(
              context: context,
              type: CoolAlertType.success,
              text: "Edit Profile successful!",
              onConfirmBtnTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            BlocProvider(
                              create: (context) =>
                              ProfileMenuBloc()
                                ..add(
                                    ProfileMenuFetchEvent()),
                              child: ProfileMenuScreen(),
                            )));
              },
            );
          }
      // do stuff here based on BlocA's state
    }, builder: (context, state) {
      // return widget here based on BlocA's state
      if (state is EditProfileFetchStateSuccess) {
        final _birthDayController =
            TextEditingController(text: format.format(state.user.birthDate));
        selectedDate = state.user.birthDate;
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

        ;
        _aboutmeController.text = state.user.aboutMe;
        _aboutmeController.selection = TextSelection.fromPosition(
            TextPosition(offset: _aboutmeController.text.length));
        _firstNameController.text = state.user.firstName;
        _firstNameController.selection = TextSelection.fromPosition(
            TextPosition(offset: _firstNameController.text.length));
        _lastNameController.text = state.user.lastName;
        _lastNameController.selection = TextSelection.fromPosition(
            TextPosition(offset: _lastNameController.text.length));
        _genderController.text = state.user.gender;
        _genderController.selection = TextSelection.fromPosition(
            TextPosition(offset: _genderController.text.length));
        _countryController.text = state.user.country;
        _countryController.selection = TextSelection.fromPosition(
            TextPosition(offset: _countryController.text.length));
        _phoneController.text = state.user.phoneNumber;
        _phoneController.selection = TextSelection.fromPosition(
            TextPosition(offset: _phoneController.text.length));
        _facebookController.text = state.user.facebookLink;
        _facebookController.selection = TextSelection.fromPosition(
            TextPosition(offset: _facebookController.text.length));
        _instagramController.text = state.user.instagramLink;
        _instagramController.selection = TextSelection.fromPosition(
            TextPosition(offset: _instagramController.text.length));
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
                                "About Me",
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
                                          state.user.aboutMe = value;
                                          // _heightController.text = value;
                                          print(state.user.aboutMe);
                                        });
                                      },
                                      style: TextStyle(color: Colors.white),
                                      controller: _aboutmeController,
                                      decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              left: 15, right: 15),
                                          hintText: "About Me"),
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
                                "First Name",
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
                                          state.user.firstName = value;
                                          // _heightController.text = value;
                                          print(_firstNameController.text);
                                        });
                                      },
                                      style: TextStyle(color: Colors.white),
                                      controller: _firstNameController,
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
                                "Last Name",
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
                                          state.user.lastName = value;
                                          // _heightController.text = value;
                                          print(state.user.lastName);
                                        });
                                      },
                                      style: TextStyle(color: Colors.white),
                                      controller: _lastNameController,
                                      decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              left: 15, right: 15),
                                          hintText: "Last Name"),
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
                                "Gender",
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
                                          state.user.gender = value;
                                          // _heightController.text = value;
                                          print(state.user.gender);
                                        });
                                      },
                                      style: TextStyle(color: Colors.white),
                                      controller: _genderController,
                                      decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              left: 15, right: 15),
                                          hintText: "Gender"),
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
                                "BirthDay",
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
                                      focusNode: AlwaysDisabledFocusNode(),
                                      readOnly: true,
                                      keyboardType: TextInputType.none,
                                      onTap: () {
                                        _selectDate(context);
                                      },
                                      textAlign: TextAlign.left,
                                      style: TextStyle(color: Colors.white),
                                      controller: _birthDayController,
                                      decoration: new InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: 15, right: 15),
                                        hintText: format.format(selectedDate),
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
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Country",
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
                                      keyboardType: TextInputType.none,
                                      onTap: () {
                                        showCountryPicker(
                                          context: context,
                                          //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                                          exclude: <String>['KN', 'MF'],
                                          //Optional. Shows phone code before the country name.
                                          showPhoneCode: false,
                                          onSelect: (Country country) {
                                            setState(() {
                                              state.user.country = country.name;
                                              // _heightController.text = value;
                                              print(state.user.country);
                                            });
                                            print(
                                                'Select country: ${country.name}');
                                          },
                                          // Optional. Sets the theme for the country list picker.
                                          countryListTheme:
                                              CountryListThemeData(
                                            // Optional. Sets the border radius for the bottomsheet.
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(40.0),
                                              topRight: Radius.circular(40.0),
                                            ),
                                            // Optional. Styles the search field.
                                            inputDecoration: InputDecoration(
                                              labelText: 'Search',
                                              hintText:
                                                  'Start typing to search',
                                              prefixIcon:
                                                  const Icon(Icons.search),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: const Color(0xFF8C98A8)
                                                      .withOpacity(0.2),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      onFieldSubmitted: (value) {
                                        setState(() {
                                          state.user.aboutMe = value;
                                          // _heightController.text = value;
                                          print(state.user.aboutMe);
                                        });
                                      },
                                      style: TextStyle(color: Colors.white),
                                      controller: _countryController,
                                      decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              left: 15, right: 15),
                                          hintText: "Country"),
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
                                "Phone",
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
                                      keyboardType: TextInputType.phone,
                                      onFieldSubmitted: (value) {
                                        setState(() {
                                          state.user.phoneNumber = value;
                                          // _heightController.text = value;
                                          print(state.user.phoneNumber);
                                        });
                                      },
                                      style: TextStyle(color: Colors.white),
                                      controller: _phoneController,
                                      decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              left: 15, right: 15),
                                          hintText: "Phone"),
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
                                "Facebook Link",
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
                                          state.user.facebookLink = value;
                                          // _heightController.text = value;
                                          print(state.user.facebookLink);
                                        });
                                      },
                                      style: TextStyle(color: Colors.white),
                                      controller: _facebookController,
                                      decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              left: 15, right: 15),
                                          hintText: "Facebook Link"),
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
                                "Instagram Link",
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
                                          state.user.instagramLink = value;
                                          // _heightController.text = value;
                                          print(state.user.instagramLink);
                                        });
                                      },
                                      style: TextStyle(color: Colors.white),
                                      controller: _instagramController,
                                      decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              left: 15, right: 15),
                                          hintText: "Instagram link"),
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
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: (){
                          _EditprofileBloc.add(EditProfileEvent(
                            state.user.firstName,
                            state.user.lastName,
                              state.user.aboutMe,
                              state.user.phoneNumber,
                              state.user.country,
                              state.user.facebookLink,
                              state.user.instagramLink,
                            selectedDate,
                              state.user.gender,
                              ));
                        },
                        child: Container(
                          height: 70,
                          width: 200,
                          child: Align(
                            child: Text(
                              'Save',
                              style:
                                  TextStyle(color: Colors.white70, fontSize: 20),
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
