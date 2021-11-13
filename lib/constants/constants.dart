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
const GOOGLE_LOGIN = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/user/signin/google';

//Register
const REGISTER = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/user/signup';
const VERIFY = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/user/verify';

//Get info
const GET_USER_BY_EMAIL_FROM_API = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/auth/signup';
const EDIT_USER_API = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/user/update/details/';
const EDIT_USER_PROFILE_IMAGE = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/user/update/profile/';
const GET_USER_BY_ID = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/user/';
const CHANGE_USER_PASSWORD_BY_ID = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/user/update/password/';
const FORGOT_PASSWORD = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/user/forgot';
const FORGOT_PASSWORD_RESEND = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/user/sendagain/reset';
const RESET_PASSWORD = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/user/resetPassword';
const CHECK_USER_DAILY_NUTRITION = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/user/calculate/nutrition';
const EDIT_USER_BODY_INDEX = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/user/update/bodyindex/';
const EDIT_USER_FAVORITE_INGREDIENT = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/user/preferences/';
const EDIT_USER_ALLERGIES_INGREDIENT = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/user/allergies/';
const GET_USER_FAVORITE_INGREDIENT = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/user/getpreferences/';
const GET_USER_ALLERGIES_INGREDIENT = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/user/getallergies/';
const GENERATE_WEEKLYMENU = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/menu/generate';
const SAVE_WEEKLYMENU = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/menu/add/';
const GET_WEEKLYMENU = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/menu/details/';



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
const CHECK_LIKE_RECIPE = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/user/recipe/islike';
const LIKE_RECIPE = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/recipes/like';
const DELETE_COMMENT = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/user/deleteComment/';
const EDIT_RECIPE = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/recipes/edit/';
const RECOMMENT_RECIPE_FOR_USER = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/recipes/suggestion/';


//Blogs
const GET_10_BLOGS_FROM_API = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/blogs/get10blogs';
const GET_BLOG_BY_ID = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/blogs/getblogby/';
const GET_USER_BLOGS_FROM_API = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/blogs/getallbyuserID/';
const GET_ALL_BLOGS = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/blogs/getall';

//Likes
const GET_USER_LIKED = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/user/';


//Videos
const UPLOAD_VIDEO = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/video/upload';
const GET_4_VIDEOS = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/video/get4videos';
const GET_VIDEO = 'http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/video/getvideoby/';

//Google_maps_api_key
String mapkey = "AIzaSyCjh4wjUFsNKfo6pcPMiBGLQi5_bziD3ig";
const GET_NEARBY = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json';