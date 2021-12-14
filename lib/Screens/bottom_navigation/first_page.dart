import 'package:flutter/material.dart';
import 'package:vegetarian/models/blogs_card.dart';
import 'package:vegetarian/models/list_4_videos.dart';
import 'package:vegetarian/models/recipes_card.dart';
import 'package:vegetarian/models/recommend_recipes.dart';
import 'package:vegetarian/models/user.dart';

class FirstPage extends StatelessWidget {
  final String? token;
  final List<RecipesCard> recipes;
  final List<RecipesCard> Bestecipes;
  final List<BlogsCard> blogs;
  final Listvideo videos;
  final ListRecommend? recommends;
  final User user;

  FirstPage({ this.token, required this.recipes, required this.Bestecipes, required this.blogs, required this.videos, this.recommends, required this.user}) : super();

  @override
  Widget build(BuildContext context) {
    if (token != null){
      print(1);
      return Scaffold(
        body: Center(
          child: Text('My text is: hay'),
        ),
      );
    }else{
      return Scaffold(
        body: Center(
          child: Text('My text is: '),
        ),
      );
    }

  }
}
