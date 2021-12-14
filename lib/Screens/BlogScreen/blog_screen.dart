import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vegetarian/Screens/Login/login_screen.dart';
import 'package:vegetarian/Screens/UserProfile/profile_menu_screen.dart';
import 'package:vegetarian/Screens/for_visitor/visit_profile.dart';
import 'package:vegetarian/blocs/blog_bloc.dart';
import 'package:vegetarian/blocs/login_blocs.dart';
import 'package:vegetarian/blocs/profile_menu_blocs.dart';
import 'package:vegetarian/blocs/visitor_profile_bloc.dart';
import 'package:vegetarian/constants/constants.dart';
import 'package:vegetarian/events/blog_event.dart';
import 'package:vegetarian/events/login_events.dart';
import 'package:vegetarian/events/profile_menu_events.dart';
import 'package:vegetarian/events/visitor_profile_event.dart';
import 'package:vegetarian/states/blog_states.dart';

class BlogScreen extends StatefulWidget {
  @override
  State<BlogScreen> createState() => _BlogState();
}

class _BlogState extends State<BlogScreen> {
  late BlogBloc _recipeBloc;
  TextEditingController _editCommentController = new TextEditingController();
  TextEditingController _commentController = new TextEditingController();

  @override
  void initState() {
    _recipeBloc = BlocProvider.of(context);
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
        title: Text('Blog'),
      ),
      body: Container(
        child: SafeArea(
          child: BlocBuilder<BlogBloc, BlogState>(builder: (context, state) {
            if (state is BlogStateInitial) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is BlogStateFailure) {
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
            if (state is BlogStateSuccess) {
              Future<void> _displayTextInputDialog(
                  BuildContext context, int commentId, String content) async {
                return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Edit Comment'),
                        content: TextField(
                          controller: _editCommentController,
                          decoration: InputDecoration(hintText: "Comment ...."),
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
                              _recipeBloc.add(EditBlogCommentEvent(
                                  _editCommentController.text,
                                  commentId,
                                  state.blog.blogId));
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
                          decoration: InputDecoration(hintText: "Comment ...."),
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
                              _recipeBloc.add(BlogCommentEvent(
                                  _commentController.text, state.blog.blogId));
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
                // padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                decoration: BoxDecoration(
                    border: Border.all(color: kPrimaryBlogBoderColor),
                    color: Colors.white),
                child: ListView(children: [
                  Stack(children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(state.blog.blogThumbnail),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                        child: Container(
                          decoration: new BoxDecoration(
                              color: Colors.black.withOpacity(0.2)),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      height: MediaQuery.of(context).size.height * 0.2,
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: Text(
                                  state.blog.blogTitle,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(state.blog.totalLike.toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              IconButton(
                                  onPressed: () {
                                    _recipeBloc
                                        .add(BlogLikeEvent(state.blog.blogId));
                                  },
                                  icon: state.blog.isLike == true
                                      ? Icon(
                                          FontAwesomeIcons.solidHeart,
                                          color: Colors.red,
                                        )
                                      : Icon(
                                          FontAwesomeIcons.heart,
                                          color: Colors.white,
                                        ))
                            ],
                          ),
                        ],
                      ),
                    )
                  ]),
                  SizedBox(height: screenSize.height / 50),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Author:' +
                                    ' ' +
                                    state.blog.firstName +
                                    ' ' +
                                    state.blog.lastName,
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                              SizedBox(height: screenSize.height / 50),
                              Text(
                                'Post Date:' +
                                    ' ' +
                                    state.blog.time.day.toString() +
                                    '/' +
                                    state.blog.time.month.toString() +
                                    '/' +
                                    state.blog.time.year.toString(),
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 2.0,
                          color: Colors.black54.withOpacity(0.3),
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                        ),
                        Html(
                          data: state.blog.blogContent,
                        ),
                        Container(
                          height: 45,
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border:
                                  Border.all(width: 1, color: Colors.black12)),
                          child: TextButton(
                              onPressed: () {
                                state.user == null
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BlocProvider(
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
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                                                      "recipe",
                                                                      state.blog
                                                                          .blogId)),
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
                                                                  "recipe",
                                                                  state.blog
                                                                      .blogId)),
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
                                      state.user == null
                                          ? SizedBox()
                                          : state.user!.id ==
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
                                                                BlogDeleteCommentEvent(
                                                                    state
                                                                        .comments[
                                                                            index]
                                                                        .id,
                                                                    state.blog
                                                                        .blogId));
                                                          },
                                                          child:
                                                              Text('Delete')),
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
      ),
    );
  }
}
