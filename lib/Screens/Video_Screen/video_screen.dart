import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:vegetarian/Screens/Login/login_screen.dart';
import 'package:vegetarian/Screens/MainScreen/main_screen.dart';
import 'package:vegetarian/Screens/UserProfile/profile_menu_screen.dart';
import 'package:vegetarian/Screens/Video_Screen/Component/video.dart';
import 'package:vegetarian/Screens/for_visitor/visit_profile.dart';
import 'package:vegetarian/blocs/home_blocs.dart';
import 'package:vegetarian/blocs/login_blocs.dart';
import 'package:vegetarian/blocs/profile_menu_blocs.dart';
import 'package:vegetarian/blocs/video_bloc.dart';
import 'package:vegetarian/blocs/visitor_profile_bloc.dart';
import 'package:vegetarian/constants/constants.dart';
import 'package:vegetarian/events/home_events.dart';
import 'package:vegetarian/events/login_events.dart';
import 'package:vegetarian/events/profile_menu_events.dart';
import 'package:vegetarian/events/video_event.dart';
import 'package:vegetarian/events/visitor_profile_event.dart';
import 'package:vegetarian/states/video_state.dart';
import 'package:video_player/video_player.dart';

import 'Component/video_cubit.dart';

class VideoScreen extends StatefulWidget {
  @override
  State<VideoScreen> createState() => _VideoState();
}

