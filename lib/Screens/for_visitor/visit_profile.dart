import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:vegetarian/Screens/MainScreen/main_screen.dart';
import 'package:vegetarian/Screens/Recipes/all_recipes_screen.dart';
import 'package:vegetarian/Screens/Recipes/recipe_screen.dart';
import 'package:vegetarian/blocs/home_blocs.dart';
import 'package:vegetarian/blocs/recipe_blocs.dart';
import 'package:vegetarian/blocs/visitor_profile_bloc.dart';
import 'package:vegetarian/events/home_events.dart';
import 'package:vegetarian/events/recipe_event.dart';
import 'package:vegetarian/events/visitor_profile_event.dart';
import 'package:vegetarian/states/visitor_profile_state.dart';

class VisitorProfileScreen extends StatefulWidget {
  @override
  State<VisitorProfileScreen> createState() => _VisitorProfileState();
}

class _VisitorProfileState extends State<VisitorProfileScreen>
    with SingleTickerProviderStateMixin {
  late VisitorProfileBloc _commentBloc;

  //scroll controller
  final _scrollController = ScrollController();
  final _scrollThreadhold = 250.0;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _commentBloc = BlocProvider.of(context);
    _scrollController.addListener(() {
      final maxScrollExtent = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScrollExtent - currentScroll <= _scrollThreadhold) {
        //scroll to the end of 1 page
        _commentBloc.add(VisitorProfileFetchEvent(1,"",1));
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          BlocBuilder<VisitorProfileBloc, VisitorProfileState>(
              builder: (context, state) {
                if (state is VisitorProfileStateSuccess) {
                  return Scaffold(
                      resizeToAvoidBottomInset: false,
                      appBar: AppBar(
                        title: BlocBuilder<VisitorProfileBloc, VisitorProfileState>(
                            builder: (context, state) {
                              if (state is VisitorProfileStateSuccess) {
                                return Text(
                                  state.user.firstName + " " + state.user.lastName,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "Quicksand",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                );
                              }
                              return SizedBox();
                            }),
                        backgroundColor: Colors.transparent,
                        elevation: 0.0,
                        leading:
                        BlocBuilder<VisitorProfileBloc,
                            VisitorProfileState>(builder: (context, state) {
                          if (state is VisitorProfileStateSuccess) {
                            return
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            if(state.lastPage == "recipe" || state.lastPage == "author"){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                        create: (context) => RecipeBloc()
                                          ..add(RecipeFetchEvent(state
                                              .lastPageId,"backtorecipe")),
                                        child: RecipeScreen(),
                                      )));
                            }
                            // Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => BlocProvider(
                            //           create: (context) =>
                            //           HomeBloc()..add(HomeFetchEvent()),
                            //           child: MyHomePage(
                            //             token: '123',
                            //           ),
                            //         )));
                          },
                        );}return SizedBox();})
                        // leading: TextButton(onPressed: logout, child: Text('out'),),
                      ),
                      body: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.2,
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.height * 0.025),
                            child: BlocBuilder<VisitorProfileBloc,
                                VisitorProfileState>(builder: (context, state) {
                              if (state is VisitorProfileStateSuccess) {
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 40,
                                          child: ClipOval(
                                            child: Image.network(
                                              state.user.profileImage,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.1,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.1,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width *
                                              0.1,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width *
                                              0.5,
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              state.user.email == ""
                                                  ? SizedBox()
                                                  : Row(
                                                children: [
                                                  Icon(
                                                    Icons.mail_outline,
                                                    size: 15,
                                                  ),
                                                  Text(state.user.email,
                                                      overflow:
                                                      TextOverflow.clip,
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontFamily:
                                                          "Quicksand",
                                                          fontStyle: FontStyle
                                                              .italic)),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              state.user.phoneNumber == ""
                                                  ? SizedBox()
                                                  : Row(
                                                children: [
                                                  Icon(
                                                    Icons.phone,
                                                    size: 15,
                                                  ),
                                                  Text(state.user.phoneNumber,
                                                      overflow:
                                                      TextOverflow.clip,
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontFamily:
                                                          "Quicksand",
                                                          fontStyle: FontStyle
                                                              .italic)),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              state.user.country == ""
                                                  ? SizedBox()
                                                  : Row(
                                                children: [
                                                  Icon(
                                                    Icons.home,
                                                    size: 13,
                                                  ),
                                                  Text(state.user.country,
                                                      overflow:
                                                      TextOverflow.clip,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily:
                                                          "Quicksand",
                                                          fontStyle: FontStyle
                                                              .italic)),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              state.user.facebookLink == ""
                                                  ? SizedBox()
                                                  : Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.5,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.facebook,
                                                      size: 15,
                                                    ),
                                                    Text(
                                                        state
                                                            .user.facebookLink
                                                            .split("/")
                                                            .last,
                                                        overflow:
                                                        TextOverflow.fade,
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            fontFamily:
                                                            "Quicksand",
                                                            fontStyle:
                                                            FontStyle
                                                                .italic)),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              // state.user.instagramLink == ""
                                              //     ? SizedBox()
                                              //     : Row(
                                              //   children: [
                                              //     Icon(
                                              //       FontAwesomeIcons.instagram,
                                              //       size: 15,
                                              //     ),
                                              //     Text(
                                              //         state.user.instagramLink
                                              //             .split("/")
                                              //             .last ==
                                              //             ""
                                              //             ? state
                                              //             .user.instagramLink
                                              //             .split("/")[state
                                              //             .user
                                              //             .instagramLink
                                              //             .split("/")
                                              //             .length -
                                              //             2]
                                              //             : state
                                              //             .user.instagramLink
                                              //             .split("/")
                                              //             .last,
                                              //         overflow: TextOverflow.clip,
                                              //         style: TextStyle(
                                              //             fontSize: 13,
                                              //             fontFamily: "Quicksand",
                                              //             fontStyle:
                                              //             FontStyle.italic)),
                                              //   ],
                                              // ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.025,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('\"' + state.user.aboutMe + '\"',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: "Quicksand",
                                                fontStyle: FontStyle.italic))
                                      ],
                                    )
                                  ],
                                );
                              }
                              return SizedBox();
                            }),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(color: Colors.blue),
                            child: TabBar(
                              indicatorColor: Colors.black,
                              tabs: <Tab>[
                                Tab(text: 'RECIPE'),
                                Tab(text: 'VIDEO'),
                                Tab(text: 'BLOG'),
                              ],
                              controller: _tabController,
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: TabBarView(
                              controller: _tabController,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.7,
                                  child: GridView.builder(
                                    itemBuilder:
                                        (BuildContext buildContext, int index) {
                                      if (index >= state.recipes.length) {
                                        return Container(
                                          alignment: Alignment.center,
                                          child: Center(
                                            child: SizedBox(
                                              width: 50,
                                              height: 50,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 1.5,
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return GestureDetector(
                                          onTap: (){
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => BlocProvider(
                                                      create: (context) => RecipeBloc()
                                                        ..add(RecipeFetchEvent(
                                                            state.recipes[index].recipeId,
                                                            "visitor")),
                                                      child: RecipeScreen(),
                                                    )));
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context).size.width/3,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context).size.width/3,
                                                  decoration:
                                                  BoxDecoration(
                                                      image: DecorationImage(image: NetworkImage(state.recipes[index].recipeThumbnail),fit: BoxFit.fitHeight
                                                      )
                                                  )
                                                  ,
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    itemCount: state.hasReachedEnd
                                        ? state.recipes.length
                                        : state.recipes.length + 1,
                                    //add more item
                                    controller: _scrollController,
                                    gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        childAspectRatio: 2/4
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.7,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.7,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ));
                } else if (state is VisitorProfileStateInitial) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is VisitorProfileStateFailure) {
                  return Center(
                    child: Text("Server Crashed"),
                  );
                }
                return Center(
                  child: Text("Server Crashed"),
                );
              })
        ],
      ),
    );
  }
}
