import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:vegetarian/Screens/MainScreen/main_screen.dart';
import 'package:vegetarian/blocs/create_recipe_bloc.dart';
import 'package:vegetarian/blocs/home_blocs.dart';
import 'package:vegetarian/events/create_recipe_events.dart';
import 'package:vegetarian/events/home_events.dart';
import 'package:vegetarian/models/create_recipe.dart';
import 'package:vegetarian/models/ingredient.dart';
import 'package:vegetarian/models/category.dart';
import 'package:vegetarian/states/create_recipe_state.dart';

class CreateRecipeScreen extends StatefulWidget {
  @override
  State<CreateRecipeScreen> createState() => _CreateRecipeScreenState();
}

class _CreateRecipeScreenState extends State<CreateRecipeScreen> {
  late CreateRecipeBloc _CreateRecipeBloc;
  bool _stepvalidate = false;
  int currentStep = 0;
  bool isCompleted = false;
  List<int> listportioncount = [];
  List<String> listservings = ['serving', 'pieces'];
  TextEditingController title = TextEditingController();
  final amount = TextEditingController();
  final ingredient = TextEditingController();
  final stepcontent = TextEditingController();
  int? portion = 2;
  int recipeStep = 1;
  int? dprephour = 0;
  int? dprepminute = 1;
  int? dbakinghour = 0;
  int? dbakingminute = 0;
  int? dresthour = 0;
  int? drestminute = 0;
  String? serving = 'serving';
  String? categoryName = '1 Food';
  String? submitContent = '';
  Category? category;

  Category submitcategory = Category(categoryId: 1, categoryName: '');

  int? categoryid = 1;
  int difficulty = 1;
  int portiontype = 1;
  String difficultys = '';
  List<int> listDifficulty = [1, 2, 3, 4, 5];
  List<int> hours = [];
  List<int> minutes = [];
  List<int> minutes1 = [];
  List<String> recipeStepContents = [];
  List<String> listDifficultys = [
    'Easy',
    'Medium',
    'Hard',
    'Gordon Ramsay',
    'Your Mom'
  ];
  List<Ingredient> listIngredient = [];
  List<String> categoryTitle = [];

