import 'dart:ui';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vegetarian/Screens/Recipes/user_recipes_screen.dart';
import 'package:vegetarian/blocs/edit_recipe_bloc.dart';
import 'package:vegetarian/blocs/user_recipes_bloc.dart';
import 'package:vegetarian/constants/constants.dart';
import 'package:vegetarian/events/edit_recipe_events.dart';
import 'package:vegetarian/events/user_recipes_events.dart';
import 'package:vegetarian/models/Ingredient.dart';
import 'package:vegetarian/models/category.dart';
import 'package:vegetarian/models/create_recipe.dart';
import 'package:vegetarian/models/edit_recipe.dart';
import 'package:vegetarian/states/edit_recipe_state.dart';

class EditRecipeScreen extends StatefulWidget {
  @override
  State<EditRecipeScreen> createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> {
  int? recipeId;
  late EditRecipeBloc _EditRecipeBloc;
  bool _stepvalidate = false;
  int currentStep = 0;
  bool isCompleted = false;
  List<int> listportioncount = [];
  List<String> listservings = ['serving', 'pieces'];
  TextEditingController title = TextEditingController();
  TextEditingController _texteditFieldController = TextEditingController();
  final amount = TextEditingController();
  final ingredient = TextEditingController();
  final stepcontent = TextEditingController();
  int portion = 2;
  int recipeStep = 1;
  int? dprephour = 0;
  int? dprepminute = 1;
  int? dbakinghour = 0;
  int? dbakingminute = 0;
  int? dresthour = 0;
  int? drestminute = 0;
  String serving = 'serving';
  String? submitContent = '';
  Category? category;
  String filePath = "";
  FilePickerResult? file;
  String? link;

  Category submitcategory = Category(categoryId: 1, categoryName: '');
  String? valueText;
  int? categoryid = 1;
  int difficulty = 1;
  int portiontype = 1;
  String difficultys = '';
  List<int> listDifficulty = [1, 2, 3, 4, 5];
  List<int> hours = [];
  List<int> minutes = [];
  List<int> minutes1 = [];
  List<String> recipeStepContents = [];
  List<String> listDifficultys = ['Beginner', 'Novice', 'Cook', 'Chef', 'Gordon Ramsay'];
  List<Ingredient> listIngredient = [];
  List<CreateRecipeStep> listStep = [];
  List<String> categoryTitle = [];

  static Future<CloudinaryResponse> uploadFileOnCloudinary(
      {required String filePath,
      required CloudinaryResourceType resourceType}) async {
    CloudinaryResponse response = new CloudinaryResponse(
        assetId: '',
        publicId: "",
        createdAt: DateTime.now(),
        url: "",
        secureUrl: "",
        originalFilename: "");
    try {
      var cloudinary =
          CloudinaryPublic('thuanhoang2108', 'se8jipuu', cache: false);
      response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(filePath, resourceType: resourceType),
      );
    } on CloudinaryException catch (e, s) {
      print(e.message);
      print(e.request);
    }
    return response;
  }

