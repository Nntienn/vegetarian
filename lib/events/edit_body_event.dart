import 'package:vegetarian/blocs/edit_basic_profile_bloc.dart';
import 'package:vegetarian/blocs/edit_body_bloc.dart';
import 'package:vegetarian/blocs/edit_recipe_bloc.dart';
import 'package:vegetarian/models/edit_recipe.dart';

class EditBodyEvent extends EditBodyBloc {
  final int height;
  final double weight;
  final int typeWorkout;

  EditBodyEvent(this.height, this.weight, this.typeWorkout);
}

class EditBodyFetchEvent extends EditBodyBloc {}
