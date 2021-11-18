import 'package:core/presentation/main_page.dart';
import 'package:core/presentation/watchlist_bloc/watchlist_movie_bloc.dart';
import 'package:core/presentation/watchlist_bloc/watchlist_tv_bloc.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';

import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/widgets/movie_card_list.dart';
import 'package:provider/provider.dart';
import 'package:tv_series/tv_series.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-page';

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Future.microtask(() =>
          context.read<WatchlistMovieBloc>().add(GetWatchListMovieData()));

      Future.microtask(
          () => context.read<WatchlistTvBloc>().add(GetWatchListTvData()));
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistMovieBloc>().add(GetWatchListMovieData());
    context.read<WatchlistTvBloc>().add(GetWatchListTvData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(color: kOxfordBlue),
            child: Text(
              'Movies',
              style: kHeading6,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
            builder: (context, state) {
              if (state is WatchlistMovieLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is WatchlistMovieHasData) {
                return state.result.length < 1
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) => MainPage()));
                          },
                          child: Text(
                            'Masih kosong...\n Cari Movies...',
                            style: kSubtitle,
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: kOxfordBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final movie = state.result[index];
                          return MovieCard(movie);
                        },
                        itemCount: state.result.length,
                      );
              } else if (state is WatchlistMovieError) {
                return Center(
                  key: Key('error_message'),
                  child: Text(state.message),
                );
              } else {
                return Center(
                  child: Text('Empty Data'),
                );
              }
            },
          ),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(color: kOxfordBlue),
            child: Text(
              'Tv Series',
              style: kHeading6,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
            builder: (context, state) {
              if (state is WatchlistTvLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is WatchlistTvHasData) {
                return state.result.length < 1
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) => MainPage()));
                          },
                          child: Text(
                            'Masih kosong...\n Cari Tv...',
                            style: kSubtitle,
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: kOxfordBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final tv = state.result[index];
                          return TvCard(tv);
                        },
                        itemCount: state.result.length,
                      );
              } else if (state is WatchlistTvError) {
                return Center(
                  key: Key('error_message'),
                  child: Text(state.message),
                );
              } else {
                return Center(
                  child: Text('Empty Data'),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
