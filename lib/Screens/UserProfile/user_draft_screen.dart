import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vegetarian/Screens/BlogScreen/blog_screen.dart';
import 'package:vegetarian/Screens/MainScreen/main_screen.dart';
import 'package:vegetarian/Screens/Recipes/edit_recipe_screen.dart';
import 'package:vegetarian/Screens/Recipes/recipe_screen.dart';
import 'package:vegetarian/blocs/blog_bloc.dart';
import 'package:vegetarian/blocs/draft_bloc.dart';
import 'package:vegetarian/blocs/edit_recipe_bloc.dart';
import 'package:vegetarian/blocs/home_blocs.dart';
import 'package:vegetarian/blocs/liked_bloc.dart';
import 'package:vegetarian/blocs/recipe_blocs.dart';
import 'package:vegetarian/constants/constants.dart';
import 'package:vegetarian/events/blog_event.dart';
import 'package:vegetarian/events/draft_event.dart';
import 'package:vegetarian/events/edit_recipe_events.dart';
import 'package:vegetarian/events/home_events.dart';
import 'package:vegetarian/events/recipe_event.dart';
import 'package:vegetarian/states/draft_state.dart';
import 'package:vegetarian/states/liked_state.dart';

class UserDraftScreen extends StatefulWidget {
  UserDraftScreen({Key? key}) : super(key: key);

  @override
  _UserDraftScreenState createState() => _UserDraftScreenState();
}

