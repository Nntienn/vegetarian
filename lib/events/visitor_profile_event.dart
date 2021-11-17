import 'package:equatable/equatable.dart';
import 'package:vegetarian/blocs/visitor_profile_bloc.dart';

abstract class VisitorProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class VisitorProfileFetchEvent extends VisitorProfileEvent{
  final String lastPage;
  final int lastPageId;
  final int Id;
  VisitorProfileFetchEvent(this.Id, this.lastPage, this.lastPageId);
}