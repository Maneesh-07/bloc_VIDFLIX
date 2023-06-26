import 'package:bloc/bloc.dart';
import 'package:bloc_VIDFLIX/functions/all_functions.dart';
import 'package:meta/meta.dart';

part 'playlist_inner_video_event.dart';
part 'playlist_inner_video_state.dart';

class PlaylistInnerVideosBloc
    extends Bloc<PlaylistInnerVideosEvent, PlaylistInnerVideosState> {
  PlaylistInnerVideosBloc()
      : super(PlaylistInnerVideosInitial(playlist: [])) {
    on<RemoveVideo>((event, emit) {
      List<dynamic> tempList;
      tempList = playlist[event.playlistName]!;
      tempList.removeAt(event.index);
      return emit(PlaylistInnerVideosState(playlist: tempList));
    });
  }
}

