import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:intl/intl.dart';
import 'package:vegetarian/Screens/MainScreen/main_screen.dart';
import 'package:vegetarian/Screens/UserProfile/change_password_screen.dart';
import 'package:vegetarian/Screens/UserProfile/edit_basic_profile.dart';
import 'package:vegetarian/Screens/UserProfile/edit_body_screen.dart';
import 'package:vegetarian/blocs/change_password_bloc.dart';
import 'package:vegetarian/blocs/edit_basic_profile_bloc.dart';
import 'package:vegetarian/blocs/edit_body_bloc.dart';
import 'package:vegetarian/blocs/home_blocs.dart';
import 'package:vegetarian/blocs/profile_menu_blocs.dart';
import 'package:vegetarian/events/change_password_event.dart';
import 'package:vegetarian/events/edit_basic_profile_event.dart';
import 'package:vegetarian/events/edit_body_event.dart';
import 'package:vegetarian/events/home_events.dart';
import 'package:vegetarian/events/profile_menu_events.dart';
import 'package:vegetarian/states/profile_menu_state.dart';

class ProfileMenuScreen extends StatefulWidget {
  @override
  State<ProfileMenuScreen> createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenuScreen>
    with SingleTickerProviderStateMixin {
  late ProfileMenuBloc _profileBloc;
  String filePath = "";
  FilePickerResult? file;
  static Future<CloudinaryResponse> uploadFileOnCloudinary(
      {required String filePath,
        required CloudinaryResourceType resourceType}) async {
    String result;
    CloudinaryResponse response = new CloudinaryResponse(
        assetId: '',
        publicId: "",
        createdAt: DateTime.now(),
        url: "",
        secureUrl: "",
        originalFilename: "");
    try {
      var cloudinary =
      CloudinaryPublic('thuanhoang2108', 'se8jipuu', cache: false);
      response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(filePath, resourceType: resourceType),
      );
    } on CloudinaryException catch (e, s) {
      print(e.message);
      print(e.request);
    }
    return response;
  }


