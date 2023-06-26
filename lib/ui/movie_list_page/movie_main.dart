
import 'package:bloc_VIDFLIX/Infrastructure/api_keys.dart';
import 'package:bloc_VIDFLIX/ui/movie_list_page/toprated_list.dart';
import 'package:bloc_VIDFLIX/ui/movie_list_page/trending_list.dart';
import 'package:bloc_VIDFLIX/ui/movie_list_page/tv.dart';
import 'package:bloc_VIDFLIX/widgets/appbarWidget.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({
    super.key,
  });

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  List treandingmovielist = [];
  List topratedmovies = [];
  List tvlist = [];

 
  @override
  void initState() {
    loadMovieList();
    super.initState();
  }

  loadMovieList() async {
    TMDB tmdbWithCustomsLogs = TMDB(ApiKeys(apiKey, readaccessToken),
        logConfig: ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
        ));

    Map trendingresults = await tmdbWithCustomsLogs.v3.trending.getTrending();
    Map topratedresults = await tmdbWithCustomsLogs.v3.movies.getTopRated();
    Map tvresults = await tmdbWithCustomsLogs.v3.tv.getPopular();

    setState(() {
      treandingmovielist = trendingresults['results'];
      topratedmovies = topratedresults['results'];
      tvlist = tvresults['results'];
    });
    print(treandingmovielist);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        child: MovieListAppbar(),
        preferredSize: Size.fromHeight(70.0),
      ),
      body: ListView(
        children: [
          TvScreen(tv: tvlist),
          TopRatedScreen(toprated: topratedmovies),
          TrendingScreen(trending: treandingmovielist),
        ],
      ),
    );
  }
}
