import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetarian/Screens/MainScreen/main_screen.dart';
import 'package:vegetarian/blocs/favorite_ingredients_bloc.dart';
import 'package:vegetarian/blocs/home_blocs.dart';
import 'package:vegetarian/events/favorite_ingredients_event.dart';
import 'package:vegetarian/events/home_events.dart';
import 'package:vegetarian/models/list_ingredient_name.dart';
import 'package:vegetarian/states/favorite_ingredients_state.dart';

class FavoriteIngredientsScreen extends StatefulWidget {
  @override
  State<FavoriteIngredientsScreen> createState() => _FavoriteIngredientsState();
}

class _FavoriteIngredientsState extends State<FavoriteIngredientsScreen> {
  late FavoriteIngredientsBloc _FavoriteIngredientsBloc;
  TextEditingController _texteditFieldController = TextEditingController();
  @override
  void initState() {
    _FavoriteIngredientsBloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Favorite Ingredients'),
        backgroundColor: Colors.green[300],
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
        // leading: TextButton(onPressed: logout, child: Text('out'),),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            BlocBuilder<FavoriteIngredientsBloc, FavoriteIngredientsState>(
                builder: (context, state) {
              if (state is FavoriteIngredientsStateSuccess) {
                Future<void> _displayTextInputDialog(
                    BuildContext context) async {
                  return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Add new Favorite Ingredient"),
                          content: TextField(
                            controller: _texteditFieldController,
                            onSubmitted: (value){
                              _texteditFieldController.text = value;
                            },
                            decoration:
                            InputDecoration(hintText: "Input Ingredient Name"),
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
                                setState(() {
                                  state.list.listIngredient.add(new ListIngredient(ingredientName: _texteditFieldController.text));
                                  _FavoriteIngredientsBloc.add(FavoriteIngredientsEditEvent(
                                      state.list));
                                  Navigator.pop(context);
                                });
                              },
                            ),
                          ],
                        );
                      });
                }
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: ListView.builder(
                    itemCount: state.list.listIngredient.length + 1,
                    itemBuilder: (context, index) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.075,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        )),
                        child: index == state.list.listIngredient.length
                            ? TextButton(onPressed: (){_displayTextInputDialog(context);}, child: Text(
                              ' + Add new',
                              style: TextStyle(fontSize: 20),
                            ))
                            : Row(children: [
                                Text(
                                  state.list.listIngredient[index]
                                      .ingredientName,
                                  style: TextStyle(fontSize: 20),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.cancel_outlined,
                                    size: MediaQuery.of(context).size.width *
                                        0.05,
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      state.list.listIngredient.removeAt(index);
                                    });

                                      _FavoriteIngredientsBloc.add(FavoriteIngredientsEditEvent(
                                          state.list));

                                    print(state
                                        .list.listIngredient[0].ingredientName);
                                  },
                                ),
                              ]),
                      );
                    },
                  ),
                );
              }
              return SizedBox();
            }),
            Align(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                onPressed: () {},
                child: const Text('Bottom Button!',
                    style: TextStyle(fontSize: 20)),
                color: Colors.blue,
                textColor: Colors.white,
                elevation: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
