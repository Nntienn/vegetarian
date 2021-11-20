import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetarian/events/visitor_profile_event.dart';
import 'package:vegetarian/repositories/recipes_repository.dart';
import 'package:vegetarian/repositories/users_repository.dart';
import 'package:vegetarian/states/visitor_profile_state.dart';

class VisitorProfileBloc extends Bloc<VisitorProfileEvent, VisitorProfileState> {
  final NUMBER_OF_COMMENTS_PER_PAGE = 10;
  //initial State
  VisitorProfileBloc():super(VisitorProfileStateInitial());
  @override
  Stream<VisitorProfileState> mapEventToState(VisitorProfileEvent event) async*{
    if(event is VisitorProfileFetchEvent &&
        !(state is VisitorProfileStateSuccess && (state as VisitorProfileStateSuccess).hasReachedEnd)) {
      try {
        //Check if "has reached end of a page"
        if(state is VisitorProfileStateInitial) {
          //first time loading page
          //1.get comments from API
          //2.yield CommentStateSuccess
          final list = await getRecipeVisitor(1, NUMBER_OF_COMMENTS_PER_PAGE,event.Id);
          final recipes = list!.listResult;
          final page = list.page;
          final user = await getUserbyID(event.Id);
          yield VisitorProfileStateSuccess(
              recipes: recipes,
              hasReachedEnd: false,
              page: page, user: user!, lastPage: event.lastPage, lastPageId: event.lastPageId,
            
          );
        } else if(state is VisitorProfileStateSuccess) {
          //load next page
          //if "next page is empty" => yield "CommentStateSuccess" with hasReachedEnd = true
          final currentState = state as VisitorProfileStateSuccess;
          int finalIndexOfCurrentPage = currentState.recipes.length;
          // double dpage = finalIndexOfCurrentPage / NUMBER_OF_COMMENTS_PER_PAGE;
          // int page = dpage.toInt();
          int page = currentState.page + 1;
          final list = await getRecipeVisitor(page, NUMBER_OF_COMMENTS_PER_PAGE,currentState.user.id);
          final recipes = list!.listResult;
          final user = await getUserbyID(currentState.user.id);
          if(list.totalPage < page) {
            //change current state !
            yield currentState.cloneWith(hasReachedEnd: true, recipes: currentState.recipes, page: page,user: user!, lastPageId: currentState.lastPageId,lastPage: currentState.lastPage);
          } else {
            //not empty, means "not reached end",
            yield VisitorProfileStateSuccess(
                recipes: currentState.recipes + recipes, //merge 2 arrays
                hasReachedEnd: false,
                page: page,
                user: user!
                , lastPageId: currentState.lastPageId,lastPage: currentState.lastPage
            );
          }
        }
      }catch(exception){
        yield VisitorProfileStateFailure();
      }
    }
  }
}