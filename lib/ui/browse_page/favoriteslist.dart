import 'package:bloc_VIDFLIX/bloc/favorite_video/favorite_bloc.dart';
import 'package:bloc_VIDFLIX/functions/all_functions.dart';
import 'package:bloc_VIDFLIX/functions/thumbnail.dart';
import 'package:bloc_VIDFLIX/ui/setting_page_screen/setting_page.dart';
import 'package:bloc_VIDFLIX/ui/video_playing/video_play_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return favoritesVideoNotify.isEmpty
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
                'No Favorites Videos Selected Yet',
                style: TextStyle(fontSize: 20, color: allTextColor),
              ),
            ],
          ))
        : BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => VideoShowingPage(
                                  fromList: state.favoriteVideo,
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
                              child: ThumbnailWidget(videoPath: state.favoriteVideo[index]),
                            ),
                            Positioned(
                                bottom: 5,
                                right: 5,
                                child: VideoDuration(
                                  videoPath: state.favoriteVideo[index],
                                ))
                          ],
                        ),
                      ),
                      title: Text(
                        getVideoName(state.favoriteVideo[index]),
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
                            child: Text('Remove Favorites videos',
                                style: TextStyle(color: allTextColor)),
                            onTap: () {
                              removeLikedVideo(index, context);
                            },
                          ),
                          PopupMenuItem(
                            child: Text('Add to Playlist',
                                style: TextStyle(color: allTextColor)),
                            onTap: () {
                              showDialougeOfPlaylist(context,
                                  videoIndex: index, listFrom: state.favoriteVideo);
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
                  itemCount: state.favoriteVideo.length);
            },
          );
  }
}
