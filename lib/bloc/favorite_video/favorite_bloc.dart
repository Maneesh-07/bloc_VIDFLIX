import 'package:bloc/bloc.dart';
import 'package:bloc_VIDFLIX/functions/all_functions.dart';
import 'package:meta/meta.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial(favoriteVideo: favoritesVideoNotify)) {
    on<FavoriteEvent>((event, emit) {

    });
  }
}
