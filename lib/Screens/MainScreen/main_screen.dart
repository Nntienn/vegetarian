import 'package:carousel_slider/carousel_slider.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:vegetarian/Screens/BlogScreen/all_blogs_screen.dart';
import 'package:vegetarian/Screens/BlogScreen/blog_screen.dart';
import 'package:vegetarian/Screens/BlogScreen/user_blogs_screen.dart';
import 'package:vegetarian/Screens/Login/login_screen.dart';
import 'package:vegetarian/Screens/MainScreen/map_screen.dart';
import 'package:vegetarian/Screens/Recipes/all_recipes_screen.dart';
import 'package:vegetarian/Screens/Recipes/recipe_screen.dart';
import 'package:vegetarian/Screens/Recipes/user_recipes_screen.dart';
import 'package:vegetarian/Screens/UserProfile/allergies_screen.dart';
import 'package:vegetarian/Screens/UserProfile/check_nutrition_screen.dart';
import 'package:vegetarian/Screens/UserProfile/favorite_ingredient_screen.dart';
import 'package:vegetarian/Screens/UserProfile/generate_weekly_menu_screen.dart';
import 'package:vegetarian/Screens/UserProfile/profile_menu_screen.dart';
import 'package:vegetarian/Screens/UserProfile/user_liked_screen.dart';
import 'package:vegetarian/Screens/Video_Screen/all_video_screen.dart';
import 'package:vegetarian/Screens/Video_Screen/user_videos_screen.dart';
import 'package:vegetarian/blocs/all_blogs_bloc.dart';
import 'package:vegetarian/blocs/all_recipes_bloc.dart';
import 'package:vegetarian/blocs/all_videos_bloc.dart';
import 'package:vegetarian/blocs/allergies_bloc.dart';
import 'package:vegetarian/blocs/blog_bloc.dart';
import 'package:vegetarian/blocs/check_nutrition_bloc.dart';
import 'package:vegetarian/blocs/favorite_ingredients_bloc.dart';
import 'package:vegetarian/blocs/home_blocs.dart';
import 'package:vegetarian/blocs/liked_bloc.dart';
import 'package:vegetarian/blocs/login_blocs.dart';
import 'package:vegetarian/blocs/nearby_bloc.dart';
import 'package:vegetarian/blocs/profile_menu_blocs.dart';
import 'package:vegetarian/blocs/recipe_blocs.dart';
import 'package:vegetarian/blocs/user_blogs_bloc.dart';
import 'package:vegetarian/blocs/user_recipes_bloc.dart';
import 'package:vegetarian/blocs/user_videos_bloc.dart';
import 'package:vegetarian/blocs/weekly_menu_bloc.dart';
import 'package:vegetarian/constants/constants.dart';
import 'package:vegetarian/events/all_blogs_event.dart';
import 'package:vegetarian/events/all_recipes_events.dart';
import 'package:vegetarian/events/all_video_bloc.dart';
import 'package:vegetarian/events/allergies_event.dart';
import 'package:vegetarian/events/blog_event.dart';
import 'package:vegetarian/events/check_nutrition_events.dart';
import 'package:vegetarian/events/favorite_ingredients_event.dart';
import 'package:vegetarian/events/home_events.dart';
import 'package:vegetarian/events/liked_events.dart';
import 'package:vegetarian/events/login_events.dart';
import 'package:vegetarian/events/nearby_event.dart';
import 'package:vegetarian/events/profile_menu_events.dart';
import 'package:vegetarian/events/recipe_event.dart';
import 'package:vegetarian/events/user_blogs_events.dart';
import 'package:vegetarian/events/user_recipes_events.dart';
import 'package:vegetarian/events/user_videos_event.dart';
import 'package:vegetarian/events/weekly_menu_event.dart';
import 'package:vegetarian/repositories/local_data.dart';
import 'package:vegetarian/states/home_states.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.token}) : super(key: key);

  final String token;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String token = '';
  List<String> criteria = [
    'Favorite ingredient',
    'Favorite recipe',
    'Recent search',
    'Needed nutrition',
    'Popular recipes'
  ];
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        leadingWidth: 0,
        actions: <Widget>[
          IconButton(
              onPressed: () {}, icon: Icon(Icons.search, color: Colors.black)),
          Container(
            child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
              if (state is HomeStateSuccess) {
                Widget _buildPopupDialog(BuildContext context) {
                  return new Dialog(
                    insetPadding: EdgeInsets.all(10),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: new Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height * 0.03,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Vegetarian',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "Quicksand",
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          ExpansionTileCard(
                            shadowColor: Colors.white,
                            baseColor: Colors.white,
                            key: cardA,
                            leading: Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(state.user.profileImage),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(80.0),
                                border: Border.all(
                                  color: Colors.black12.withOpacity(0.5),
                                  width: 5,
                                ),
                              ),
                            ),
                            title: Text(
                              state.user.firstName + ' ' + state.user.lastName,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'About me: ' + state.user.aboutMe,
                              style: TextStyle(fontSize: 15),
                            ),
                            children: <Widget>[
                              Divider(
                                thickness: 1.0,
                                height: 1.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                MediaQuery.of(context).size.height * 0.05,
                                child: TextButton.icon(
                                    style: TextButton.styleFrom(
                                        alignment: Alignment.centerLeft),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BlocProvider(
                                                    create: (context) =>
                                                    ProfileMenuBloc()
                                                      ..add(
                                                          ProfileMenuFetchEvent("home",-1)),
                                                    child: ProfileMenuScreen(),
                                                  )));
                                    },
                                    icon: Icon(Icons.account_circle_outlined),
                                    label: Text(
                                      'Your Profile' ,
                                      style: TextStyle(color: Colors.black),
                                    )),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: TextButton.icon(
                                    style: TextButton.styleFrom(
                                        alignment: Alignment.centerLeft),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BlocProvider(
                                                    create: (context) =>
                                                        UserRecipesBloc()
                                                          ..add(
                                                              UserRecipesFetchEvent(
                                                                  state.user
                                                                      .id)),
                                                    child: UserRecipesScreen(),
                                                  )));
                                    },
                                    icon: new Image.asset(
                                      "assets/vegetable_icon.png",
                                    ),
                                    label: Text('Your recipes',
                                        style: TextStyle(color: Colors.black))),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: TextButton.icon(
                                    style: TextButton.styleFrom(
                                        alignment: Alignment.centerLeft),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BlocProvider(
                                                    create: (context) =>
                                                        UserBlogsBloc()
                                                          ..add(
                                                              UserBlogsFetchEvent(
                                                                  state.user
                                                                      .id)),
                                                    child: UserBlogsScreen(),
                                                  )));
                                    },
                                    icon: new Image.asset(
                                      "assets/blog_icon.png",
                                    ),
                                    label: Text(
                                      'Your blog',
                                      style: TextStyle(color: Colors.black),
                                    )),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: TextButton.icon(
                                    style: TextButton.styleFrom(
                                        alignment: Alignment.centerLeft),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BlocProvider(
                                                    create: (context) =>
                                                        UserVideosBloc()
                                                          ..add(
                                                              UserVideosFetchEvent()),
                                                    child: UserVideosScreen(),
                                                  )));
                                    },
                                    icon: new Image.asset(
                                      "assets/video_icon.png",
                                    ),
                                    label: Text(
                                      'Your video',
                                      style: TextStyle(color: Colors.black),
                                    )),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: TextButton.icon(
                                    style: TextButton.styleFrom(
                                        alignment: Alignment.centerLeft),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BlocProvider(
                                                    create: (context) =>
                                                        LikedBloc()
                                                          ..add(
                                                              LikedFetchEvent()),
                                                    child: UserLikedScreen(),
                                                  )));
                                    },
                                    icon: new Image.asset(
                                      "assets/like_icon.png",
                                    ),
                                    label: Text(
                                      'Liked',
                                      style: TextStyle(color: Colors.black),
                                    )),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: TextButton.icon(
                                    style: TextButton.styleFrom(
                                        alignment: Alignment.centerLeft),
                                    onPressed: logout,
                                    icon:
                                        Icon(Icons.power_settings_new_outlined),
                                    label: Text(
                                      'Logout',
                                      style: TextStyle(color: Colors.black),
                                    )),
                              )
                            ],
                          ),
                          Divider(
                            thickness: 1.0,
                            height: 1.0,
                          ),
                          ListTile(
                            title: const Text('Favorite Ingredients'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                            create: (context) =>
                                                FavoriteIngredientsBloc()
                                                  ..add(
                                                      FavoriteIngredientsFetchEvent()),
                                            child: FavoriteIngredientsScreen(),
                                          )));
                            },
                          ),
                          ListTile(
                            title: const Text('Food Allergy'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                            create: (context) => AllergiesBloc()
                                              ..add(AllergiesFetchEvent()),
                                            child: AllergiesScreen(),
                                          )));
                            },
                          ),
                          ListTile(
                            title: const Text('Check Daily Needed Nutrion'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                            create: (context) =>
                                                CheckNutritionBloc()
                                                  ..add(
                                                      CheckNutritionFetchEvent()),
                                            child: CheckNutritionScreen(),
                                          )));
                            },
                          ),
                          ListTile(
                            title: const Text('Create Weekly Menu'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                            create: (context) =>
                                                WeeklyMenuBloc()
                                                  ..add(WeeklyMenuFetchEvent()),
                                            child: WeeklyMenuScreen(),
                                          )));
                            },
                          ),
                          ListTile(
                            title: const Text('Find Nearest Store/Restaurant'),
                            onTap: () async {
                              Position position =
                                  await Geolocator.getCurrentPosition(
                                      desiredAccuracy: LocationAccuracy.high);
                              LatLng latlngPosition =
                                  LatLng(position.latitude, position.longitude);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                            create: (context) => NearByBloc()
                                              ..add(NearByFetchEvent(
                                                  latlngPosition)),
                                            child: MapScreen(),
                                          )));
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return IconButton(
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => BlocProvider(
                      //               create: (context) => ProfileMenuBloc()
                      //                 ..add(ProfileMenuFetchEvent()),
                      //               child: ProfileMenuScreen(),
                      //             )));
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialog(context),
                      );
                    },
                    icon: Icon(Icons.account_circle_outlined,
                        color: Colors.black));
              }
              return IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) =>
                                      LoginBloc()..add(LoginFetchEvent()),
                                  child: LoginScreen(),
                                )));
                  },
                  icon: Icon(
                    Icons.power_settings_new_outlined,
                    color: Colors.black,
                  ));
            }
                //
                ),
          )
        ],
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: TextField(),
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: kPrimaryBackgroundColor),
        child: ListView(
          children: <Widget>[
            BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
              if (state is HomeStateInitial) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is HomeStateSuccess) {
                final double width = MediaQuery.of(context).size.width;
                return Container(
                    child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    enlargeCenterPage: false,
                    viewportFraction: 1.0,
                  ),
                  items: state.Bestecipes.map((item) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                        create: (context) => RecipeBloc()
                                          ..add(
                                              RecipeFetchEvent(item.recipeId,"home")),
                                        child: RecipeScreen(),
                                      )));
                        },
                        child: Container(
                          child: Stack(
                            children: [
                              Container(
                                child: Image.network(
                                  item.recipeThumbnail,
                                  fit: BoxFit.cover,
                                  width: width,
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 5, 20, 5),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.7),
                                      Colors.black.withOpacity(0.0),
                                    ],
                                  ),
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.32,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: width * 0.5,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: width,
                                            child: Text(
                                              item.recipeTitle,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontFamily: "Quicksand",
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            width: width,
                                            child: Text(
                                              item.firstName +
                                                  ' ' +
                                                  item.lastName,
                                              style: TextStyle(
                                                  fontFamily: "Quicksand",
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: width * 0.39,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            child: Text(
                                              item.totalLike.toString(),
                                              style: TextStyle(
                                                  fontFamily: "Quicksand",
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {},
                                              icon: item.isLike == true
                                                  ? Icon(
                                                      FontAwesomeIcons
                                                          .solidHeart,
                                                      color: Colors.red,
                                                      size: 20,
                                                    )
                                                  : Icon(
                                                      FontAwesomeIcons.heart,
                                                      color: Colors.white,
                                                    ))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          color: kPrimaryAppBarColor,
                        ),
                      )).toList(),
                ));
              } else if (state is HomeStateUnLogged) {
                final double width = MediaQuery.of(context).size.width;
                return Container(
                    child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 5),
                    enlargeCenterPage: false,
                    viewportFraction: 1.0,
                  ),
                  items: state.Bestecipes.map((item) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                        create: (context) => RecipeBloc()
                                          ..add(
                                              RecipeFetchEvent(item.recipeId,"home")),
                                        child: RecipeScreen(),
                                      )));
                        },
                        child: Container(
                          child: Stack(
                            children: [
                              Container(
                                child: Image.network(
                                  item.recipeThumbnail,
                                  fit: BoxFit.cover,
                                  width: width,
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 5, 20, 5),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.7),
                                      // Colors.black.withOpacity(0.25),
                                      Colors.black.withOpacity(0.0),
                                      // Colors.black.withOpacity(0.1),
                                      // Colors.black.withOpacity(0.0)
                                    ],
                                  ),
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.32,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: width,
                                      child: Text(
                                        item.recipeTitle,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      width: width,
                                      child: Text(
                                        item.firstName + ' ' + item.lastName,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          color: kPrimaryAppBarColor,
                        ),
                      )).toList(),
                ));
              } else {
                return Text('không có gì car');
              }
            }),
            BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
              if (state is HomeStateInitial) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is HomeStateSuccess) {
                return Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height * 0.13,
                          child: ListView.builder(
                            itemCount: (state.recommends != null)
                                ? state.recommends.length
                                : 0,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                              create: (context) => RecipeBloc()
                                                ..add(RecipeFetchEvent(state
                                                    .recommends[index]
                                                    .recipeId,"home")),
                                              child: RecipeScreen(),
                                            )));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Stack(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(state
                                              .recommends[index]
                                              .recipeThumbnail),
                                          fit: BoxFit.cover,
                                        ),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 0.0,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [
                                            Colors.black.withOpacity(0.7),
                                            Colors.black.withOpacity(0.0),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 0, 5, 5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.recommends[index].recipeTitle,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontFamily: "Quicksand",
                                                fontSize: 12),
                                            overflow: TextOverflow.clip,
                                          ),
                                          Text(
                                            state.recommends[index].firstName +
                                                ' ' +
                                                state
                                                    .recommends[index].lastName,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontFamily: "Quicksand",
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                criteria[state.recommends[index]
                                                        .criteria -
                                                    1],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontFamily: "Quicksand",
                                                    fontStyle:
                                                        FontStyle.italic),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                );
              } else if (state is HomeStateUnLogged) {
                return SizedBox();
              }
              return Text('không có gì car');
            }),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 5),
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              height: MediaQuery.of(context).size.height * 0.29,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(
                          'Lastest Recipes',
                          style: TextStyle(
                              color: Colors.black45,
                              fontFamily: "Quicksand",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Spacer(),
                      Container(
                          height: 30,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                              create: (context) =>
                                                  AllRecipesBloc()
                                                    ..add(
                                                        AllRecipesFetchEvent()),
                                              child: AllRecipesScreen(),
                                            )));
                              },
                              child: Text(
                                'See All',
                                style: TextStyle(
                                    fontFamily: "Quicksand",
                                    fontWeight: FontWeight.bold),
                              )))
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    height: MediaQuery.of(context).size.height * 0.23,
                    child: BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                      if (state is HomeStateInitial) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (state is HomeStateSuccess) {
                        return ListView.builder(
                          itemCount: (state.recipes != null)
                              ? state.recipes.length
                              : 0,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                            create: (context) => RecipeBloc()
                                              ..add(RecipeFetchEvent(state
                                                  .recipes[index].recipeId,"home")),
                                            child: RecipeScreen(),
                                          )));
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width * 0.26,
                              margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              // decoration: BoxDecoration(border: Border.all(color: kPrimaryBoderColor)),
                              child: Stack(children: [
                                Container(
                                  height: MediaQuery.of(context).size.height,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          state.recipes[index].recipeThumbnail),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 0.0,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.7),
                                        // Colors.black.withOpacity(0.25),
                                        Colors.black.withOpacity(0.0),
                                        // Colors.black.withOpacity(0.1),
                                        // Colors.black.withOpacity(0.0)
                                      ],
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 6, 10, 10),
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.recipes[index].recipeTitle,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 12),
                                            overflow: TextOverflow.clip,
                                          ),
                                          Text(
                                            state.recipes[index].firstName +
                                                ' ' +
                                                state.recipes[index].lastName,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontStyle: FontStyle.italic),
                                          ),
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                            alignment: Alignment.bottomLeft,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            margin:
                                                EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.05,
                                                  child: IconButton(
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      padding: EdgeInsets.zero,
                                                      onPressed: () {},
                                                      icon: state.recipes[index]
                                                                  .isLike ==
                                                              true
                                                          ? Icon(
                                                              FontAwesomeIcons
                                                                  .solidHeart,
                                                              color: Colors.red,
                                                              size: 15,
                                                            )
                                                          : Icon(
                                                              FontAwesomeIcons
                                                                  .heart,
                                                              color:
                                                                  Colors.white,
                                                              size: 15,
                                                            )),
                                                ),
                                                Text(
                                                  state.recipes[index].totalLike
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Quicksand"),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                            ),
                          ),
                        );
                      } else if (state is HomeStateUnLogged) {
                        return ListView.builder(
                          itemCount: (state.recipes != null)
                              ? state.recipes.length
                              : 0,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () async {

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                            create: (context) => RecipeBloc()
                                              ..add(RecipeFetchEvent(state
                                                  .recipes[index].recipeId,"home")),
                                            child: RecipeScreen(),
                                          )));
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width * 0.26,
                              margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              // decoration: BoxDecoration(border: Border.all(color: kPrimaryBoderColor)),
                              child: Stack(children: [
                                Container(
                                  height: MediaQuery.of(context).size.height,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          state.recipes[index].recipeThumbnail),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 0.0,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.7),
                                        // Colors.black.withOpacity(0.25),
                                        Colors.black.withOpacity(0.0),
                                        // Colors.black.withOpacity(0.1),
                                        // Colors.black.withOpacity(0.0)
                                      ],
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 6, 10, 10),
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.recipes[index].recipeTitle,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 12),
                                            overflow: TextOverflow.clip,
                                          ),
                                          Text(
                                            state.recipes[index].firstName +
                                                ' ' +
                                                state.recipes[index].lastName,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                            ),
                          ),
                        );
                      }
                      return Text('không có gì car');
                    }),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 5),
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(
                          'Lastest Videos',
                          style: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Quicksand",
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                          height: 50,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                              create: (context) =>
                                                  AllVideosBloc()
                                                    ..add(
                                                        AllVideosFetchEvent()),
                                              child: AllVideosScreen(),
                                            )));
                              },
                              child: Text('See All')))
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                      if (state is HomeStateInitial) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (state is HomeStateSuccess) {
                        return GridView.builder(
                            primary: true,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio: 3 / 2,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5),
                            itemCount: state.videos.listResult.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return Container(
                                child: Stack(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(state
                                              .videos
                                              .listResult[index]
                                              .videoThumbnail),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 0.0,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [
                                            Colors.black.withOpacity(0.7),
                                            // Colors.black.withOpacity(0.25),
                                            Colors.black.withOpacity(0.0),
                                            // Colors.black.withOpacity(0.1),
                                            // Colors.black.withOpacity(0.0)
                                          ],
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 6, 10, 10),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state.videos.listResult[index]
                                                    .videoTitle,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 12),
                                                overflow: TextOverflow.clip,
                                              ),
                                              Text(
                                                state.videos.listResult[index]
                                                        .firstName +
                                                    ' ' +
                                                    state
                                                        .videos
                                                        .listResult[index]
                                                        .lastName,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontStyle:
                                                        FontStyle.italic),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)),
                              );
                            });
                      } else if (state is HomeStateUnLogged) {
                        return GridView.builder(
                            primary: true,
                            gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 3 / 2,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5),
                            itemCount: state.videos.listResult.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return Container(
                                child: Stack(
                                  children: [
                                    Container(
                                      height:
                                      MediaQuery.of(context).size.height,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(state
                                              .videos
                                              .listResult[index]
                                              .videoThumbnail),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 0.0,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [
                                            Colors.black.withOpacity(0.7),
                                            // Colors.black.withOpacity(0.25),
                                            Colors.black.withOpacity(0.0),
                                            // Colors.black.withOpacity(0.1),
                                            // Colors.black.withOpacity(0.0)
                                          ],
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 6, 10, 10),
                                          width:
                                          MediaQuery.of(context).size.width,
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state.videos.listResult[index]
                                                    .videoTitle,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 12),
                                                overflow: TextOverflow.clip,
                                              ),
                                              Text(
                                                state.videos.listResult[index]
                                                    .firstName +
                                                    ' ' +
                                                    state
                                                        .videos
                                                        .listResult[index]
                                                        .lastName,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontStyle:
                                                    FontStyle.italic),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)),
                              );
                            });
                      }
                      return Text('không có gì car');
                    }),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          'Lastest Blogs',
                          style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Spacer(),
                      Container(
                          height: 30,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                              create: (context) =>
                                                  AllBlogsBloc()
                                                    ..add(AllBlogsFetchEvent()),
                                              child: AllBlogsScreen(),
                                            )));
                              },
                              child: Text('See All')))
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                      if (state is HomeStateInitial) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (state is HomeStateSuccess) {
                        timeago.setLocaleMessages('en', timeago.EnMessages());
                        return ListView.separated(
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
                                                  state.blogs[index].blogId)),
                                            child: BlogScreen(),
                                          )));
                            },
                            child: Container(
                                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Row(
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
                                                  fontSize: 17,
                                                  fontFamily: "Quicksand",
                                                  fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.fade),
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
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: state.blogs[index]
                                                              .isLike ==
                                                          true
                                                      ? Icon(
                                                          FontAwesomeIcons
                                                              .solidHeart,
                                                          color: Colors.red,
                                                          size: 15,
                                                        )
                                                      : Icon(
                                                          FontAwesomeIcons
                                                              .heart,
                                                          color: Colors.black,
                                                          size: 15,
                                                        ))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                        );
                      } else if (state is HomeStateUnLogged) {
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
                                                  state.blogs[index].blogId)),
                                            child: BlogScreen(),
                                          )));
                            },
                            child: Container(
                                margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: kPrimaryBoderColor)),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 139.0,
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
                                          width: 5.0,
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
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(state.blogs[index].blogTitle,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.fade),
                                          Text(
                                            state.blogs[index].firstName +
                                                ' ' +
                                                state.blogs[index].lastName,
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        );
                      }
                      return Text('không có gì car');
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> logout() async {
    await LocalData().logOut();
    await Future.delayed(Duration(seconds: 1));
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) => BlocProvider(
            create: (context) => HomeBloc()..add(HomeFetchEvent()),
            child: MyHomePage(
              token: '123',
            )),
      ),
      (Route route) => false,
    );
  }
}
