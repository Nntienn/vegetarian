import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetarian/events/nearby_event.dart';
import 'package:vegetarian/models/nearby.dart';
import 'package:vegetarian/repositories/map_repository.dart';
import 'package:vegetarian/states/near_by_state.dart';


class NearByBloc extends Bloc<NearByBloc, NearByState> {
  NearByBloc() :super(NearByStateInitial());

  @override
  Stream<NearByState> mapEventToState(NearByBloc event) async* {
    if (event is NearByFetchEvent) {
      List<Result>? result = await getNearby(event.pos);
      if (result != null) {
        print(result.toString() + "AAAAAAAAAAAAAAAAAA");
        print("co menu");
        yield NearByStateSuccess(result, event.pos);
      }
    }
  }
}