  late final TabController _tabController;
  var format = new DateFormat('dd-MM-yyy');
  List<String> workRoutine = ['Low intensity - office work or similar, no workout.','Average intensity - manual labor and/or semi-regular workouts.','High intensity - hobbyist athlete and/or daily workouts.'];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _profileBloc = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: Text(
                  'Profile',
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
                                      HomeBloc()..add(HomeFetchEvent()),
                                  child: MyHomePage(
                                    token: '123',
                                  ),
                                )));
                  },
                ),
                // leading: TextButton(onPressed: logout, child: Text('out'),),
              ),
              body: BlocBuilder<ProfileMenuBloc, ProfileMenuState>(
                  builder: (context, state) {
                if (state is ProfileMenuStateSuccess) {
                  Future<void> selectFile() async {
                    CloudinaryResponse response = new CloudinaryResponse(
                        assetId: '',
                        publicId: "",
                        createdAt: DateTime.now(),
                        url: "",
                        secureUrl: "",
                        originalFilename: "");
                    try {
                      var result = await FilePicker.platform.pickFiles(
                        type: FileType.any,
                        allowMultiple: false,
                      );
                      setState(() {
                        filePath = result!.paths.first!;
                      });
                      print(filePath);
                      file = result;
                      if (file != null) {
                        for (PlatformFile file in file!.files) {
                          if (file.path != null) {
                            var response = await uploadFileOnCloudinary(
                              filePath: file.path.toString(),
                              resourceType: CloudinaryResourceType.Auto,
                            );
                            _profileBloc.add(ProfileMenuUpdateImageEvent(image: response.secureUrl));
                          }
                        }
                      }
                    } on PlatformException catch (e, s) {} on Exception catch (e, s) {}
                  }
                  // return widget here based on BlocA's state
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
                  return Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.15,
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.height * 0.025),
                        child: Row(
                          children: [
                            Stack(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 55,
                                  child: ClipOval(
                                    child: Image.network(
                                      state.user.profileImage,
                                      height: MediaQuery.of(context).size.height * 0.1,
                                      width: MediaQuery.of(context).size.height * 0.1,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                    bottom: 1,
                                    right: 1,
                                    child: GestureDetector(
                                      onTap: () async {
                                        selectFile();

                                      },
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        child: Icon(
                                          Icons.add_a_photo,
                                          color: Colors.white,
                                          size: MediaQuery.of(context).size.height * 0.02,
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.deepOrange,
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(20))),
                                      ),
                                    ))
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.1,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.user.firstName +
                                        " " +
                                        state.user.lastName,
                                    style: TextStyle(
                                        fontSize: 22.5,
                                        fontFamily: "Quicksand",
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text("About me: " + state.user.aboutMe,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(

                                          fontSize: 15,
                                          fontFamily: "Quicksand",
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: BoxDecoration(color: Colors.blue),
                        child: TabBar(
                          indicatorColor: Colors.black,
                          tabs: <Tab>[
                            Tab(text: 'BASIC'),
                            Tab(text: 'BODY'),
                          ],
                          controller: _tabController,
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: TabBarView(
                          controller: _tabController,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: Column(
                                children: [
                                  inforRow(Icon(FontAwesomeIcons.transgender),
                                      'Gender', state.user.gender),
                                  inforRow(Icon(FontAwesomeIcons.mapMarkerAlt),
                                      'Country', state.user.country),
                                  inforRow(
                                      Icon(FontAwesomeIcons.birthdayCake),
                                      'Birthday',
                                      format.format(state.user.birthDate)+ " (" + calculateAge(state.user.birthDate).toString()+ " years old)"),
                                  inforRow(Icon(FontAwesomeIcons.phoneAlt),
                                      'Phone', state.user.phoneNumber),
                                  state.user.instagramLink !="" ? inforRow(Icon(FontAwesomeIcons.instagram),
                                      'Instagram', state.user.instagramLink.split('/').elementAt(state.user.instagramLink.split('/').length-2)):SizedBox(),
                                  state.user.facebookLink !="" ? inforRow(Icon(FontAwesomeIcons.facebook),
                                      'Gender', state.user.facebookLink.split('/').elementAt(state.user.facebookLink.split('/').length-2)):SizedBox(),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => BlocProvider(
                                                    create: (context) =>
                                                    EditProfileBloc()..add(EditProfileFetchEvent()),
                                                    child: EditBasicProfileScreen(
                                                    ),
                                                  )));
                                        },
                                        child: const Text('Edit basic profile', style: TextStyle(fontSize: 20)),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => BlocProvider(
                                                    create: (context) =>
                                                    ChangePasswordBloc()..add(ChangePasswordFetchEvent()),
                                                    child: ChangePasswordScreen(
                                                    ),
                                                  )));
                                        },
                                        child: const Text('Change Password', style: TextStyle(fontSize: 20)),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: Column(
                                children: [
                                  inforRow(Icon(Icons.height),
                                      'Height', state.user.height.toString()),
                                  inforRow(Icon(FontAwesomeIcons.weight),
                                      'Weight', state.user.weight.toString()),
                                  state.user.workoutRoutine != 0 ?inforRow(
                                      Icon(FontAwesomeIcons.dumbbell),
                                      'Work Routine',
                                      workRoutine[state.user.workoutRoutine-1]):SizedBox(),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => BlocProvider(
                                                    create: (context) =>
                                                    EditBodyBloc()..add(EditBodyFetchEvent()),
                                                    child: EditBodyScreen(
                                                    ),
                                                  )));
                                        },
                                        child: const Text('Edit body infor', style: TextStyle(fontSize: 20)),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (state is ProfileMenuStateInitial) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ProfileMenuStateFailure) {
                  return Center(
                    child: Text("Server Crashed"),
                  );
                }
                return Center(
                  child: Text("Server Crashed"),
                );
              })),
        ],
      ),
    );
  }

  Widget inforRow(Icon icon, String title, String value) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.05,
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.025,
          ),
          icon,
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.025,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 15, fontFamily: "Quicksand"),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.01,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Text(
              value,
              overflow: TextOverflow.clip,
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: "Quicksand",
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
