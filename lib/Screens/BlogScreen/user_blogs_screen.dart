import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:vegetarian/Screens/BlogScreen/blog_screen.dart';
import 'package:vegetarian/blocs/blog_bloc.dart';
import 'package:vegetarian/blocs/user_blogs_bloc.dart';
import 'package:vegetarian/constants/constants.dart';
import 'package:vegetarian/events/blog_event.dart';
import 'package:vegetarian/states/user_blogs_state.dart';
import 'package:timeago/timeago.dart' as timeago;

class UserBlogsScreen extends StatefulWidget {
  UserBlogsScreen({Key? key}) : super(key: key);

  @override
  _UserBlogsScreenState createState() => _UserBlogsScreenState();
}

class _UserBlogsScreenState extends State<UserBlogsScreen> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Your Blogs'),
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
                height: MediaQuery.of(context).size.height * 0.76,
                child: BlocBuilder<UserBlogsBloc, UserBlogsState>(
                    builder: (context, state) {
                      if (state is UserBlogsStateSuccess) {
                        return ListView.builder(
                          physics: ClampingScrollPhysics(),
                          itemCount:
                          (state.blogs != null) ? state.blogs.length : 0,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                        create: (context) => BlogBloc()
                                          ..add(BlogFetchEvent(
                                              state.blogs[index].blogId, "userblog")),
                                        child: BlogScreen(),
                                      )));
                            },
                            child: Container(
                                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 131.0,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              state.blogs[index].blogThumbnail),
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
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(state.blogs[index].blogTitle,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: "Quicksand",
                                                  fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.fade),
                                          // Text(
                                          //   state.blogs[index].blogSubtitle,
                                          //   overflow: TextOverflow.ellipsis,
                                          //   style: TextStyle(fontSize: 12),
                                          // ),
                                          state.blogs[index].status == 1 ? Text("Pending",style: TextStyle(color: Colors.yellowAccent),)
                                              : state.blogs[index].status == 2? Text("Aprroved",style: TextStyle(color: Colors.lightGreen),)
                                              : Text("Rejected",style: TextStyle(color: Colors.redAccent),),
                                          Text(
                                            state.blogs[index].firstName +
                                                ' ' +
                                                state.blogs[index].lastName,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            DateTime.now()
                                                .difference(state
                                                .blogs[index]
                                                .timeCreated)
                                                .inDays <
                                                1
                                                ? timeago.format(
                                                state.blogs[index]
                                                    .timeCreated,
                                                locale: 'en')
                                                : DateFormat('dd-MM-yyyy')
                                                .format(state.blogs[index]
                                                .timeCreated),
                                            // state.blogs[index].timeCreated,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                child: Text(
                                                  state.blogs[index].totalLike
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontFamily: "Quicksand",
                                                      color: Colors.black,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              state.blogs[index].isLike == true
                                                  ? Icon(
                                                FontAwesomeIcons
                                                    .solidHeart,
                                                color: Colors.red,
                                                size: 15,
                                              )
                                                  : Icon(
                                                FontAwesomeIcons.heart,
                                                color: Colors.black,
                                                size: 15,
                                              )
                                            ],
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
                        child: Text('There is no recipe, lets make some'),
                      );
                    }),
              ),
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
