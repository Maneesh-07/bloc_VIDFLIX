import 'package:bloc_VIDFLIX/bloc/bottom_nav/bottom_navbar_bloc.dart';
import 'package:bloc_VIDFLIX/functions/all_functions.dart';
import 'package:bloc_VIDFLIX/ui/browse_page/browsefavoritepage.dart';
import 'package:bloc_VIDFLIX/ui/home_video_list/videolist.dart';
import 'package:bloc_VIDFLIX/ui/more_page/morepage.dart';
import 'package:bloc_VIDFLIX/ui/movie_list_page/movie_main.dart';
import 'package:bloc_VIDFLIX/ui/playlist_page/playlistmain.dart';
import 'package:bloc_VIDFLIX/ui/setting_page_screen/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
 

  List page = [
    HomeVideolist(),
    MovieScreen(),
    BrowseFavoritepage(),
    PlaylistScreen(),
    Morescreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavbarBloc, BottomNavbarState>(
          builder: (context, state) {
            return Scaffold(
              body: page.elementAt(state.navBarIndex),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: bottomNavColor,
                selectedIconTheme: IconThemeData(color: Colors.white),
                unselectedIconTheme:
                    IconThemeData(color: Color.fromARGB(255, 199, 199, 199)),
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey,
                showUnselectedLabels: true,
                currentIndex: state.navBarIndex,
                onTap:  (int bottomIndex) {
              BlocProvider.of<BottomNavbarBloc>(context)
                  .add(OnTappedEvent(navBarIndex: bottomIndex));
            },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.video_collection_rounded,
                    ),
                    label: 'Video',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.local_movies_outlined,
                    ),
                    label: 'Movies',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.favorite_sharp,
                    ),
                    label: 'Favorites',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.playlist_play_rounded,
                    ),
                    label: 'Platlists',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.more_vert_outlined,
                    ),
                    label: 'More',
                  ),
                ],
              ),
              floatingActionButton:
                  state.navBarIndex == 1 ? Text('') : ResumeButton(),
            );
          },
        );
  }

 
}
