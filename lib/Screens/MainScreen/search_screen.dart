import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:vegetarian/Screens/BlogScreen/blog_screen.dart';
import 'package:vegetarian/Screens/MainScreen/main_screen.dart';
import 'package:vegetarian/Screens/Recipes/recipe_screen.dart';
import 'package:vegetarian/blocs/blog_bloc.dart';
import 'package:vegetarian/blocs/home_blocs.dart';
import 'package:vegetarian/blocs/recipe_blocs.dart';
import 'package:vegetarian/blocs/search_bloc.dart';
import 'package:vegetarian/constants/constants.dart';
import 'package:vegetarian/events/blog_event.dart';
import 'package:vegetarian/events/home_events.dart';
import 'package:vegetarian/events/recipe_event.dart';
import 'package:vegetarian/events/search_event.dart';
import 'package:vegetarian/models/category.dart';
import 'package:vegetarian/states/search_state.dart';
import 'package:timeago/timeago.dart' as timeago;

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchdScreenState createState() => _SearchdScreenState();
}

class _SearchdScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  List<Category> categodies = [Category(categoryId: -1, categoryName: "Category")];
  Category? category;
  String? sort;
  int? prepTime;
  String? difficulty;
  List<String> sortList = ["oldest","newest","mostlike","alphabet"];
  List<int> prepTimeList = [];
  List<String> diff = ["Beginner", "Novice", "Cook", "Chef", "Gordon Ramsay"];
  @override
  void initState() {
    for(int i = 0;i<120;i++){
      prepTimeList.add(i);
    }
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
          title:      TextField(
            controller: _searchController,
            onSubmitted: (value) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider(
                            create: (context) =>
                                SearchBloc()..add(SearchFetchEvent(value)),
                            child: SearchScreen(),
                          )));
            },
          ),
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
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(FontAwesomeIcons.utensilSpoon,color: Colors.black,)),
              Tab(icon: Icon(FontAwesomeIcons.blogger,color: Colors.black,)),
              Tab(icon: Icon(FontAwesomeIcons.video,color: Colors.black,)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(color: Colors.white),
              height: MediaQuery.of(context).size.height * 0.7652,
              child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                if (state is SearchStateSuccess) {
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height/25,
                                  width: MediaQuery.of(context).size.width*0.475,
                                  padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black38),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15))),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<Category>(
                                      hint: new Text("Choose Category"),
                                      value: category,
                                      icon: Icon(Icons.keyboard_arrow_down),
                                      items: state.category.map((Category items) {
                                        return DropdownMenuItem(
                                            value: items,
                                            child: Text(items.categoryName));
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          this.category = value;
                                          print(category!.categoryName);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Container(
                                  height: MediaQuery.of(context).size.height/25,
                                  width: MediaQuery.of(context).size.width*0.32,
                                  padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black38),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      hint: new Text("Sort By"),
                                      value: sort,
                                      icon: Icon(Icons.keyboard_arrow_down),
                                      items: sortList.map((String items) {
                                        return DropdownMenuItem(
                                            value: items,
                                            child: Text(items));
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          this.sort = value;
                                          print(category!.categoryName);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height/25,
                                  // width: MediaQuery.of(context).size.width*0.2,
                                  padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black38),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<int>(
                                      // isExpanded: true,
                                      hint: new Text("Preparation Time"),
                                      value: prepTime,
                                      icon: Icon(Icons.keyboard_arrow_down),
                                      items: prepTimeList.map((int items) {
                                        return DropdownMenuItem(
                                            value: items,
                                            child: Text(items.toString().trim()+ " minutes"));
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          this.prepTime = value;
                                          print(prepTime);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Container(
                                  height: MediaQuery.of(context).size.height/25,
                                  width: MediaQuery.of(context).size.width*0.45,
                                  padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black38),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      hint: new Text("Difficulty"),
                                      value: difficulty,
                                      icon: Icon(Icons.keyboard_arrow_down),
                                      items: diff.map((String items) {
                                        return DropdownMenuItem(
                                            value: items,
                                            child: Text(items));
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          this.difficulty = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                TextButton(onPressed: (){Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                          create: (context) =>
                                          SearchBloc()..add(SearchEvent(state.keyword, null,difficulty == null ? null: (diff.indexOf(difficulty!)+1).toString(), category != null ? category!.categoryId.toString() : null,prepTime==null? null: prepTime.toString(), sort)),
                                          child: SearchScreen(),
                                        )));}, child: Text("Search with Filter"))
                              ],
                            )
                          ],
                        ),
                      ),
                      state.result.listRecipe.length ==0 ? Center(child: Text("No Result"),):
                      Container(
                        height: MediaQuery.of(context).size.height * 0.63,
                        child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          itemCount: (state.result.listRecipe != null)
                              ? state.result.listRecipe.length
                              : 0,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                            create: (context) => RecipeBloc()
                                              ..add(RecipeFetchEvent(
                                                  state.result.listRecipe[index]
                                                      .recipeId,
                                                  "search")),
                                            child: RecipeScreen(),
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
                                              state.result.listRecipe[index].recipeThumbnail),
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
                                          Text(state.result.listRecipe[index].recipeTitle,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: "Quicksand",
                                                  fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.fade),
                                          Text(
                                            state.result.listRecipe[index].firstName +
                                                ' ' +
                                                state.result.listRecipe[index].lastName,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            DateTime.now()
                                                .difference(state
                                                .result.listRecipe[index]
                                                .timeCreated)
                                                .inDays <
                                                1
                                                ? timeago.format(
                                                state.result.listRecipe[index]
                                                    .timeCreated,
                                                locale: 'en')
                                                : DateFormat('dd-MM-yyyy')
                                                .format(state.result.listRecipe[index]
                                                .timeCreated),
                                            // state.blogs[index].timeCreated,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                child: Text(
                                                  state.result.listRecipe[index].totalLike
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
                                              state.result.listRecipe[index].isLike == true
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
                        ),
                      ),
                    ],
                  );
                }
                return Center(
                  child: Text('There is no result!!'),
                );
              }),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(color: Colors.white),
              height: MediaQuery.of(context).size.height * 0.7652,
              child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                if (state is SearchStateSuccess) {
                  return ListView.builder(
                    physics: ClampingScrollPhysics(),
                    itemCount: (state.result.listBlog != null)
                        ? state.result.listBlog.length
                        : 0,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                      create: (context) => BlogBloc()
                                        ..add(BlogFetchEvent(state
                                            .result.listBlog[index].blogId,"search")),
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
                                    image: NetworkImage(state
                                        .result.listBlog[index].blogThumbnail),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
              child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                if (state is SearchStateSuccess) {
                  return ListView.builder(
                    physics: ClampingScrollPhysics(),
                    itemCount: (state.result.listVideo != null)
                        ? state.result.listVideo.length
                        : 0,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                      create: (context) => RecipeBloc()
                                        ..add(RecipeFetchEvent(
                                            state.result.listVideo[index].id,
                                            "search")),
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
                                        state.result.listVideo[index].videoThumbnail),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        state
                                            .result.listVideo[index].videoTitle,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: kPrimaryTextColor),
                                        overflow: TextOverflow.fade),
                                    Text(
                                      state.result.listVideo[index].firstName +
                                          ' ' +
                                          state
                                              .result.listVideo[index].lastName,
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
                  child: Text('There is no result!!'),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
