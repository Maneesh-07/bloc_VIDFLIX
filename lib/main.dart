import 'package:bloc_VIDFLIX/bloc/bottom_nav/bottom_navbar_bloc.dart';
import 'package:bloc_VIDFLIX/bloc/favorite_video/favorite_bloc.dart';
import 'package:bloc_VIDFLIX/bloc/playlist/playlist_bloc.dart';
import 'package:bloc_VIDFLIX/bloc/playlist_inner/playlist_inner_video_bloc.dart';
import 'package:bloc_VIDFLIX/bloc/search_video/search_bloc.dart';
import 'package:bloc_VIDFLIX/functions/all_functions.dart';
import 'package:bloc_VIDFLIX/model/model_file.dart';
import 'package:bloc_VIDFLIX/ui/setting_page_screen/setting_page.dart';
import 'package:bloc_VIDFLIX/ui/splash_page/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(FavoritesVideoAdapter().typeId)) {
    Hive.registerAdapter(FavoritesVideoAdapter());
  }
  if (!Hive.isAdapterRegistered(PlayListAdapter().typeId)) {
    Hive.registerAdapter(PlayListAdapter());
  }
  if (!Hive.isAdapterRegistered(LastPlayedAdapter().typeId)) {
    Hive.registerAdapter(LastPlayedAdapter());
  }
  if (!Hive.isAdapterRegistered(VideoHistoryAdapter().typeId)) {
    Hive.registerAdapter(VideoHistoryAdapter());
  }

  await Hive.openBox<FavoritesVideo>('liked_video');
  await Hive.openBox<PlayList>('playlist_video');
  await Hive.openBox<LastPlayed>('last_played');
  await Hive.openBox<VideoHistory>('video_History');
  getEverthing();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BottomNavbarBloc(),
        ),
        BlocProvider(
          create: (context) => FavoriteBloc(),
        ),
        BlocProvider(
          create: (context) => PlaylistBloc(),
        ),
        BlocProvider(
          create: (context) => PlaylistInnerVideosBloc(),
        ),
        BlocProvider(
          create: (context) => SearchBloc(),
        ),
      ],
      child: MaterialApp(
          // color: mainBGColor,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: AppBarColor,
            // appBarTheme: AppBarTheme(
            //   color: isDarkMode.value
            //       ? Color.fromARGB(255, 6, 3, 17)
            //       : mainBGColor,
            // ),
          ),
          home: const Splashscreen()),
    );
  }
}
