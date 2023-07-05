// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'favorite_bloc.dart';

class FavoriteState {
  final List<dynamic> favoriteVideo;

  
  FavoriteState({
    required this.favoriteVideo,
  });
}

class FavoriteInitial extends FavoriteState {
  FavoriteInitial({required super.favoriteVideo});
}