class _VideoState extends State<VideoScreen> {
  late VideoBloc _recipeBloc;
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;
  TextEditingController _editCommentController = new TextEditingController();
  TextEditingController _commentController = new TextEditingController();
  @override
  void initState() {
    _recipeBloc = BlocProvider.of(context);
    super.initState();
    // _controller = VideoPlayerController.network(
    //   'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    // );
    // _initializeVideoPlayerFuture = _controller!.initialize();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: kPrimaryButtonTextColor,
        foregroundColor: Colors.black,
        title: Text('Video'),
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
      body: SafeArea(
        child: BlocConsumer<VideoBloc, VideoState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is VideoStateInitial) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is VideoStateFailure) {
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
              if (state is VideoStateSuccess) {
                Future<void> _displayTextInputDialog(
                    BuildContext context, int commentId, String content) async {
                  return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Edit Comment'),
                          content: TextField(
                            controller: _editCommentController,
                            decoration:
                            InputDecoration(hintText: "Comment ...."),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              color: Colors.red,
                              textColor: Colors.white,
                              child: Text('CANCEL'),
                              onPressed: () {
                                setState(() {
                                  Navigator.pop(context);
                                });
                              },
                            ),
                            FlatButton(
                              color: Colors.green,
                              textColor: Colors.white,
                              child: Text('OK'),
                              onPressed: () {
                                _recipeBloc.add(EditVideoCommentEvent(
                                    _editCommentController.text,
                                    commentId,
                                    state.video.id));
                                setState(() {
                                  Navigator.pop(context);
                                });
                              },
                            ),
                          ],
                        );
                      });
                }

                Future<void> _commentInputDialog(BuildContext context) async {
                  return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Comment'),
                          content: TextField(
                            controller: _commentController,
                            onSubmitted: (value) {
                              _commentController.text = value;

                              _commentController.text = '';
                            },
                            decoration:
                            InputDecoration(hintText: "Comment ...."),
                          ),
                          actions: <Widget>[
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
                            FlatButton(
                              color: Colors.green,
                              textColor: Colors.white,
                              child: Text('Comment'),
                              onPressed: () {
                                _recipeBloc.add(VideoCommentEvent(
                                    _commentController.text,
                                    state.video.id));
                                _commentController.text = '';
                                setState(() {
                                  Navigator.pop(context);
                                });
                              },
                            ),
                          ],
                        );
                      });
                }
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView(children: [
                    Video.blocProvider(
                      // Normally you'll get both the url and the aspect ratio from your video meta data
                      state.video.videoLink,
                      aspectRatio: 1.77,
                      autoPlay: false,
                    ),
                    Container(
                      // alignment: Alignment.bottomLeft,
                      // height: MediaQuery.of(context).size.height * 0.9,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.75,
                                    child: Text(
                                      state.video.videoTitle,
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(state.video.totalLike.toString(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  IconButton(
                                      onPressed: () {
                                        _recipeBloc
                                            .add(VideoLikeEvent(state.video.id));
                                      },
                                      icon: state.video.isLike == true
                                          ? Icon(
                                        FontAwesomeIcons.solidHeart,
                                        color: Colors.red,
                                      )
                                          : Icon(
                                        FontAwesomeIcons.heart,
                                        color: Colors.black,
                                      ))
                                ],
                              ),
                            ],
                          ),
                          Container(
                            height: 2.0,
                            color: Colors.black54.withOpacity(0.3),
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  state.user == null? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BlocProvider(
                                            create: (context) =>
                                            VisitorProfileBloc()
                                              ..add(
                                                  VisitorProfileFetchEvent(
                                                      state.author.id,
                                                      "recipe",
                                                      state.video
                                                          .id)),
                                            child: VisitorProfileScreen(),
                                          ))) :state.user!.id == state.author.id
                                      ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BlocProvider(
                                            create: (context) =>
                                            ProfileMenuBloc()
                                              ..add(
                                                  ProfileMenuFetchEvent(
                                                      "recipe",
                                                      state.video
                                                          .id)),
                                            child: ProfileMenuScreen(),
                                          )))
                                      : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BlocProvider(
                                            create: (context) =>
                                            VisitorProfileBloc()
                                              ..add(
                                                  VisitorProfileFetchEvent(
                                                      state.author.id,
                                                      "recipe",
                                                      state.video
                                                          .id)),
                                            child: VisitorProfileScreen(),
                                          )));
                                },
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      child: ClipOval(
                                        child: state.author.profileImage == ""
                                            ? Image.network(
                                          "https://www.donkey.bike/wp-content/uploads/2020/12/user-member-avatar-face-profile-icon-vector-22965342-e1608640557889.jpg",
                                          height: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.05,
                                          width: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.05,
                                          fit: BoxFit.cover,
                                        )
                                            : Image.network(
                                          state.author.profileImage,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.05,
                                          width: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.05,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "  " +
                                          state.author.firstName +
                                          " " +
                                          state.author.lastName,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              Spacer(),
                              Text(
                                    DateFormat('dd-MM-yyyy hh:mm')
                                        .format(state.video.timeCreated),
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          Container(
                            height: 2.0,
                            color: Colors.black54.withOpacity(0.3),
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                          ),
                          Text(state.video.videoDescription),
                          Container(
                            height: 2.0,
                            color: Colors.black54.withOpacity(0.3),
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                          ),
                          Container(
                            height: 45,
                            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                    width: 1, color: Colors.black12)),
                            child: TextButton(
                                onPressed: () {
                                  state.user == null
                                      ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BlocProvider(
                                                create: (context) =>
                                                LoginBloc()
                                                  ..add(
                                                      LoginFetchEvent()),
                                                child: LoginScreen(),
                                              )))
                                      : _commentInputDialog(context);
                                },
                                child: Text("Comment")),
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.comments.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(
                                        width: 1, color: Colors.black12)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      child: ClipOval(
                                        child: state.author.profileImage == ""
                                            ? Image.network(
                                          "https://www.donkey.bike/wp-content/uploads/2020/12/user-member-avatar-face-profile-icon-vector-22965342-e1608640557889.jpg",
                                          height: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.05,
                                          width: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.05,
                                          fit: BoxFit.cover,
                                        )
                                            : Image.network(
                                          state.commentImage[index],
                                          height: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.05,
                                          width: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.05,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            state.user!.id ==
                                                state.comments[index].userId
                                                ? Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BlocProvider(
                                                          create: (context) =>
                                                          ProfileMenuBloc()
                                                            ..add(ProfileMenuFetchEvent(
                                                                "video",
                                                                state
                                                                    .video
                                                                    .id)),
                                                          child:
                                                          ProfileMenuScreen(),
                                                        )))
                                                : Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BlocProvider(
                                                          create: (context) => VisitorProfileBloc()
                                                            ..add(VisitorProfileFetchEvent(
                                                                state
                                                                    .comments[
                                                                index]
                                                                    .userId,
                                                                "video",
                                                                state.video
                                                                    .id)),
                                                          child:
                                                          VisitorProfileScreen(),
                                                        )));
                                          },
                                          child: Text(
                                            state.comments[index].firstName +
                                                " " +
                                                state.comments[index].lastName,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(state.comments[index].content),
                                        state.user == null ? SizedBox(): state.user!.id ==
                                            state.comments[index].userId
                                            ? Row(
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 30,
                                              child: TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _editCommentController
                                                          .text =
                                                          state
                                                              .comments[
                                                          index]
                                                              .content;
                                                    });
                                                    _displayTextInputDialog(
                                                        context,
                                                        state
                                                            .comments[
                                                        index]
                                                            .id,
                                                        state
                                                            .comments[
                                                        index]
                                                            .content);
                                                  },
                                                  child: Text('Edit')),
                                            ),
                                            Container(
                                              width: 60,
                                              height: 30,
                                              child: TextButton(
                                                  onPressed: () {
                                                    _recipeBloc.add(
                                                        VideoDeleteCommentEvent(
                                                            state
                                                                .comments[
                                                            index]
                                                                .id,
                                                            state.video
                                                                .id));
                                                  },
                                                  child: Text('Delete')),
                                            ),
                                          ],
                                        )
                                            : SizedBox(
                                          height: 1,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),

                  ]),
                );

              }
              return SizedBox();
            }),
      ),
    );
  }
}
