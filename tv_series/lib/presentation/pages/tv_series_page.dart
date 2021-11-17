import 'package:core/core.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_home_bloc/tv_home_bloc.dart';

import '../../presentation/widgets/tv_series_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvSeriesPage extends StatefulWidget {
  const TvSeriesPage({Key? key}) : super(key: key);

  @override
  _TvSeriesPageState createState() => _TvSeriesPageState();
}

class _TvSeriesPageState extends State<TvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<AiringTodayTvHomeBloc>().add(
            FetchTvListHome(),
          ),
    );
    Future.microtask(
      () => context.read<PopularTvHomeBloc>().add(
            FetchTvListHome(),
          ),
    );
    Future.microtask(
      () => context.read<TopRatedTvHomeBloc>().add(
            FetchTvListHome(),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Airing Today',
            style: kHeading6,
          ),
          BlocBuilder<AiringTodayTvHomeBloc, TvHomeState>(
            builder: (context, state) {
              if (state is TvHomeLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TvHomeHasData) {
                return TvSeriesList(state.tv);
              } else {
                return Text('Failed');
              }
            },
          ),
          _buildSubHeading(
            title: 'Popular',
            onTap: () {
              Navigator.pushNamed(context, POPULAR_TV_ROUTE);
            },
          ),
          BlocBuilder<PopularTvHomeBloc, TvHomeState>(
            builder: (context, state) {
              if (state is TvHomeLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TvHomeHasData) {
                return TvSeriesList(state.tv);
              } else {
                return Text('Failed');
              }
            },
          ),
          _buildSubHeading(
            title: 'Top Rated',
            onTap: () {
              Navigator.pushNamed(context, TOP_RATED_TV_ROUTE);
            },
          ),
          BlocBuilder<TopRatedTvHomeBloc, TvHomeState>(
            builder: (context, state) {
              if (state is TvHomeLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TvHomeHasData) {
                return TvSeriesList(state.tv);
              } else {
                return Text('Failed');
              }
            },
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
              children: [
                Text('See More'),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
