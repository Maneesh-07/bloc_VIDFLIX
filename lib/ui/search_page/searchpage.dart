import 'dart:developer';

import 'package:bloc_VIDFLIX/bloc/search_video/search_bloc.dart';
import 'package:bloc_VIDFLIX/functions/all_functions.dart';
import 'package:bloc_VIDFLIX/functions/thumbnail.dart';
import 'package:bloc_VIDFLIX/ui/setting_page_screen/setting_page.dart';
import 'package:bloc_VIDFLIX/ui/video_playing/video_play_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  TextEditingController searchController = TextEditingController();

  List searchList = List<String>.from(allVideos);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bottomNavColor,
      appBar: AppBar(
        backgroundColor: AppBarColor,
        title: Padding(
          padding: const EdgeInsets.only(right: 50),
          child: Center(child: Text('Search')),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                BlocProvider.of<SearchBloc>(context)
                    .add(SearchTextChanged(value));
              },
              controller: searchController,
              autofocus: true,
              decoration: const InputDecoration(
                  labelText: 'Search',
                  labelStyle: TextStyle(color: Colors.purple),
                  border: OutlineInputBorder()),
              style: TextStyle(color: allTextColor),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchPageState>(
              builder: (context, state) {
                log('$state');
                return state.results.isEmpty
                    ? Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.mood_bad_sharp,
                            color: Colors.purple,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'There Is No Videos',
                            style: TextStyle(fontSize: 20, color: allTextColor),
                          ),
                        ],
                      ))
                    : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ListTile(
                            //liked and playlist
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => VideoShowingPage(
                                        fromList: state.results,
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
                                        videoPath: state.results[index]),
                                  ),
                                  Positioned(
                                      bottom: 5,
                                      right: 5,
                                      child: VideoDuration(
                                        videoPath: state.results[index],
                                      ))
                                ],
                              ),
                            ),
                            title: Text(
                              getVideoName(state.results[index]),
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
                                    child: Text('Add to liked videos',
                                        style: TextStyle(color: allTextColor)),
                                    onTap: () {
                                      addLikedVideo(
                                          context, state.results[index]);
                                    }),
                                PopupMenuItem(
                                  child: Text('Add to Playlist',
                                      style: TextStyle(color: allTextColor)),
                                  onTap: () {
                                    showDialougeOfPlaylist(context,
                                        videoIndex: index,
                                        listFrom: state.results);
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
                        itemCount: state.results.length);
              },
            ))
          ],
        ),
      ),
    );
  }
}
