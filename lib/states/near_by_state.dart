import 'package:vegetarian/models/list_ingredient_name.dart';
import 'package:vegetarian/models/nearby.dart';
import 'package:vegetarian/models/weekly_menu.dart';


class NearByState {
  const NearByState();
}

class NearByStateInitial extends NearByState {
}
class NearByStateFailure extends NearByState {}
class NearByStateSuccess extends NearByState {
  final List<Result> result;
  NearByStateSuccess( this.result);
}