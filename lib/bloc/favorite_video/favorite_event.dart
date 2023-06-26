// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteEvent {}

class AddfavoriteVideo extends FavoriteEvent {
  final String videoPath;
  AddfavoriteVideo({
    required this.videoPath,
  });
}

class RemoveFavoriteVideo extends FavoriteEvent {
  final String videoPath;
  RemoveFavoriteVideo({
    required this.videoPath,
  });
}
