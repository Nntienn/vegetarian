import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:vegetarian/blocs/blog_bloc.dart';
import 'package:vegetarian/constants/constants.dart';
import 'package:vegetarian/states/blog_states.dart';

class BlogScreen extends StatefulWidget {
  @override
  State<BlogScreen> createState() => _BlogState();
}

class _BlogState extends State<BlogScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Recipe'),
      ),
      body: Container(
        child: SafeArea(
          child: BlocBuilder<BlogBloc, BlogState>(builder: (context, state) {
            if (state is BlogStateInitial) {
              return CircularProgressIndicator();
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
              return Container(
                // padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                decoration: BoxDecoration(
                    border: Border.all(color: kPrimaryBlogBoderColor),
                    color: Colors.white),
                child: Column(children: [
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
                            decoration: new BoxDecoration(color: Colors.black.withOpacity(0.2)),
                          ),
                        ),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      height: MediaQuery.of(context).size.height * 0.2,
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                      child: Text(
                        state.blog.blogTitle,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold,color: Colors.white),
                      ),
                    )
                  ]),
                  SizedBox(height: screenSize.height / 50),
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
                        Container(
                          height: 2.0,
                          color: Colors.black54.withOpacity(0.3),
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height*0.55,
                          child: SingleChildScrollView(
                              child: Html(
                                data: state.blog.blogContent,
                            ),
                          )),
                      ],
                    ),
                  )
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
