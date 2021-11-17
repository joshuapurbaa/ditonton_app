import 'package:core/presentation/main_page.dart';
import 'package:core/presentation/watchlist_bloc/watchlist_movie_bloc.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';

import 'package:core/utils/state_enum.dart';
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
      Provider.of<WatchlistTvNotifier>(context, listen: false)
          .fetchWatchlistTv();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistMovieBloc>().add(GetWatchListMovieData());
    Provider.of<WatchlistTvNotifier>(context, listen: false).fetchWatchlistTv();
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
              if (state is WatchlistLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is WatchlistHasData) {
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
              } else if (state is WatchlistError) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return Center(
                  child: Text('Empty Data'),
                );
              }
            },
          ),
          // Consumer<WatchlistMovieNotifier>(
          //   builder: (context, data, child) {
          //     if (data.watchlistState == RequestState.Loading) {
          //       return Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     } else if (data.watchlistState == RequestState.Loaded) {
          //       return ListView.builder(
          //         shrinkWrap: true,
          //         physics: NeverScrollableScrollPhysics(),
          //         itemBuilder: (context, index) {
          //           final movie = data.watchlistMovies[index];
          //           return MovieCard(movie);
          //         },
          //         itemCount: data.watchlistMovies.length,
          //       );
          //     } else {
          //       return Center(
          //         key: Key('error_message'),
          //         child: Text(data.message),
          //       );
          //     }
          //   },
          // ),
          Text(
            'Tv Series',
            style: kHeading6,
          ),
          SizedBox(
            height: 10,
          ),
          Consumer<WatchlistTvNotifier>(
            builder: (context, data, child) {
              if (data.watchlistState == RequestState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (data.watchlistState == RequestState.Loaded) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final tv = data.watchlistTv[index];
                    return TvCard(tv);
                  },
                  itemCount: data.watchlistTv.length,
                );
              } else {
                return Center(
                  key: Key('error_message'),
                  child: Text(data.message),
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
