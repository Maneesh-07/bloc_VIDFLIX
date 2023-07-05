import 'dart:developer';
import 'package:bloc_VIDFLIX/bloc/playlist/playlist_bloc.dart';
import 'package:bloc_VIDFLIX/bloc/playlist_inner/playlist_inner_video_bloc.dart';
import 'package:bloc_VIDFLIX/functions/all_functions.dart';
import 'package:bloc_VIDFLIX/functions/thumbnail.dart';
import 'package:bloc_VIDFLIX/ui/playlist_page/playlistscreen.dart';
import 'package:bloc_VIDFLIX/ui/setting_page_screen/setting_page.dart';
import 'package:bloc_VIDFLIX/ui/video_playing/video_play_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListViewWidgetForAllVideos extends StatelessWidget {
  const ListViewWidgetForAllVideos({super.key});

  @override
  Widget build(BuildContext context) {
    log(allVideos.toString());
    return allVideos.isEmpty
        ? Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.mood_bad_sharp,
                color: Color.fromARGB(255, 209, 14, 0),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'No Videos In your list',
                style: TextStyle(fontSize: 20, color: allTextColor),
              ),
            ],
          ))
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: containerColor,
                ),
                child: Center(
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => VideoShowingPage(
                                fromList: allVideos,
                                index: index,
                                seekFrom: 0,
                              )));
                    },
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Stack(
                        children: [
                          Container(
                            color: Colors.black,
                            height: 95,
                            width: 100,
                            child: ThumbnailWidget(videoPath: allVideos[index]),
                          ),
                          Positioned(
                              bottom: 5,
                              right: 5,
                              child: VideoDuration(
                                videoPath: allVideos[index],
                              ))
                        ],
                      ),
                    ),
                    title: Text(
                      getVideoName(allVideos[index]),
                      style: TextStyle(color: allTextColor),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: PopupMenuButton(
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.grey,
                      ),
                      color: bottomNavColor,
                      itemBuilder: (context) => [
                        PopupMenuItem(
                            child: Text('Add to Favorites videos',
                                style: TextStyle(color: allTextColor)),
                            onTap: () {
                              addLikedVideo(context, allVideos[index]);
                            }),
                        PopupMenuItem(
                          child: Text('Add to Playlist',
                              style: TextStyle(color: allTextColor)),
                          onTap: () {
                            showDialougeOfPlaylist(context,
                                videoIndex: index, listFrom: allVideos);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            // separatorBuilder: (context, index) {
            //   return Divider(
            //     color: allTextColor,
            //   );
            // },
            itemCount: allVideos.length);
  }
}

//playlist section list view widget
class ListViewWidgetForPlaylist extends StatelessWidget {
  const ListViewWidgetForPlaylist({super.key});

  @override
  Widget build(BuildContext context) {
    //.........................................................................................
    return playlistKey.isEmpty
        ? Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.mood_bad_sharp,
                color: Color.fromARGB(255, 202, 13, 0),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Playlist Is Empty',
                style: TextStyle(fontSize: 20, color: allTextColor),
              ),
            ],
          ))
        : BlocBuilder<PlaylistBloc, PlaylistState>(
            builder: (context, state) {
              return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Playlistpage(
                                  playlistIndex: index,
                                )));
                      },
                      leading: const Icon(
                        Icons.playlist_play,
                        color: Color.fromARGB(255, 212, 14, 0),
                        size: 60,
                      ),
                      title: Text(
                        playlistKey[index],
                        style: TextStyle(color: allTextColor),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: PopupMenuButton(
                        icon: const Icon(
                          Icons.more_vert,
                          color: Colors.grey,
                        ),
                        color: mainBGColor,
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              child: Text('Rename Playlist',
                                  style: TextStyle(color: allTextColor)),
                              onTap: () {
                                renamePlaylist(index, context);
                              }),
                          PopupMenuItem(
                            child: Text('Delete Playlist',
                                style: TextStyle(color: allTextColor)),
                            onTap: () {
                              snackBarMessage(
                                  context, 'Removed "${playlistKey[index]}"');
                              log('Playlist "${playlistKey[index]}" Deleted');
                              deletePlaylistHive(index, context);
                              // isListView.notifyListeners();
                            },
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: allTextColor,
                    );
                  },
                  itemCount: state.playlistKey.length);
            },
          );
  }
}

//inner playlist section list view widget
// ignore: must_be_immutable
class ListViewWidgetForInnerPlaylist extends StatelessWidget {
  ListViewWidgetForInnerPlaylist({
    super.key,
    required this.fromPlaylistName,
  });

  String fromPlaylistName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBGColor,
      appBar: AppBar(
        title: Text(
          "Playlist",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppBarColor,
      ),
      body: playlist[fromPlaylistName]!.isEmpty
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.mood_bad_sharp,
                  color: Color.fromARGB(255, 208, 14, 0),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'No Videos In This Playlist',
                  style: TextStyle(fontSize: 20, color: allTextColor),
                ),
              ],
            ))
          : BlocBuilder<PlaylistInnerVideosBloc, PlaylistInnerVideosState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          //liked and playlist
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => VideoShowingPage(
                                      fromList: playlist[fromPlaylistName]!,
                                      index: index,
                                      seekFrom: 0,
                                    )));
                          },
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: Stack(
                              children: [
                                Container(
                                  color: Colors.black,
                                  height: 95,
                                  width: 100,
                                  child: ThumbnailWidget(
                                      videoPath:
                                          playlist[fromPlaylistName]![index]),
                                ),
                                Positioned(
                                    bottom: 5,
                                    right: 5,
                                    child: VideoDuration(
                                      videoPath:
                                          playlist[fromPlaylistName]![index],
                                    ))
                              ],
                            ),
                          ),
                          title: Text(
                            getVideoName(playlist[fromPlaylistName]![index]),
                            style: TextStyle(color: allTextColor),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: PopupMenuButton(
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.grey,
                            ),
                            color: mainBGColor,
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: Text(
                                  'Remove From Playlist',
                                  style: TextStyle(color: allTextColor),
                                ),
                                onTap: () {
                                  log('video Removed From "$fromPlaylistName"');
                                  snackBarMessage(context,
                                      'video Removed From "$fromPlaylistName"');

                                  deleteVideoFromPlaylist(
                                      index, fromPlaylistName, context);
                                },
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: allTextColor,
                        );
                      },
                      itemCount: state.playlist.isEmpty
                          ? playlist[fromPlaylistName]!.length
                          : state.playlist.length),
                );
              },
            ),
    );
  }
}
