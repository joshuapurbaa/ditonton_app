import 'package:flutter/material.dart';
import 'package:tv_series/tv_series.dart';

class TvSeriesAirDate extends StatelessWidget {
  const TvSeriesAirDate({
    Key? key,
    required this.tvSeries,
  }) : super(key: key);

  final TvDetail tvSeries;

  @override
  Widget build(BuildContext context) {
    if (tvSeries.inProduction) {
      if (tvSeries.firstAirDate.toString().isNotEmpty) {
        var parseDate = tvSeries.firstAirDate;
        return Text('$parseDate - Now');
      } else {
        return Text('Unknown Date Production');
      }
    } else {
      return Text(
          '${tvSeries.firstAirDate.toString()} - ${tvSeries.lastAirDate.toString()}');
    }
  }
}
