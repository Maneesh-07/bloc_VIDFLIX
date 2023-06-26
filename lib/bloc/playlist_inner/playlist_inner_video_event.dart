part of 'playlist_inner_video_bloc.dart';

@immutable
abstract class PlaylistInnerVideosEvent {}

class RemoveVideo extends PlaylistInnerVideosEvent {
  final String playlistName;
  final int index;

  RemoveVideo({required this.playlistName, required this.index});
}