class _UserDraftScreenState extends State<UserDraftScreen> {
  final _searchController = TextEditingController();
  late DraftBloc _UserRecipesBloc;
  @override
  void initState() {
    _UserRecipesBloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryButtonTextColor,
          foregroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back), onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => BlocProvider(
              create: (context) =>
              HomeBloc()..add(HomeFetchEvent()),
              child: MyHomePage(token: '123',
              ),
            )));
          },
          ),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.book,color: Colors.black,)),
              Tab(icon: Icon(Icons.short_text_outlined,color: Colors.black,)),
              Tab(icon: Icon(Icons.video_collection,color: Colors.black,)),
            ],
          ),
          title: const Text('Draft'),
        ),
        body: TabBarView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(color: Colors.white),
              height: MediaQuery.of(context).size.height * 0.7652,
              child: BlocConsumer<DraftBloc, DraftState>(
                  listener: (context, state) {
                    if (state is DraftDeleteStateSuccess) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => DraftBloc()
                                  ..add(DraftFetchEvent()),
                                child: UserDraftScreen(),
                              )));
                    }
                  },
                  builder: (context, state) {
                    if (state is DraftStateSuccess) {
                      showAlertDialog(BuildContext context, int id) {
                        // set up the buttons
                        Widget cancelButton = TextButton(
                          child: Text("Cancel"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        );
                        Widget continueButton = TextButton(
                          child: Text("Delete"),
                          onPressed: () {
                            _UserRecipesBloc.add(DraftDeleteEvent(state.result.listRecipe[id].recipeId,"recipe",));
                            Navigator.of(context).pop();
                          },
                        ); // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          title: Text("Confirm"),
                          content: Text("Would you like to delete this recipe?"),
                          actions: [
                            cancelButton,
                            continueButton,
                          ],
                        ); // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }
                      return ListView.builder(
                        physics: ClampingScrollPhysics(),
                        itemCount:
                        (state.result.listRecipe != null) ? state.result.listRecipe.length : 0,
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            Slidable(
                              actionPane: SlidableDrawerActionPane(),
                              secondaryActions: <Widget>[
                                IconSlideAction(
                                  caption: 'Delete',
                                  color: Colors.red,
                                  icon: Icons.delete,
                                  onTap: () {
                                    showAlertDialog(context, index);
                                  },
                                ),
                                IconSlideAction(
                                  caption: 'Edit',
                                  color: Colors.lightGreenAccent,
                                  icon: Icons.edit,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BlocProvider(
                                              create: (context) => EditRecipeBloc()
                                                ..add(EditRecipeFetchEvent(state.result.listRecipe[index].recipeId)),
                                              child: EditRecipeScreen(),
                                            )));
                                  },
                                ),
                                IconSlideAction(
                                  caption: state.result.listRecipe[index].status ==1 ?"public":"private",
                                  color: Colors.lightBlueAccent,
                                  icon:state.result.listRecipe[index].status ==1 ? FontAwesomeIcons.eye :FontAwesomeIcons.eyeSlash,
                                  onTap: () {
                                    _UserRecipesBloc.add(SetPublicEvent(state.result.listRecipe[index].recipeId));
                                  },
                                ),
                              ],
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BlocProvider(
                                            create: (context) => RecipeBloc()
                                              ..add(RecipeFetchEvent(
                                                  state.result.listRecipe[index].recipeId,"draft")),
                                            child: RecipeScreen(),
                                          )));
                                },
                                child: Container(
                                    margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: kPrimaryBoderColor)),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 132.0,
                                          height: 100.0,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  state.result.listRecipe[index].recipeThumbnail),
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
                                              Text(state.result.listRecipe[index].recipeTitle,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                      color: kPrimaryTextColor),
                                                  overflow: TextOverflow.fade),
                                              Text(
                                                state.result.listRecipe[index].firstName +
                                                    ' ' +
                                                    state.result.listRecipe[index].lastName,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: kPrimaryTextColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),


                      );
                    }
                    return Center(
                      child: Text('There is no recipe, lets make some'),
                    );
                  }),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(color: Colors.white),
              height: MediaQuery.of(context).size.height * 0.7652,
              child: BlocBuilder<DraftBloc, DraftState>(
                  builder: (context, state) {
                    if (state is DraftStateSuccess) {
                      return ListView.builder(
                        physics: ClampingScrollPhysics(),
                        itemCount:
                        (state.result.listBlog != null) ? state.result.listBlog.length : 0,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                      create: (context) => BlogBloc()
                                        ..add(BlogFetchEvent(
                                            state.result.listBlog[index].blogId,"liked")),
                                      child: BlogScreen(),
                                    )));
                          },
                          child: Container(
                              margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: kPrimaryBoderColor)),
                              child: Row(
                                children: [
                                  Container(
                                    width: 132.0,
                                    height: 100.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            state.result.listBlog[index].blogThumbnail),
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
                                        Text(state.result.listBlog[index].blogTitle,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: kPrimaryTextColor),
                                            overflow: TextOverflow.fade),
                                        Text(
                                          state.result.listBlog[index].firstName +
                                              ' ' +
                                              state.result.listBlog[index].lastName,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: kPrimaryTextColor),
                                        ),
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
            Container(
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(color: Colors.white),
              height: MediaQuery.of(context).size.height * 0.7652,
              child: BlocBuilder<DraftBloc, DraftState>(
                  builder: (context, state) {
                    if (state is DraftStateSuccess) {
                      return ListView.builder(
                        physics: ClampingScrollPhysics(),
                        itemCount:
                        (state.result.listVideo != null) ? state.result.listVideo.length : 0,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                      create: (context) => BlogBloc()
                                        ..add(BlogFetchEvent(
                                            state.result.listVideo[index].blogId,"liked")),
                                      child: BlogScreen(),
                                    )));
                          },
                          child: Container(
                              margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: kPrimaryBoderColor)),
                              child: Row(
                                children: [
                                  Container(
                                    width: 132.0,
                                    height: 100.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            state.result.listVideo[index].blogThumbnail),
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
                                        Text(state.result.listVideo[index].blogTitle,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: kPrimaryTextColor),
                                            overflow: TextOverflow.fade),
                                        Text(
                                          state.result.listVideo[index].firstName +
                                              ' ' +
                                              state.result.listVideo[index].lastName,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: kPrimaryTextColor),
                                        ),
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
    );}
}
