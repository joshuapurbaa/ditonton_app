import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/tv_series/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:search/presentation/bloc/search_movie_bloc.dart';
import 'package:search/presentation/bloc/search_tv_bloc.dart';

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
            onChanged: (query) {
              context.read<SearchMovieBloc>().add(OnQueryMovieChanged(query));
              context.read<SearchTvBloc>().add(OnQueryTvChanged(query));
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
          BlocBuilder<SearchMovieBloc, SearchMovieState>(
            builder: (context, state) {
              if (state is SearchMovieLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SearchMovieHasData) {
                final result = state.result;
                return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final movie = result[index];
                    return MovieCard(movie);
                  },
                  itemCount: result.length,
                );
              } else if (state is SearchMovieNoData) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state is SearchMovieError) {
                return Center(
                  child: Text(state.message),
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
          BlocBuilder<SearchTvBloc, SearchTvState>(
            builder: (context, state) {
              if (state is SearchTvLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SearchTvHasData) {
                final result = state.result;
                return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final tv = result[index];
                    return TvCard(tv);
                  },
                  itemCount: result.length,
                );
              } else if (state is SearchTvNoData) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state is SearchTvError) {
                return Center(
                  child: Text(state.message),
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
