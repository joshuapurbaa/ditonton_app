import 'package:movies/presentation/provider/watchlist_movie_notifier.dart';
import 'package:core/styles/text_styles.dart';

import 'package:core/utils/state_enum.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
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
      Provider.of<WatchlistMovieNotifier>(context, listen: false)
          .fetchWatchlistMovies();
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
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
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
        padding: EdgeInsets.all(8),
        children: [
          Text(
            'Movies',
            style: kHeading6,
          ),
          SizedBox(
            height: 10,
          ),
          Consumer<WatchlistMovieNotifier>(
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
                    final movie = data.watchlistMovies[index];
                    return MovieCard(movie);
                  },
                  itemCount: data.watchlistMovies.length,
                );
              } else {
                return Center(
                  key: Key('error_message'),
                  child: Text(data.message),
                );
              }
            },
          ),
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