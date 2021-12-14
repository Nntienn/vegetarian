import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetarian/Screens/MainScreen/main_screen.dart';
import 'package:vegetarian/Screens/Video_Screen/create_video_screen.dart';
import 'package:vegetarian/Screens/Video_Screen/video_screen.dart';
import 'package:vegetarian/blocs/home_blocs.dart';
import 'package:vegetarian/blocs/upload_video_bloc.dart';
import 'package:vegetarian/blocs/user_videos_bloc.dart';
import 'package:vegetarian/blocs/video_bloc.dart';
import 'package:vegetarian/constants/constants.dart';
import 'package:vegetarian/events/home_events.dart';
import 'package:vegetarian/events/upload_video_event.dart';
import 'package:vegetarian/events/video_event.dart';
import 'package:vegetarian/states/user_videos_state.dart';

class UserVideosScreen extends StatefulWidget {
  UserVideosScreen({Key? key}) : super(key: key);

  @override
  _UserVideosScreenState createState() => _UserVideosScreenState();
}

class _UserVideosScreenState extends State<UserVideosScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back), onPressed: () { Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => BlocProvider(
            create: (context) =>
            HomeBloc()..add(HomeFetchEvent()),
            child: MyHomePage(token: '123',
            ),
          ))); },
          ),
          title: Text('Your Videos'),
          actions: <Widget>[
            Container(
              child: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => UploadVideoBloc()
                              ..add(UploadVideoFetchEvent()),
                            child: UploadVideoScreen(),
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
                child: BlocConsumer<UserVideosBloc, UserVideosState>(
                    listener: (context, state) {
                    }, builder: (context, state) {
                  if (state is UserVideosStateSuccess) {
                    return ListView.builder(
                      physics: ClampingScrollPhysics(),
                      itemCount:
                      (state.list != null) ? state.list.listResult.length : 0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => VideoBloc()
                                      ..add(VideoFetchEvent(
                                          state.list.listResult[index].id,"userVideo")),
                                    child: VideoScreen(),
                                  )));
                        },
                        child: Container(
                            margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            decoration: BoxDecoration(
                                border: Border.all(color: kPrimaryBoderColor)),
                            child: Row(
                              children: [
                                Container(
                                  width: 130.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          state.list.listResult[index].videoThumbnail),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(state.list.listResult[index].videoTitle,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: kPrimaryTextColor),
                                          overflow: TextOverflow.fade),
                                      Text(
                                        state.list.listResult[index].firstName +
                                            ' ' +
                                            state.list.listResult[index].lastName,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: kPrimaryTextColor),
                                      ),
                                      Text(
                                        state.list.listResult[index].status == 1 ? "Private":state.list.listResult[index].status == 2? "Aprroved":"Rejected",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: kPrimaryTextColor),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                    );
                  }
                  return Center(
                    child: Text('There is no videos, lets make some'),
                  );
                }),
              ),
            ],
          ),
        ));
  }
}
