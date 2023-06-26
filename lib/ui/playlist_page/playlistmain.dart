
import 'package:bloc_VIDFLIX/functions/all_functions.dart';
import 'package:bloc_VIDFLIX/model/model_file.dart';
import 'package:bloc_VIDFLIX/ui/setting_page_screen/setting_page.dart';
import 'package:bloc_VIDFLIX/widgets/appbarWidget.dart';
import 'package:bloc_VIDFLIX/widgets/list_view.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final playlistController = TextEditingController();
    return ValueListenableBuilder(
        valueListenable: isListView,
        builder: (context, value, child) {
          return Scaffold(
              backgroundColor: mainBGColor,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(70.0), // here the desired height
                child: NewappbarWidgets02(),
              ),

              // backgroundColor: bottomNavColor,
              body: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: ListViewWidgetForPlaylist(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FloatingActionButton.extended(
                            backgroundColor: Color.fromARGB(237, 176, 12, 0),
                            label: Text('Add Playlist'),
                            onPressed: () {
                              final playlistBox =
                                  Hive.box<PlayList>('playlist_video'); //hive
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Center(
                                      child: SizedBox(
                                    height: 200,
                                    width: 300,
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextField(
                                              autofocus: true,
                                              decoration: InputDecoration(
                                                  labelText: 'Playlist Name',
                                                  border: OutlineInputBorder()),
                                              controller: playlistController,
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      playlistController
                                                          .clear();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('cancel')),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      if (playlistController
                                                                  .text
                                                                  .trim() !=
                                                              '' &&
                                                          !playlistKey.contains(
                                                              playlistController
                                                                  .text
                                                                  .trim())) {
                                                        final playlistModel =
                                                            PlayList(
                                                                playlistName:
                                                                    playlistController
                                                                        .text,
                                                                videosList: []);

                                                        playlistBox.add(
                                                            playlistModel); //hive
                                                        addplaylist(
                                                            playlistController
                                                                .text
                                                                .trim());

                                                        playlistController
                                                            .clear();
                                                        Navigator.of(context)
                                                            .pop();
                                                        
                                                      }
                                                    },
                                                    child: Text('add')),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ));
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 5,
                    ),
                  ],
                ),
              ));
        });
  }
}
