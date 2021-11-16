import 'package:core/core.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/bloc/movie_home_bloc/movie_home_bloc.dart';
import 'package:movies/presentation/widgets/movie_list.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<NowPlayingMovieHomeBloc>().add(
            FetchMovieListHome(),
          ),
    );
    Future.microtask(
      () => context.read<PopularMovieHomeBloc>().add(
            FetchMovieListHome(),
          ),
    );
    Future.microtask(
      () => context.read<TopRatedMovieHomeBloc>().add(
            FetchMovieListHome(),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Now Playing',
                    style: kHeading6,
                  ),
                  BlocBuilder<NowPlayingMovieHomeBloc, MovieHomeState>(
                      builder: (context, state) {
                    if (state is MovieHomeLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is MovieHomeHasData) {
                      return MovieList(state.movie);
                    } else {
                      return Text('Failed');
                    }
                  }),
                  _buildSubHeading(
                    title: 'Popular',
                    onTap: () =>
                        Navigator.pushNamed(context, POPULAR_MOVIES_ROUTE),
                  ),
                  BlocBuilder<PopularMovieHomeBloc, MovieHomeState>(
                      builder: (context, state) {
                    if (state is MovieHomeLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is MovieHomeHasData) {
                      return MovieList(state.movie);
                    } else {
                      return Text('Failed');
                    }
                  }),
                  _buildSubHeading(
                    title: 'Top Rated',
                    onTap: () =>
                        Navigator.pushNamed(context, TOP_RATED_MOVIE_ROUTE),
                  ),
                  BlocBuilder<TopRatedMovieHomeBloc, MovieHomeState>(
                      builder: (context, state) {
                    if (state is MovieHomeLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is MovieHomeHasData) {
                      return MovieList(state.movie);
                    } else {
                      return Text('Failed');
                    }
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}
