import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/tv_series/presentation/provider/search_tv_notifier.dart';
import 'package:ditonton/tv_series/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          TextField(
            onSubmitted: (query) {
              Provider.of<MovieSearchNotifier>(context, listen: false)
                  .fetchMovieSearch(query);
              Provider.of<TvSearchNotifier>(context, listen: false)
                  .fetchTvSearch(query);
            },
            decoration: InputDecoration(
              hintText: 'Search title',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.search,
          ),
          SizedBox(height: 16),
          Text(
            'Movie Result...',
            style: kHeading6,
          ),
          Consumer<MovieSearchNotifier>(
            builder: (context, data, child) {
              if (data.state == RequestState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (data.state == RequestState.Loaded) {
                final result = data.searchResult;
                return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final movie = data.searchResult[index];
                    return MovieCard(movie);
                  },
                  itemCount: result.length,
                );
              } else {
                return Container();
              }
            },
          ),
          Text(
            'Tv Series Result...',
            style: kHeading6,
          ),
          Consumer<TvSearchNotifier>(
            builder: (context, data, child) {
              if (data.state == RequestState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (data.state == RequestState.Loaded) {
                final result = data.searchResult;
                return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final tv = data.searchResult[index];
                    return TvCard(tv);
                  },
                  itemCount: result.length,
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