  @override
  void initState() {
    super.initState();
    _EditRecipeBloc = BlocProvider.of(context);
    for (int i = 1; i < 100; i++) {
      listportioncount.add(i);
    }
    for (int i = 0; i < 73; i++) {
      hours.add(i);
    }
    for (int i = 1; i < 60; i++) {
      minutes.add(i);
    }
    for (int i = 0; i < 60; i++) {
      minutes1.add(i);
    }
  }

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text(''),
          content: BlocBuilder<EditRecipeBloc, EditRecipeState>(
              builder: (context, state) {
            if (state is EditRecipeStateLoadSuccess) {
              recipeId = state.recipeId;
              title.text = state.recipe.recipeTitle;
              filePath = state.recipe.recipeThumbnail;
              submitcategory = state.list[state.recipe.recipeCategoriesId - 1];
              serving = listservings[int.parse(state.recipe.portionType) - 1];
              portion = state.recipe.portionSize;
              difficulty = state.recipe.recipeDifficulty;
              print(state.recipe.prepTimeMinutes.toString() + "prep time");
              this.dprephour = (state.recipe.prepTimeMinutes ~/ 60);
              this.dprepminute = (state.recipe.prepTimeMinutes % 60);
              this.dbakinghour = (state.recipe.bakingTimeMinutes ~/ 60);
              this.dbakingminute = (state.recipe.bakingTimeMinutes % 60);
              this.dresthour = (state.recipe.restingTimeMinutes ~/ 60);
              this.drestminute = (state.recipe.restingTimeMinutes % 60);
              Future<void> selectFile() async {
                CloudinaryResponse response = new CloudinaryResponse(
                    assetId: '',
                    publicId: "",
                    createdAt: DateTime.now(),
                    url: "",
                    secureUrl: "",
                    originalFilename: "");
                try {
                  var result = await FilePicker.platform.pickFiles(
                    type: FileType.any,
                    allowMultiple: false,
                  );
                  setState(() {
                    filePath = result!.paths.first!;
                    state.recipe.recipeThumbnail = filePath;
                  });
                  print(filePath + 'link anh ne');
                  file = result;
                } on Exception catch (e) {}
              }

              return Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(state.recipe.recipeThumbnail),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                            child: Container(
                              decoration: new BoxDecoration(
                                  color: Colors.black.withOpacity(0.2)),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          height: MediaQuery.of(context).size.height * 0.2,
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.75,
                                    child: Text(
                                      state.recipe.recipeTitle,
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ]),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'PortionType*',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 70,
                            height: MediaQuery.of(context).size.height / 20,
                            padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black38),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                value: portion,
                                icon: Icon(Icons.keyboard_arrow_down),
                                items: listportioncount.map((int items) {
                                  return DropdownMenuItem(
                                      value: items,
                                      child: Text(items.toString()));
                                }).toList(),
                                onChanged: (value) => setState(() {
                                  this.portion = value!;
                                  state.recipe.portionSize = portion;
                                }),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 110,
                            height: MediaQuery.of(context).size.height / 20,
                            padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black38),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: serving,
                                icon: Icon(Icons.keyboard_arrow_down),
                                items: listservings.map((String items) {
                                  return DropdownMenuItem(
                                      value: items,
                                      child: Text(items.toString()));
                                }).toList(),
                                onTap: () {
                                  print(portiontype.toString());
                                },
                                onChanged: (value) => setState(() {
                                  this.serving = value!;
                                  print(serving);
                                  this.serving == "serving"
                                      ? portiontype = 1
                                      : portiontype = 2;
                                  state.recipe.portionType =
                                      portiontype.toString();
                                  print(portiontype.toString());
                                }),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Difficulty',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomRadioButton(
                        wrapAlignment: WrapAlignment.start,
                        horizontal: false,
                        unSelectedBorderColor: Colors.black12,
                        selectedBorderColor: Colors.black12,
                        margin: EdgeInsets.fromLTRB(0, 0, 25, 10),
                        shapeRadius: 15,
                        spacing: 10,
                        radius: 15,
                        enableShape: true,
                        elevation: 0,
                        defaultSelected: difficulty,
                        enableButtonWrap: true,
                        autoWidth: true,
                        height: MediaQuery.of(context).size.height / 20,
                        unSelectedColor: Theme.of(context).canvasColor,
                        buttonLables: listDifficultys,
                        buttonValues: listDifficulty,
                        radioButtonValue: (value) {
                          difficulty = value as int;
                          state.recipe.recipeDifficulty = difficulty;
                          difficultys = listDifficultys[difficulty - 1];
                          print(difficulty);
                        },
                        selectedColor: kPrimaryButtonColorPicked,
                      ),
                      Text(
                        'Prep Time*',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 70,
                            height: MediaQuery.of(context).size.height / 20,
                            padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black38),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                value: (state.recipe.prepTimeMinutes) ~/ 60,
                                icon: Icon(Icons.keyboard_arrow_down),
                                items: hours.map((int items) {
                                  return DropdownMenuItem(
                                      value: items,
                                      child: Text(items.toString()));
                                }).toList(),
                                onChanged: (value) => setState(() {
                                  this.dprephour = value;
                                  state.recipe.prepTimeMinutes =
                                      state.recipe.prepTimeMinutes -
                                          (state.recipe.prepTimeMinutes ~/ 60) *
                                              60 +
                                          dprephour! * 60;
                                  print(state.recipe.prepTimeMinutes);
                                }),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('hours'),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 70,
                            height: MediaQuery.of(context).size.height / 20,
                            padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black38),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                value: state.recipe.prepTimeMinutes % 60,
                                icon: Icon(Icons.keyboard_arrow_down),
                                items: minutes.map((int items) {
                                  return DropdownMenuItem(
                                      value: items,
                                      child: Text(items.toString()));
                                }).toList(),
                                onChanged: (value) => setState(() {
                                  this.dprepminute = value;
                                  state.recipe.prepTimeMinutes =
                                      state.recipe.prepTimeMinutes -
                                          state.recipe.prepTimeMinutes % 60 +
                                          dprepminute!;
                                  print(state.recipe.prepTimeMinutes);
                                }),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('minutes'),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Baking Time',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 70,
                            height: MediaQuery.of(context).size.height / 20,
                            padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black38),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                value: state.recipe.bakingTimeMinutes ~/ 60,
                                icon: Icon(Icons.keyboard_arrow_down),
                                items: hours.map((int items) {
                                  return DropdownMenuItem(
                                      value: items,
                                      child: Text(items.toString()));
                                }).toList(),
                                onChanged: (value) => setState(() {
                                  this.dbakinghour = value;
                                  state.recipe.bakingTimeMinutes = state
                                          .recipe.bakingTimeMinutes -
                                      (state.recipe.bakingTimeMinutes ~/ 60) *
                                          60 +
                                      dbakinghour! * 60;
                                  print(state.recipe.bakingTimeMinutes);
                                }),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('hours'),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 70,
                            height: MediaQuery.of(context).size.height / 20,
                            padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black38),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                value: state.recipe.bakingTimeMinutes % 60,
                                icon: Icon(Icons.keyboard_arrow_down),
                                items: minutes1.map((int items) {
                                  return DropdownMenuItem(
                                      value: items,
                                      child: Text(items.toString()));
                                }).toList(),
                                onChanged: (value) => setState(() {
                                  this.dbakingminute = value;
                                  state.recipe.bakingTimeMinutes =
                                      state.recipe.bakingTimeMinutes -
                                          state.recipe.bakingTimeMinutes % 60 +
                                          dbakingminute!;
                                  print(state.recipe.bakingTimeMinutes);
                                }),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('minutes'),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Resting Time',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 70,
                            height: MediaQuery.of(context).size.height / 20,
                            padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black38),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                value: state.recipe.restingTimeMinutes ~/ 60,
                                icon: Icon(Icons.keyboard_arrow_down),
                                items: hours.map((int items) {
                                  return DropdownMenuItem(
                                      value: items,
                                      child: Text(items.toString()));
                                }).toList(),
                                onChanged: (value) => setState(() {
                                  this.dresthour = value;
                                  state.recipe.restingTimeMinutes = state
                                          .recipe.restingTimeMinutes -
                                      (state.recipe.restingTimeMinutes ~/ 60) *
                                          60 +
                                      dresthour! * 60;
                                  print(state.recipe.restingTimeMinutes);
                                }),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('hours'),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 70,
                            height: MediaQuery.of(context).size.height / 20,
                            padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black38),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                value: state.recipe.restingTimeMinutes % 60,
                                icon: Icon(Icons.keyboard_arrow_down),
                                items: minutes1.map((int items) {
                                  return DropdownMenuItem(
                                      value: items,
                                      child: Text(items.toString()));
                                }).toList(),
                                onChanged: (value) => setState(() {
                                  this.drestminute = value;
                                  state.recipe.restingTimeMinutes =
                                      state.recipe.restingTimeMinutes -
                                          state.recipe.restingTimeMinutes % 60 +
                                          drestminute!;
                                  print(state.recipe.restingTimeMinutes);
                                }),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('minutes'),
                        ],
                      ),
                    ],
                  )
                ]),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
        ),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 1,
            title: Text(''),
            content: BlocBuilder<EditRecipeBloc, EditRecipeState>(
                builder: (context, state) {
              if (state is EditRecipeStateLoadSuccess) {
                Future<void> _displayTextInputDialog(
                    BuildContext context, int pos) async {
                  return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Edit ' +
                              state.recipe.ingredients[pos].ingredientName +
                              ' amount'),
                          content: TextField(
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                valueText = value;
                              });
                            },
                            controller: _texteditFieldController,
                            decoration:
                                InputDecoration(hintText: "Input amount"),
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
                                  listIngredient[pos].amountInMg =
                                      int.parse(_texteditFieldController.text);
                                  print(listIngredient[pos]
                                          .amountInMg
                                          .toString() +
                                      " " +
                                      listIngredient[pos].ingredientName);
                                  _texteditFieldController.text = "";
                                  Navigator.pop(context);
                                });
                              },
                            ),
                          ],
                        );
                      });
                }

                listIngredient = state.recipe.ingredients;
                return Container(
                  height: MediaQuery.of(context).size.height*0.7,
                  child: ListView(
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Ingredients',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 30),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.2,
                                  child: Text(
                                    'Amount',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.55,
                                  child: Text(
                                    'Ingerdient*',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.2,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: amount,
                                    decoration: InputDecoration(
                                      hintText: '',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                        borderSide: BorderSide(),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('g'),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.55,
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: ingredient,
                                    decoration: InputDecoration(
                                      hintText: 'Add ingredient. e.g.flour',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                        borderSide: BorderSide(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    listIngredient.add(new Ingredient(
                                        ingredientName: ingredient.text,
                                        amountInMg: int.parse(amount.text)));
                                    ingredient.clear();
                                    amount.clear();
                                  });
                                  print(listIngredient[0].ingredientName);
                                },
                                child: Text('Add to your list'),
                              ),
                            )
                          ],
                        ),
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: listIngredient.length,
                        itemBuilder: (context, index) {
                          return SingleChildScrollView(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                    width: 1.0, color: Colors.black12),
                              )),
                              child: Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    child: Text(listIngredient[index]
                                        .amountInMg
                                        .toString(),style: TextStyle(fontSize: 15),),
                                  ),
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      child: Text('g',style: TextStyle(fontSize: 15),)),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Text(
                                        listIngredient[index].ingredientName,style: TextStyle(fontSize: 15),),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.edit,
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                      ),
                                      onPressed: () {
                                        _displayTextInputDialog(context, index);
                                      },
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.cancel_outlined,
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          listIngredient.removeAt(index);
                                        });
                                        print(listIngredient[0].ingredientName);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }
              return SizedBox();
            })),
        Step(
            state: currentStep > 2 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 2,
            title: Text(''),
            content: BlocBuilder<EditRecipeBloc, EditRecipeState>(
                builder: (context, state) {
              if (state is EditRecipeStateLoadSuccess) {
                Future<void> _displayTextInputDialog(
                    BuildContext context, int pos) async {
                  return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Edit step ' +
                              state.recipe.steps[pos].stepIndex.toString()),
                          content: Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: TextFormField(
                              maxLines: 10,
                              onChanged: (value) {
                                setState(() {
                                  valueText = value;
                                });
                              },
                              controller: _texteditFieldController,
                              decoration: InputDecoration(
                                  hintText: "Input step content"),
                            ),
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
                                  listStep[pos].stepContent =
                                      _texteditFieldController.text;
                                  print(listStep[pos].stepContent + "da sua");
                                  Navigator.pop(context);
                                });
                              },
                            ),
                          ],
                        );
                      });
                }

                for (int i = 0; i < state.recipe.steps.length; i++) {
                  if (listStep.length < state.recipe.steps.length) {
                    listStep.add(new CreateRecipeStep(
                        stepContent: state.recipe.steps[i].stepContent));
                    print(listStep[i].stepContent);
                  }
                }
                ;
                return Container(
                  height: MediaQuery.of(context).size.height*0.7,
                  child: ListView(
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Recipe Steps',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 30),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Add a Step',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 15),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.85,
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  child: TextFormField(
                                    onTap: () {
                                      setState(() {
                                        _stepvalidate = false;
                                      });
                                    },
                                    maxLines: 10,
                                    keyboardType: TextInputType.text,
                                    controller: stepcontent,
                                    decoration: InputDecoration(
                                      errorText: _stepvalidate
                                          ? 'Value Can\'t Be Empty'
                                          : null,
                                      hintText:
                                          'What need to be done in this step?',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                        borderSide: BorderSide(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    if (stepcontent.text.isEmpty) {
                                      _stepvalidate = true;
                                    } else {
                                      setState(() {
                                        listStep.add(new CreateRecipeStep(
                                            stepContent: stepcontent.text));
                                        _stepvalidate = false;
                                        stepcontent.clear();
                                      });
                                    }
                                  });
                                },
                                child: Text('Add to your list',style: TextStyle(fontSize: 15),),
                              ),
                            )
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: listStep.length,
                        itemBuilder: (context, index) {
                          return SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.only(bottom: 15, top: 15),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                    width: 1.0, color: Colors.black12),
                              )),
                              child: Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    child: Text('Step ' + (index+1).toString(),style: TextStyle(fontSize: 15),),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Text(listStep[index].stepContent,style: TextStyle(fontSize: 15),),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.edit,
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                      ),
                                      onPressed: () {
                                        _displayTextInputDialog(context, index);
                                      },
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.cancel_outlined,
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          listStep.removeAt(index);
                                          state.recipe.steps.removeAt(index);
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }
              return SizedBox();
            })),
        Step(
            isActive: currentStep >= 3,
            title: Text(''),
            content: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 4.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(filePath),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    title.text,
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.book,
                        size: MediaQuery.of(context).size.width * 0.025,
                      ),
                      SizedBox(width: 10,),
                      Text(
                        "Category: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(submitcategory.categoryName),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.disease,
                        size: MediaQuery.of(context).size.width * 0.025,
                      ),
                      SizedBox(width: 10,),
                      Text(
                        "Serving: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(portion.toString() + " " + serving),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.fire,
                        size: MediaQuery.of(context).size.width * 0.025,
                      ),
                      SizedBox(width: 10,),
                      Text(
                        "Difficulty: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(listDifficultys[difficulty - 1]),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.solidClock,
                        size: MediaQuery.of(context).size.width * 0.025,
                      ),
                      SizedBox(width: 10,),
                      Text(
                        "Preptime: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text((dprephour! * 60 + dprepminute!).toString() +
                          " minutes"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.solidClock,
                        size: MediaQuery.of(context).size.width * 0.025,
                      ),
                      SizedBox(width: 10,),
                      Text(
                        "Bakingtime: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text((dbakinghour! * 60 + dbakingminute!).toString() +
                          " minutes"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.solidClock,
                        size: MediaQuery.of(context).size.width * 0.025,
                      ),
                      SizedBox(width: 10,),
                      Text(
                        "Preptime: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text((dresthour! * 60 + drestminute!).toString() +
                          " minutes"),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.leaf,
                        size: MediaQuery.of(context).size.width * 0.025,
                      ),
                      SizedBox(width: 10,),
                      Text(
                        "Ingredients: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: listIngredient.length,
                      itemBuilder: (context, index) => Container(
                            child: Text(("- " +
                                    listIngredient[index]
                                        .amountInMg
                                        .toString() +
                                    "mg ") +
                                listIngredient[index].ingredientName),
                          )),
                  SizedBox(height: 20,),
                  Text(
                    "How to cook",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: listStep.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.2,
                                      child: Text(
                                     (index + 1).toString() + "/" + listStep.length.toString(),
                                    style: TextStyle(
                                        fontSize: 15, fontWeight: FontWeight.bold),
                                  )),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.8,
                                    child: Text(
                                      listStep[index].stepContent,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                ],
              ),
            )),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryButtonTextColor,
        foregroundColor: Colors.black,
        title: Text('Edit Recipe'),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: kPrimaryButtonColor2)),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Stepper(
            physics: ScrollPhysics(),
            type: StepperType.horizontal,
            steps: getSteps(),
            currentStep: currentStep,
            onStepContinue: () async {
              final isLastStep = currentStep == getSteps().length - 1;
              if (isLastStep) {
                {
                  if (file != null) {
                    for (PlatformFile file in file!.files) {
                      if (file.path != null) {
                        var response = await uploadFileOnCloudinary(
                          filePath: file.path.toString(),
                          resourceType: CloudinaryResourceType.Auto,
                        );
                        setState(() {
                          link = response.secureUrl;
                        });
                        _EditRecipeBloc.add(EditRecipeEvent(
                            EditRecipe(
                                recipeCategoriesId:
                                    submitcategory.categoryId.toString(),
                                recipeTitle: title.text,
                                recipeThumbnail: link.toString(),
                                steps: listStep,
                                recipeDifficulty: difficulty.toString(),
                                portionSize: portion.toString(),
                                portionType: portiontype.toString(),
                                prepTimeMinutes:
                                    (dprephour! * 60 + dprepminute!),
                                bakingTimeMinutes:
                                    (dbakinghour! * 60 + dbakingminute!),
                                restingTimeMinutes:
                                    (dresthour! * 60 + drestminute!),
                                ingredients: listIngredient),
                            recipeId!));
                        print(link);
                      }
                    }
                  } else {
                    _EditRecipeBloc.add(EditRecipeEvent(
                        EditRecipe(
                            recipeCategoriesId:
                                submitcategory.categoryId.toString(),
                            recipeTitle: title.text,
                            recipeThumbnail: filePath,
                            steps: listStep,
                            recipeDifficulty: difficulty.toString(),
                            portionSize: portion.toString(),
                            portionType: portiontype.toString(),
                            prepTimeMinutes: (dprephour! * 60 + dprepminute!),
                            bakingTimeMinutes:
                                (dbakinghour! * 60 + dbakingminute!),
                            restingTimeMinutes:
                                (dresthour! * 60 + drestminute!),
                            ingredients: listIngredient),
                        recipeId!));
                  }
                }
              } else {
                setState(() => currentStep += 1);
              }
            },
            onStepTapped: (step) => setState(() => currentStep = step),
            onStepCancel: currentStep == 0
                ? null
                : () => setState(() => currentStep -= 1),
            controlsBuilder: (context, {onStepContinue, onStepCancel}) {
              final isLastStep = currentStep == getSteps().length - 1;
              return Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    if (currentStep != 0)
                      Expanded(
                          child: ElevatedButton(
                        child: Text('Back'),
                        onPressed: onStepCancel,
                      )),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: BlocListener<EditRecipeBloc, EditRecipeState>(
                            listener: (context, state) {
                              print(state);
                              if (state is EditRecipeStateSuccess) {
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.success,
                                  text: "Edit Profile successful!",
                                  onConfirmBtnTap: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BlocProvider(
                                                  create: (context) =>
                                                      UserRecipesBloc()
                                                        ..add(
                                                            UserRecipesFetchEvent()),
                                                  child: UserRecipesScreen(),
                                                )));
                                  },
                                );
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => BlocProvider(
                                //               create: (context) => HomeBloc()
                                //                 ..add(HomeFetchEvent()),
                                //               child: MyHomePage(
                                //                 token: '123',
                                //               ),
                                //             )));
                              }
                            },
                            child: ElevatedButton(
                              child: Text(isLastStep ? 'EDIT' : 'NEXT'),
                              onPressed: onStepContinue,
                            ))),
                  ],
                ),
              );
            },
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
