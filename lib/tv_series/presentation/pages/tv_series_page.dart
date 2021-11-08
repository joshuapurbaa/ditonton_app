import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/tv_series/presentation/pages/popular_tv_series_page.dart';
import 'package:ditonton/tv_series/presentation/pages/top_rated_tv_page.dart';
import 'package:ditonton/tv_series/presentation/provider/list_tv_notifier.dart';
import 'package:ditonton/tv_series/presentation/widgets/tv_series_list.dart';
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
    Future.microtask(() => Provider.of<TVListNotifier>(context, listen: false)
      ..fetchAiringTodayTVs()
      ..fetchPopularTVs()
      ..fetchTopRatedTVs());
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
          Consumer<TVListNotifier>(
            builder: (context, data, child) {
              final state = data.airingTodayTVsState;
              if (state == RequestState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.Loaded) {
                return TvSeriesList(data.airingTodayTVs);
              } else {
                return Text('Failed');
              }
            },
          ),
          _buildSubHeading(
            title: 'Popular',
            onTap: () {
              Navigator.pushNamed(context, PopularTvPage.ROUTE_NAME);
            },
          ),
          Consumer<TVListNotifier>(
            builder: (context, data, child) {
              final state = data.popularTVsState;
              if (state == RequestState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.Loaded) {
                return TvSeriesList(data.popularTVs);
              } else {
                return Text('Failed');
              }
            },
          ),
          _buildSubHeading(
            title: 'Top Rated',
            onTap: () {
              Navigator.pushNamed(context, TopRatedTvPage.ROUTE_NAME);
            },
          ),
          Consumer<TVListNotifier>(builder: (context, data, child) {
            final state = data.topRatedTVsState;
            if (state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state == RequestState.Loaded) {
              return TvSeriesList(data.topRatedTVs);
            } else {
              return Text('Failed');
            }
          }),
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
