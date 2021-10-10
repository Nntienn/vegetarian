import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFf4f5f9);
const kPrimaryBoderColor = Color(0xFFf1f7f7);
const kPrimaryBlogBoderColor = Color(0xFFe8e9e8);
const kPrimaryBackgroundColor = Color(0xFFeeeeee);
const kPrimaryAppBarColor = Color(0xFF5b8734);
const kPrimaryTextColor = Color(0xFF645c6e);

const BASE_Url = "http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/";

//Login
const LOGIN = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/user/signin';

//Register
const REGISTER = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/user/signup';

//Get info
const GET_USER_BY_EMAIL_FROM_API = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/auth/signup';
const EDIT_USER_API = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/user/update/';

//Recipes
const GET_10_RECIPES_FROM_API = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/recipes/get10recipes';
const GET_USER_RECIPES_FROM_API = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/recipes/getallbyuserID/';
const GET_5_BEST_RECIPES_FROM_API = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/recipes/get5bestrecipes';
const GET_RECIPE_BY_ID = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/recipes/getrecipeby/';
const GET_ALL_RECIPES = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/recipes/getall/';
const GET_CATEGORY = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/recipes/categories';
const CREATE_RECIPE = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/recipes/add';
const DELETE_RECIPE = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/recipes/delete/';
const RECIPE_COMMENT = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/recipes/';
const COMMENT_RECIPE = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/user/commentrecipe';

//Blogs
const GET_10_BLOGS_FROM_API = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/blogs/get10blogs';
const GET_BLOG_BY_ID = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/blogs/getblogby/';
const GET_USER_BLOGS_FROM_API = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/blogs/getallbyuserID/';
const GET_ALL_BLOGS = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/blogs/getall';

//Likes
const GET_USER_LIKED = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/user/';