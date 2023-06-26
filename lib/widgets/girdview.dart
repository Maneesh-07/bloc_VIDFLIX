import 'package:bloc_VIDFLIX/functions/all_functions.dart';
import 'package:bloc_VIDFLIX/functions/thumbnail.dart';
import 'package:bloc_VIDFLIX/ui/setting_page_screen/setting_page.dart';
import 'package:bloc_VIDFLIX/ui/video_playing/video_play_screen.dart';
import 'package:flutter/material.dart';

class GridViewWidgetForAllVideos extends StatelessWidget {
  GridViewWidgetForAllVideos({super.key});

  @override
  Widget build(BuildContext context) {
    return allVideos.isEmpty
        ? Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.mood_bad_sharp,
                color: Colors.blueAccent,
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
        : Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: allVideos.length,
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return InkWell(
                    //liked and playlist
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => VideoShowingPage(
                                fromList: allVideos,
                                index: index,
                                seekFrom: 0,
                              )));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Stack(
                            children: [
                              Container(
                                color: allTextColor,
                                height: 95,
                                width: 150,
                                child: ThumbnailWidget(
                                    videoPath: allVideos[index]),
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
                        ListTile(
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
                            color: mainBGColor,
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: Text('Add to Favorites videos',
                                    style: TextStyle(color: allTextColor)),
                                onTap: () {
                                  addLikedVideo(
                                      context, allVideos[index]);
                                },
                              ),
                              PopupMenuItem(
                                child: Text('Add to Playlist',
                                    style: TextStyle(color: allTextColor)),
                                onTap: () {
                                  showDialougeOfPlaylist(context,
                                      videoIndex: index,
                                      listFrom: allVideos);
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ));
              },
            ),
          );
  }
}
