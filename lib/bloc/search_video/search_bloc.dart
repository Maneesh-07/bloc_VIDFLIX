import 'package:bloc/bloc.dart';
import 'package:bloc_VIDFLIX/functions/all_functions.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchPageEvent, SearchPageState> {
  SearchBloc()
      : super(SearchInitialState(List<String>.from(allVideos))) {
    on<SearchTextChanged>((event, emit) {
      List<dynamic> searchList = allVideos
          .where((element) => getVideoName(element)
              .toLowerCase()
              .contains(event.searchTerm.toLowerCase()))
          .toList();
      return emit(SearchPageState(searchList));
    });
  }

  
}

