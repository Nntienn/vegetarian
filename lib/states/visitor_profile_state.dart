import 'package:equatable/equatable.dart';
import 'package:vegetarian/models/recipes_card.dart';
import 'package:vegetarian/models/user.dart';

abstract class VisitorProfileState extends Equatable {
  const VisitorProfileState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class VisitorProfileStateInitial extends VisitorProfileState {}

class VisitorProfileStateFailure extends VisitorProfileState {}

class VisitorProfileStateSuccess extends VisitorProfileState {
  final List<RecipesCard> recipes;
  final bool hasReachedEnd;
  final int page;
  final User user;
  final String lastPage;
  final int lastPageId;

  const VisitorProfileStateSuccess(
      {required this.recipes, required this.hasReachedEnd,required this.page,required this.user,required this.lastPage,required  this.lastPageId, });

  @override
  String toString() => "comments : $recipes, hasReachedEnd: $hasReachedEnd, page: $page";

  @override
  // TODO: implement props
  List<Object> get props => [recipes, hasReachedEnd, page];

  VisitorProfileStateSuccess cloneWith(
      {required List<RecipesCard> recipes, required bool hasReachedEnd, required int page,required User user,required String lastPage,required int lastPageId,}) {
    return VisitorProfileStateSuccess(
        hasReachedEnd: hasReachedEnd,
        recipes: recipes, page: page,
        user: user, lastPageId: lastPageId, lastPage: lastPage,

    );
  }
}