  @override
  void initState() {
    super.initState();
    _CreateRecipeBloc = BlocProvider.of(context);
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
            content: Container(
              height: MediaQuery.of(context).size.height * 0.65,
              child: ListView(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Basic',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          )
                        ],
                      ),
                    ),
                    Text(
                      'Name your recipe*',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onFieldSubmitted: (value) {
                        setState(() {
                          this.title.text = value;
                        });
                      },
                      controller: title,
                      decoration: InputDecoration(
                        hintText: 'E.g Coob Salad',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Category',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<CreateRecipeBloc, CreateRecipeState>(
                        builder: (context, state) {
                      if (state is CreateRecipeStateLoadSuccess) {
                        // categoryName = state.list[0];
                        return Container(
                          // width: 200,
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
                              items: state.list.map((Category items) {
                                return DropdownMenuItem(
                                    value: items,
                                    child: Text(items.categoryName));
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  this.category = value;
                                  this.submitcategory = value!;
                                  print(this.category!.categoryId);
                                });
                              },
                            ),
                          ),
                        );
                      }
                      return SizedBox(
                        height: 10,
                      );
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'PortionType*',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 70,
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
                              onChanged: (value) =>
                                  setState(() => this.portion = value),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 110,
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
                              onChanged: (value) => setState(() {
                                this.serving = value;
                                this.serving == "serving"
                                    ? portiontype = 1
                                    : portiontype = 2;
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomRadioButton(
                          margin: EdgeInsets.fromLTRB(0, 0, 00, 10),
                          shapeRadius: 15,
                          spacing: 10,
                          radius: 15,
                          enableShape: true,
                          elevation: 0,
                          defaultSelected: difficulty,
                          enableButtonWrap: true,
                          autoWidth: true,
                          height: 50,
                          unSelectedColor: Theme.of(context).canvasColor,
                          buttonLables: listDifficultys,
                          buttonValues: listDifficulty,
                          radioButtonValue: (value) {
                            difficulty = value as int;
                            difficultys = listDifficultys[difficulty - 1];
                            print(difficulty);
                          },
                          selectedColor:
                              Theme.of(context).colorScheme.secondary,
                        ),
                      ],
                    ),
                    Text(
                      'Prep Time*',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 70,
                          padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black38),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<int>(
                              value: dprephour,
                              icon: Icon(Icons.keyboard_arrow_down),
                              items: hours.map((int items) {
                                return DropdownMenuItem(
                                    value: items,
                                    child: Text(items.toString()));
                              }).toList(),
                              onChanged: (value) =>
                                  setState(() => this.dprephour = value),
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
                          padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black38),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<int>(
                              value: dprepminute,
                              icon: Icon(Icons.keyboard_arrow_down),
                              items: minutes.map((int items) {
                                return DropdownMenuItem(
                                    value: items,
                                    child: Text(items.toString()));
                              }).toList(),
                              onChanged: (value) =>
                                  setState(() => this.dprepminute = value),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 70,
                          padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black38),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<int>(
                              value: dbakinghour,
                              icon: Icon(Icons.keyboard_arrow_down),
                              items: hours.map((int items) {
                                return DropdownMenuItem(
                                    value: items,
                                    child: Text(items.toString()));
                              }).toList(),
                              onChanged: (value) =>
                                  setState(() => this.dbakinghour = value),
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
                          padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black38),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<int>(
                              value: dbakingminute,
                              icon: Icon(Icons.keyboard_arrow_down),
                              items: minutes1.map((int items) {
                                return DropdownMenuItem(
                                    value: items,
                                    child: Text(items.toString()));
                              }).toList(),
                              onChanged: (value) =>
                                  setState(() => this.dbakingminute = value),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 70,
                          padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black38),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<int>(
                              value: dresthour,
                              icon: Icon(Icons.keyboard_arrow_down),
                              items: hours.map((int items) {
                                return DropdownMenuItem(
                                    value: items,
                                    child: Text(items.toString()));
                              }).toList(),
                              onChanged: (value) =>
                                  setState(() => this.dresthour = value),
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
                          padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black38),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<int>(
                              value: drestminute,
                              icon: Icon(Icons.keyboard_arrow_down),
                              items: minutes1.map((int items) {
                                return DropdownMenuItem(
                                    value: items,
                                    child: Text(items.toString()));
                              }).toList(),
                              onChanged: (value) =>
                                  setState(() => this.drestminute = value),
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
                ),
              ]),
            )),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 1,
            title: Text(''),
            content: Column(
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
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.57,
                            child: Text(
                              'Ingerdient*',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
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
                          Text('Mg'),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.57,
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
                                  amountInMg: amount.text));
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
                Container(
                  height: 300,
                  child: ListView.builder(
                    itemCount: listIngredient.length,
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                            bottom:
                                BorderSide(width: 1.0, color: Colors.black12),
                          )),
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.15,
                                child: Text(listIngredient[index].amountInMg),
                              ),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                  child: Text('mg')),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child:
                                    Text(listIngredient[index].ingredientName),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.cancel_outlined,
                                    size: MediaQuery.of(context).size.width *
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
                ),
              ],
            )),
        Step(
            isActive: currentStep >= 2,
            title: Text(''),
            content: Column(
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
                            height: MediaQuery.of(context).size.height * 0.2,
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
                                hintText: 'What need to be done in this step?',
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
                                  recipeStepContents.add(stepcontent.text);
                                  _stepvalidate = false;
                                  stepcontent.clear();
                                  print(recipeStepContents[0]);
                                });
                              }
                            });
                          },
                          child: Text('Add to your list'),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: ListView.builder(
                    itemCount: recipeStepContents.length,
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                            bottom:
                                BorderSide(width: 1.0, color: Colors.black12),
                          )),
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.15,
                                child: Text('Step ' + index.toString()),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Text(recipeStepContents[index]),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.cancel_outlined,
                                    size: MediaQuery.of(context).size.width *
                                        0.05,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      recipeStepContents.removeAt(index);
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
                ),
              ],
            )),
        Step(
            isActive: currentStep >= 3,
            title: Text(''),
            content: Container(
              height: MediaQuery.of(context).size.height * 0.65,
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(title.text,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    ],
                  ),
                  Text(submitcategory.categoryName),
                  Text(portion.toString() + " " + serving!),
                  Text("Difficulty: " + difficultys),
                  Text("Preptime: " +
                      (dprephour! * 60 + dprepminute!).toString() +
                      " minutes"),
                  Text("Bakingtime: " +
                      (dbakinghour! * 60 + dbakingminute!).toString() +
                      " minutes"),
                  Text("Preptime: " +
                      (dresthour! * 60 + drestminute!).toString() +
                      " minutes"),
                  ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: listIngredient.length,
                      itemBuilder: (context, index) => Container(
                            child: Text(listIngredient[index].amountInMg +
                                "mg " +
                                listIngredient[index].ingredientName),
                          )),
                  ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        for (int i = 0; i < recipeStepContents.length; i++) {
                          print(submitContent);
                          print(recipeStepContents.length.toString());
                          if (i == 0) {
                            submitContent = ('<h2>Step' +
                                (i + 1).toString() +
                                '</h2><p>' +
                                recipeStepContents[i] +
                                '</p>');
                          } else {
                            submitContent = (submitContent! +
                                '<h2>Step' +
                                (i + 1).toString() +
                                '</h2><p>' +
                                recipeStepContents[i] +
                                '</p>');
                          }
                        }
                        ;
                        return Container(
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Html(data: submitContent),
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
        title: Text('Create Recipe'),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: Colors.greenAccent)),
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
                  _CreateRecipeBloc.add(CreateRecipeEvent(CreateRecipe(
                      userId: 1,
                      recipeCategoriesId: submitcategory.categoryId.toString(),
                      recipeTitle: title.text,
                      recipeThumbnail: "desau",
                      recipeContent: submitContent.toString(),
                      recipeDifficulty: difficulty.toString(),
                      portionType: portion.toString(),
                      portionSize: portiontype.toString(),
                      prepTimeMinutes: (dprephour! * 60 + dprepminute!).toString(),
                      bakingTimeMinutes: (dbakinghour! * 60 + dbakingminute!).toString(),
                      restingTimeMinutes:(dresthour! * 60 + drestminute!).toString(),
                      ingredients: listIngredient)));
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
                margin: EdgeInsets.only(top: 50),
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
                    Expanded(child:BlocListener<CreateRecipeBloc, CreateRecipeState>(
                        listener: (context, state) {
                          print(state);
                          if (state is CreateRecipeStateSuccess) {
                            Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (context) => BlocProvider(
                              create: (context) =>
                              HomeBloc()..add(HomeFetchEvent()),
                              child: MyHomePage(token: '123',
                              ),
                            )));
                          }
                        },
                        child: ElevatedButton(
                      child: Text(isLastStep ? 'CREATE' : 'NEXT'),
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
